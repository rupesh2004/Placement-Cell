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
            IconButton(
              onPressed: () {
                // Add your action here
              },
              icon: const Icon(Icons.more_vert),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              // Background image
              Image.network(
                "https://media.licdn.com/dms/image/D4D16AQE8PJ9tT-pLww/profile-displaybackgroundimage-shrink_350_1400/0/1700799198816?e=1715817600&v=beta&t=ZEkigCna451AI7aKt9EK-FwlzRCtbOrFIyT-ydhdPao",
                width: double.infinity,
                height: 120,
                fit: BoxFit.fill,
              ),
              // Overlay image
              Positioned(
                top: 35, // Adjust the top position to place it on top of the first image
                left: 0,
                right: 0,
                child: Center(
                  child: Image.network(
                    "https://media.licdn.com/dms/image/D4D03AQF3IxNkwo8VdQ/profile-displayphoto-shrink_400_400/0/1708500069972?e=1715817600&v=beta&t=YDA1EzuREOKdmkQ4qF1n2O_fEI92OXQ0jD3lzR_A-Fo",
                    width: 140,
                    height: 120, // Set the height to 50% of the first image's height
                    fit: BoxFit.fill,
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
