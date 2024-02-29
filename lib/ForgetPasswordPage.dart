import 'package:company/ForgetPasswordPage.dart';
import 'package:company/loginPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ForgotPassword());
}

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Forget Password"),
          backgroundColor: const Color.fromARGB(255, 86, 232, 207),
          foregroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 140,
                  child: Row(
                    children: [
                      Expanded(
                        child: Image.asset(
                          'assets/images/rit.jpg',
                          height: 140,
                          fit: BoxFit.fitHeight,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 20),
                          child: const Text(
                            "Hello!",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 20),
                          child: const Text(
                            "Reset Your Password",
                            style: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(126, 34, 30, 30)),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          child:const  Column(
                            children: [
                              TextField(
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 239, 232, 232),
                                  border: OutlineInputBorder(),
                                  labelText: 'Email',
                                  prefixIcon: Icon(Icons.email),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        
                        Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          width: double
                              .infinity, // Set width to match parent width
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              primary: const Color.fromARGB(176, 17, 60, 232),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    6), // Set border radius here
                              ),
                            ),
                            child: const Text(
                              "Send E-Mail",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        
                        const SizedBox(height: 30,),
                        Container(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Remember Password?",
                          
                          style: TextStyle(fontSize: 15,
                          color: Color.fromARGB(126, 34, 30, 30)),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>const  LoginPage()),
                            );
                          },
                          child: const Text(
                            "Sign In",
                            style: TextStyle(
                                fontSize: 15,
                             color: Color.fromARGB(255, 31, 86, 237)
                                ),
                          ),
                        )
                      ]),
                ),
                        
                      
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
