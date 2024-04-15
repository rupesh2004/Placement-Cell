import 'package:company/loginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfileState();
}

class Company {
  bool isBookmarked;

  Company({
    this.isBookmarked = false,
  });
}

class _UserProfileState extends State<UserProfilePage> {
  late List<Company> companies;
  List<String> list = <String>['Sign Out'];
  String dropdownValue = '';
  GlobalKey _popupMenuKey = GlobalKey();

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
    companies = List.generate(3, (_) => Company());
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
                // This is called when the user selects an item.
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
                                65, // Adjust the top position to place it on top of the first image
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
