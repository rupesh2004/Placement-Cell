import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company/bottomNavigator.dart';
import 'package:company/homePage.dart';
import 'package:flutter/material.dart';

class ApplyForm extends StatefulWidget {
  final String companyName;

  const ApplyForm({Key? key, required this.companyName}) : super(key: key);
  @override
  State<ApplyForm> createState() => _ApplyForm();
}

class _ApplyForm extends State<ApplyForm> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  String selectedGender = 'Male'; // Initialized with a default value
  String selectedYear = 'Second Year';

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  bool isLoading = false;
  void submitApplication(ApplicationData applicationData) {
    setState(() {
      isLoading = true; // Show loader
    });

    FirebaseFirestore.instance
        .collection('studResponses')
        .add(applicationData.toMap())
        .then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Application Submitted Successfully")));
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => BottomNavigator()));
    }).catchError((error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Application not Submitted")));
    })
      ..whenComplete(() {
        setState(() {
          isLoading = false; // Hide loader when operation is complete
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "User Information",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          leading: const Icon(Icons.arrow_back_sharp),
        ),
        body: Container(
          // color: Colors.grey,
          child: Stack(children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "First Name",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    TextField(
                      controller: firstNameController,
                      decoration: InputDecoration(
                        // contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 12),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(5)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(5)),
                        hintText: "First Name",
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Last Name",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    TextField(
                      controller: lastNameController,
                      decoration: InputDecoration(
                          // contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(5)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(5)),
                          hintText: "Last Name"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Gender",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            DropdownButton(
                              hint: Text("Select Gender"),
                              value: selectedGender,
                              items: const [
                                DropdownMenuItem(
                                  child: Text("Male"),
                                  value: "Male",
                                ),
                                DropdownMenuItem(
                                  child: Text("Female"),
                                  value: "Female",
                                ),
                                DropdownMenuItem(
                                  child: Text("Other"),
                                  value: "Other",
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  selectedGender = value.toString();
                                });
                              },
                            )
                          ],
                        ),
                        // SizedBox(width: 40,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Year",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            DropdownButton(
                              hint: Text("Select Year"),
                              value: selectedYear,
                              items: const [
                                DropdownMenuItem(
                                  child: Text("Second Year"),
                                  value: "Second Year",
                                ),
                                DropdownMenuItem(
                                  child: Text("Third Year"),
                                  value: "Third Year",
                                ),
                                DropdownMenuItem(
                                  child: Text("Final Year"),
                                  value: "Final Year",
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  selectedYear = value.toString();
                                });
                              },
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Contact Details",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Contact Email",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                          // contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 12),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(5)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(5)),
                          hintText: "Your Mail"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Contact Phone",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          // contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(5)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(5)),
                          hintText: "Enter Phone",
                          prefixText: "+91"),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 250,
                            height: 50,
                            child: OutlinedButton(
                              style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.blue),
                                foregroundColor:
                                    MaterialStatePropertyAll(Colors.white),
                              ),
                              onPressed: () {
                                ApplicationData applicationData =
                                    ApplicationData(
                                        firstName: firstNameController.text,
                                        lastName: lastNameController.text,
                                        gender: selectedGender,
                                        year: selectedYear,
                                        email: emailController.text,
                                        phone: phoneController.text,
                                        companyName: widget.companyName);

                                // Submit the application data to Firebase
                                submitApplication(applicationData);
                              },
                              child: const Text(
                                "Submit Application",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (isLoading)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ]),
        ));
  }
}

class ApplicationData {
  final String firstName;
  final String lastName;
  final String gender;
  final String year;
  final String email;
  final String phone;
  final String companyName;

  ApplicationData(
      {required this.firstName,
      required this.lastName,
      required this.gender,
      required this.year,
      required this.email,
      required this.phone,
      required this.companyName});

  // Convert the application data to a map for Firebase
  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'gender': gender,
      'year': year,
      'email': email,
      'phone': phone,
      'company': companyName
    };
  }
}
