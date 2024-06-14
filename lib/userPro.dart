import 'package:company/loginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfileState();
}

class Company {
  final String name;
  final String logoUrl;
  bool isBookmarked;

  Company({
    required this.name,
    required this.logoUrl,
    this.isBookmarked = false,
  });

  factory Company.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Company(
      name: data['name'] ?? 'No Name',
      logoUrl: data['logo_url'] ?? 'https://example.com/default_logo.png',
    );
  }
}

class _UserProfileState extends State<UserProfilePage> {
  late List<Company> companies;
  List<String> list = <String>['Sign Out'];
  GlobalKey _popupMenuKey = GlobalKey();
  String userEmail = 'No Email';
  String userPhone = 'No Phone Number';
  String profileImageUrl = 'https://example.com/default_profile_image.png'; // Default image URL
  bool isLoading = true; // Loading indicator

  void openDropdownMenu() {
    dynamic popupMenuState = _popupMenuKey.currentState;
    popupMenuState.showButtonMenu();
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  @override
  void initState() {
    super.initState();
    companies = [];
    fetchUserDetails();
  }

  void fetchUserDetails() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        if (userDoc.exists) {
          setState(() {
            userEmail = userDoc['email']?.toString() ?? 'No Email';
            userPhone = userDoc['mobileNo']?.toString() ?? 'No Phone Number';
            profileImageUrl = userDoc['imageUrl']?.toString() ??
                'https://example.com/default_profile_image.png';
          });
          fetchUserAppliedCompanies(userPhone);
        } else {
          setState(() {
            userEmail = user.email ?? 'No Email';
            userPhone = user.phoneNumber ?? 'No Phone Number';
          });
        }
      } catch (e) {
        print('Error fetching user details: $e');
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  void fetchUserAppliedCompanies(String userPhone) async {
    try {
      QuerySnapshot responsesSnapshot = await FirebaseFirestore.instance
          .collection('studResponses')
          .where('phone', isEqualTo: userPhone)
          .get();

      if (responsesSnapshot.docs.isEmpty) {
        print('No applications found for this user.');
        setState(() {
          isLoading = false;
        });
        return;
      }

      List<String> companyNames = responsesSnapshot.docs
          .map((doc) => doc['company'] as String)
          .toList();

      if (companyNames.isNotEmpty) {
        QuerySnapshot companySnapshot = await FirebaseFirestore.instance
            .collection('companies')
            .where('name', whereIn: companyNames)
            .get();

        setState(() {
          companies = companySnapshot.docs
              .map((doc) => Company.fromFirestore(doc))
              .toList();
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching applied companies: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> showCancelApplicationDialog(Company company) async {
    TextEditingController reasonController = TextEditingController();

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap a button to dismiss the dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Cancel Application'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to cancel your application to ${company.name}?'),
                TextField(
                  controller: reasonController,
                  decoration: InputDecoration(hintText: 'Reason for cancellation'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
            TextButton(
              child: Text('Confirm'),
              onPressed: () {
                String reason = reasonController.text.trim();
                if (reason.isNotEmpty) {
                  deleteApplication(company, reason);
                  Navigator.of(context).pop(); // Dismiss the dialog
                } else {
                  // Show a message to the user that reason is required
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Reason is required to cancel application.')),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> deleteApplication(Company company, String reason) async {
    try {
      QuerySnapshot responsesSnapshot = await FirebaseFirestore.instance
          .collection('studResponses')
          .where('phone', isEqualTo: userPhone)
          .where('company', isEqualTo: company.name)
          .get();

      if (responsesSnapshot.docs.isNotEmpty) {
        // Delete the application from the Firestore database
        for (DocumentSnapshot doc in responsesSnapshot.docs) {
          await doc.reference.delete();
        }

        // Remove the company from the local list
        setState(() {
          companies.remove(company);
        });

        // Optionally, log or store the cancellation reason
        // For now, just print it to the console
        print('Application to ${company.name} cancelled for reason: $reason');
      }
    } catch (e) {
      print('Error deleting application: $e');
      // Show an error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to cancel application. Please try again later.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "User's Profile",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            key: _popupMenuKey,
            onSelected: (value) {
              if (value == 'Sign Out') {
                signOut();
              }
            },
            itemBuilder: (BuildContext context) {
              return list.map((String value) {
                return PopupMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(8.0),
              children: [
                Stack(
                  children: [
                    Container(
                      height: 200,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            right: 0,
                            child: Image.asset(
                              "assets/images/backImage.jpg",
                              width: double.infinity,
                              height: 120,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Positioned(
                            top: 65,
                            left: 20,
                            right: 0,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: CircleAvatar(
                                radius: 40,
                                backgroundImage: NetworkImage(
                                  profileImageUrl,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(left: 30),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      userEmail,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 30),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      userPhone,
                      style: const TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 159, 161, 159)),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 30, top: 20),
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Applied Companies',
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                if (companies.isEmpty)
                  const Center(child: Text('No applied companies found.')),
                ...companies.map((company) {
                  return Card(
                    child: ListTile(
                      leading: Image.network(
                        company.logoUrl,
                        width: 50,
                        height: 50,
                      ),
                      title: Text(
                        company.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          setState(() {
                            company.isBookmarked = !company.isBookmarked;
                          });
                        },
                        icon: company.isBookmarked
                            ? const Icon(
                                Icons.bookmark,
                                color: Colors.blue,
                              )
                            : const Icon(
                                Icons.bookmark_outline,
                              ),
                      ),
                      onTap: () {
                        showCancelApplicationDialog(company);
                      },
                    ),
                  );
                }).toList(),
              ],
            ),
    );
  }
}
