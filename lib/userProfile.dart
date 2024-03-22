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
  bool isIconButtonPressed = false;
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
        body: Container(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 240, // Give a fixed height to the container
                    child: Stack(
                      children: [
                        Positioned(
                          // Adjust the top position to place it on top of the first image
                          left: 0,
                          right: 0,
                          child: Image.network(
                            "https://media.licdn.com/dms/image/D4D16AQE8PJ9tT-pLww/profile-displaybackgroundimage-shrink_350_1400/0/1700799198816?e=1715817600&v=beta&t=ZEkigCna451AI7aKt9EK-FwlzRCtbOrFIyT-ydhdPao",
                            width: double.infinity,
                            height: 120,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Container(
                          child: const Positioned(
                            top:
                                85, // Adjust the top position to place it on top of the first image
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
                                    "https://media.licdn.com/dms/image/D4D03AQF3IxNkwo8VdQ/profile-displayphoto-shrink_400_400/0/1708500069972?e=1715817600&v=beta&t=YDA1EzuREOKdmkQ4qF1n2O_fEI92OXQ0jD3lzR_A-Fo",
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
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Rupesh Bhosale',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 30),
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'UI/UX Designer',
                    style: TextStyle(
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
                    'Saved Jobs',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(8),
                  children: <Widget>[
                    Container(
                      height: 130,
                      child: Row(
                        children: [
                          Image.network(
                            "https://static.vecteezy.com/system/resources/thumbnails/011/153/368/small/3d-website-developer-working-on-laptop-illustration-png.png",
                            width: 100,
                            height: 130,
                            fit: BoxFit.fill,
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Web Developer',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    'Atlas Copco',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    '1900d',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 11, 221, 232),
                                    ),
                                  ),
                                  Text(
                                    '4.5 (1234)',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                isIconButtonPressed = !isIconButtonPressed;
                              });
                            },
                            icon: isIconButtonPressed
                                ? const Icon(Icons.bookmark, color: Colors.blue,)
                                :const  Icon(
                                    Icons.bookmark_outline), // Icon to display
                            color: isIconButtonPressed ? Colors.blue : null,
                            iconSize: 30,
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 130,
                      child: Row(
                        children: [
                          Image.network(
                            "https://www.algoworks.com/wp-content/uploads/2020/11/game-development-company.png",
                            width: 100,
                            height: 130,
                            fit: BoxFit.fill,
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Game Developer',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    'Unity Developers',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    '2000d',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 11, 221, 232),
                                    ),
                                  ),
                                  Text(
                                    '4.2 (734)',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                isIconButtonPressed = !isIconButtonPressed;
                              });
                            },
                            icon: isIconButtonPressed
                                ? const Icon(Icons.bookmark, color: Colors.blue,)
                                :const  Icon(
                                    Icons.bookmark_outline), // Icon to display
                            color: isIconButtonPressed ? Colors.blue : null,
                            iconSize: 30,
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 130,
                      child: Row(
                        children: [
                          Image.network(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQWAAIZk9Krc8XXD_BYHCa6cQQg0Lh3m5sZQ&usqp=CAU",
                            width: 100,
                            height: 130,
                            fit: BoxFit.fill,
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'App Developer',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    'Google',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    '2500d',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 11, 221, 232),
                                    ),
                                  ),
                                  Text(
                                    '4.8 (3234)',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                isIconButtonPressed = !isIconButtonPressed;
                              });
                            },
                            icon: isIconButtonPressed
                                ? const Icon(Icons.bookmark, color: Colors.blue,)
                                :const  Icon(
                                    Icons.bookmark_outline), // Icon to display
                            color: isIconButtonPressed ? Colors.blue : null,
                            iconSize: 30,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
