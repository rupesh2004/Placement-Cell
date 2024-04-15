import 'package:flutter/material.dart';

class Feed extends StatefulWidget {
  @override
  feedState createState() => feedState();
}

class feedState extends State<Feed>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        leading: const CircleAvatar(
          backgroundImage: AssetImage('assets/images/boy.png'),
          maxRadius: 10,
        ),
        title: const Text('Hello, sir',style: TextStyle(
          fontWeight: FontWeight.w400,

        ),),
       
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage('assets/images/now.jpg'), // Provide a path to your avatar image
                  ),
                  const SizedBox(width: 10),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Group Technology',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '1350 Followers',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(), // Push the Follow button to the end
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Follow',style: TextStyle(
                      color: Colors.blue
                    ),),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // const Divider(), // Add a divider between feed items
              // const SizedBox(height: 10),
              const Text('At Group, we take great pride in fostering a culture that values and celebrates accomplishments ...',
                style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w500
              ),),
              const SizedBox(height: 2,),
              TextButton(onPressed: (){}, child: const Text('See More',style: TextStyle(
                color: Colors.blue
              ),)),
              Image.asset('assets/images/now.jpg',width: double.infinity,fit: BoxFit.cover,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.thumb_up), // Like icon
                    onPressed: () {
                      // Handle like functionality here
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.comment), // Comment icon
                    onPressed: () {
                      // Handle comment functionality here
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.share), // Share icon
                    onPressed: () {
                      // Handle share functionality here
                    },
                  ),
                ],
              ),
              const Divider(),
              Row(
                children: [
                  const CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage('assets/images/now.jpg'), // Provide a path to your avatar image
                  ),
                  const SizedBox(width: 10),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Infosys Technology',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '1.2M Followers',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(), // Push the Follow button to the end
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Following',style: TextStyle(
                        color: Colors.blue
                    ),),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // const Divider(), // Add a divider between feed items
              // const SizedBox(height: 10),
              const Text('At Group, we take great pride in fostering a culture that values and celebrates accomplishments ...',
                style: TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w500
                ),),
              const SizedBox(height: 2,),
              TextButton(onPressed: (){}, child: const Text('See More',style: TextStyle(
                  color: Colors.blue
              ),)),
              Image.asset('assets/images/now.jpg',width: double.infinity,fit: BoxFit.cover,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.thumb_up), // Like icon
                    onPressed: () {
                      // Handle like functionality here
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.comment), // Comment icon
                    onPressed: () {
                      // Handle comment functionality here
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.share), // Share icon
                    onPressed: () {
                      // Handle share functionality here
                    },
                  ),
                ],
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}

