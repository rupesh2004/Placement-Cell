import 'package:flutter/material.dart';

void main() {
  runApp(const UserProfile());
}

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: RichText(
              text: const TextSpan(
                text: "User's Profile",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                // Add your action here
              },
              icon: const Icon(Icons.more_vert),
            ),
          ],
        ),
        body: Center(
            child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Image.network('https://media.licdn.com/dms/image/D4D16AQE8PJ9tT-pLww/profile-displaybackgroundimage-shrink_350_1400/0/1700799198816?e=1715817600&v=beta&t=ZEkigCna451AI7aKt9EK-FwlzRCtbOrFIyT-ydhdPao',
                    width: double.infinity,height: 250,),
                ],
              ),
            ],
          ),
        )),
      ),
    );
  }
}
