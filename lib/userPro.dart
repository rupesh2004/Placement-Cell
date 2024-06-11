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
      logoUrl: data['logoUrl'] ?? 'https://example.com/default_logo.png',
    );
  }
}

class _UserProfileState extends State<UserProfilePage> {
  late List<Company> companies;
  List<String> list = <String>['Sign Out'];
  String dropdownValue = '';
  GlobalKey _popupMenuKey = GlobalKey();
  String userEmail = 'No Email';
  String userPhone = 'No Phone Number';
  String profileImageUrl = 'https://example.com/default_profile_image.png'; // Default image URL

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
    }
  }

  void fetchUserAppliedCompanies(String userPhone) async {
    QuerySnapshot responsesSnapshot = await FirebaseFirestore.instance
        .collection('studResponses')
        .where('mobileNo', isEqualTo: userPhone)
        .get();

    List<String> companyIds = responsesSnapshot.docs
        .map((doc) => doc['companyId'] as String)
        .toList();

    QuerySnapshot companySnapshot = await FirebaseFirestore.instance
        .collection('companies')
        .where(FieldPath.documentId, whereIn: companyIds)
        .get();

    setState(() {
      companies = companySnapshot.docs
          .map((doc) => Company.fromFirestore(doc))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
        body: Container(
          child: Column(
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
                        Container(
                          child: Positioned(
                            top: 65,
                            left: 20,
                            right: 0,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: SizedBox(
                                width: 120,
                                height: 120,
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundImage: NetworkImage(
                                    profileImageUrl,
                                  ),
                                ),
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
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: companies.length,
                  itemBuilder: (context, index) {
                    return CompanyWidget(
                      company: companies[index],
                      onBookmarkPressed: () {
                        setState(() {
                          companies[index].isBookmarked =
                              !companies[index].isBookmarked;
                        });
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CompanyWidget extends StatelessWidget {
  final Company company;
  final VoidCallback onBookmarkPressed;

  const CompanyWidget({
    required this.company,
    required this.onBookmarkPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      child: Row(
        children: [
          Image.network(
            company.logoUrl,
            width: 100,
            height: 130,
            fit: BoxFit.fill,
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    company.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  // Additional company details can be added here
                ],
              ),
            ),
          ),
          IconButton(
            onPressed: onBookmarkPressed,
            icon: company.isBookmarked
                ? const Icon(
                    Icons.bookmark,
                    color: Colors.blue,
                  )
                : const Icon(
                    Icons.bookmark_outline,
                  ),
            color: company.isBookmarked ? Colors.blue : null,
            iconSize: 30,
          )
        ],
      ),
    );
  }
}
