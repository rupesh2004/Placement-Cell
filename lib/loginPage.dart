import 'package:company/ForgetPasswordPage.dart';
import 'package:company/SignUp.dart';
import 'package:company/adminLogin.dart';
import 'package:company/bottomNavigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isObscure = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkCurrentUser();
    });
  }

  void checkCurrentUser() {
    User? user = _auth.currentUser;
    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const BottomNavigator()),
      );
    }
  }

  adminLogin() {
  final String email = _emailController.text.trim();
  final String password = _passwordController.text;
  if (email == "admin@gmail.com" && password == "admin") {
    // Navigate to a different screen for admin
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AdminPage()), // Changed to AdminLogin()
    );
  } else {
    // If not admin, proceed with regular sign-in
    _signIn(context, email, password);
  }
}


  void _signIn(BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      Fluttertoast.showToast(
        msg: "Logged In Successfully",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );

      // Navigate to the appropriate screen after successful sign-in
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BottomNavigator()),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'An error occurred, please try again later.';
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided for that user.';
      }
      Fluttertoast.showToast(
        msg: errorMessage,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("User Login"),
          backgroundColor: const Color.fromARGB(176, 17, 60, 232),
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
                            "Welcome Back",
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
                          child: Column(
                            children: [
                              TextField(
                                controller: _emailController,
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 239, 232, 232),
                                  border: OutlineInputBorder(),
                                  labelText: 'Email',
                                  prefixIcon: Icon(Icons.email),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const SizedBox(height: 10),
                              TextField(
                                controller: _passwordController,
                                obscureText: _isObscure,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 239, 232, 232),
                                  labelText: 'Password',
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.green),
                                  ),
                                  prefixIcon: const Icon(Icons.lock),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _isObscure = !_isObscure;
                                      });
                                    },
                                    child: Icon(_isObscure
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 20),
                          child: GestureDetector(
                            onTap: () {
                              // Navigate to the new page here
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ForgotPassword()),
                              );
                            },
                            child: const Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'Forget Password?',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Color.fromARGB(255, 31, 86, 237)),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          width: double
                              .infinity, // Set width to match parent width
                          child: ElevatedButton(
                            onPressed: () {
                              adminLogin();
                            },
                            style: ElevatedButton.styleFrom(
                              primary: const Color.fromARGB(176, 17, 60, 232),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    6), // Set border radius here
                              ),
                            ),
                            child: const Text(
                              "Sign In",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: const Text(
                            "OR CONTINUE WITH",
                            style: TextStyle(
                                fontSize: 12,
                                color: Color.fromARGB(126, 34, 30, 30)),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 50, right: 50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  //signInWithGoogle();

                                  try {} catch (e) {
                                    Fluttertoast.showToast(
                                      msg:
                                          "Failed to sign in with Google. Please try again later.",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                    );
                                  }
                                },
                                child: Image.asset(
                                  'assets/images/google.png', // Path to Google image asset
                                  width: 40, // Set width of the image
                                  height: 40, // Set height of the image
                                ),
                              ),
                              Image.asset(
                                'assets/images/fb.png', // Path to Google image asset
                                width: 40, // Set width of the image
                                height: 40, // Set height of the image
                              ),
                              Image.asset(
                                'assets/images/apple.png', // Path to Google image asset
                                width: 40, // Set width of the image
                                height: 40, // Set height of the image
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Container(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Don't have no account?",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Color.fromARGB(126, 34, 30, 30)),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const SignUpPage()));
                                  },
                                  child: const Text(
                                    "Sign up",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color:
                                            Color.fromARGB(255, 31, 86, 237)),
                                  ),
                                ),
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
