import 'package:company/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _mobileNoController = TextEditingController();
  File? _imageFile;
  bool _isObscure = true;
  bool _isChecked = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  Future<void> _pickImage() async {
     final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1024,
      maxHeight: 1024,
    );

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<String> _uploadImage() async {
    if (_imageFile == null) {
      return ''; // Return empty string if no image is selected
    }

    Reference ref = FirebaseStorage.instance
        .ref()
        .child('user_images')
        .child(DateTime.now().toString() + '.jpg');
    UploadTask uploadTask = ref.putFile(_imageFile!);

    TaskSnapshot snapshot = await uploadTask.whenComplete(() {});
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  void _createUser() async {
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();
    final String mobileNo = _mobileNoController.text.trim();

    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      Navigator.pop(context);
      Fluttertoast.showToast(
        msg: "Please enter a valid email address",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
      return;
    }

    if (password.length < 6) {
      Navigator.pop(context);
      Fluttertoast.showToast(
        msg: "Password must be at least 6 characters long",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
      return;
    }

    if (!RegExp(r'^[0-9]{10}$').hasMatch(mobileNo)) {
      Navigator.pop(context);
      Fluttertoast.showToast(
        msg: "Please enter a valid mobile number",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      String imageUrl = await _uploadImage();

      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'email': email,
        'mobileNo': mobileNo,
        'imageUrl': imageUrl,
      });

      Navigator.pop(context);
      Fluttertoast.showToast(
        msg: "User Registered",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(
          msg: "The password provided is too weak.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
        );
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
          msg: "The account already exists for that email.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
        );
      }
    } catch (e) {
      Navigator.pop(context);
      Fluttertoast.showToast(
        msg: "Error creating user: $e.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
        backgroundColor: Color.fromARGB(176, 17, 60, 232),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 140,
                child: Image.asset(
                  'assets/images/rit.jpg',
                  height: 140,
                  fit: BoxFit.fitHeight,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Hello!",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 6),
              Text(
                "Welcome",
                style: TextStyle(
                    fontSize: 20, color: Color.fromARGB(126, 34, 30, 30)),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(255, 239, 232, 232),
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _mobileNoController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(255, 239, 232, 232),
                  border: OutlineInputBorder(),
                  labelText: 'Mobile No.',
                  prefixIcon: Icon(Icons.phone_android),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _passwordController,
                obscureText: _isObscure,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(255, 239, 232, 232),
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: GestureDetector(
                    onTap: _togglePasswordVisibility,
                    child: Icon(
                        _isObscure ? Icons.visibility : Icons.visibility_off),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Upload Image'),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Checkbox(
                    value: _isChecked,
                    onChanged: (value) {
                      setState(() {
                        _isChecked = value ?? false;
                      });
                    },
                  ),
                  Text("I agree with Terms and Conditions"),
                ],
              ),
            
              SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isChecked ? _createUser : null,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(6), // Set border radius here
                    ),
                    primary: Color.fromARGB(176, 17, 60, 232),
                    foregroundColor: Colors.white,
                  ),
                  child: Text("Sign Up", style: TextStyle(fontSize: 18)),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  "OR CONTINUE WITH",
                  style: TextStyle(
                      fontSize: 12, color: Color.fromARGB(126, 34, 30, 30)),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    'assets/images/google.png',
                    width: 40,
                    height: 40,
                  ),
                  Image.asset(
                    'assets/images/fb.png',
                    width: 40,
                    height: 40,
                  ),
                  Image.asset(
                    'assets/images/apple.png',
                    width: 40,
                    height: 40,
                  ),
                ],
              ),
              SizedBox(height: 20),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: Text(
                    "Already have an account? Sign in",
                    style: TextStyle(
                        fontSize: 15, color: Color.fromARGB(255, 31, 86, 237)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
