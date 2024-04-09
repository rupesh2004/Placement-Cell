import 'package:company/jobTitle.dart';
import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  final List<Job> jobs = [
    Job(
      jobImage: 'assets/images/microsoft.jpg',
      jobTitle: 'Flutter Developer',
      jobLocation: 'New York, USA',
      numOfApplicants: 20,
    ),
    Job(
      jobImage: 'assets/images/microsoft.jpg',
      jobTitle: 'Backend Engineer',
      jobLocation: 'San Francisco, USA',
      numOfApplicants: 15,
    ),
    Job(
      jobImage: 'assets/images/microsoft.jpg',
      jobTitle: 'Graphics Designer',
      jobLocation: 'Chicago, USA',
      numOfApplicants: 16,
    ),
    Job(
      jobImage: 'assets/microsoft.jpg',
      jobTitle: 'Software Engineer',
      jobLocation: 'Banglore, India',
      numOfApplicants: 8,
    ),
    Job(
      jobImage: 'assets/microsoft.jpg',
      jobTitle: 'Full Stack Engineer',
      jobLocation: 'San Francisco, USA',
      numOfApplicants: 23,
    ),
    Job(
      jobImage: 'assets/microsoft.jpg',
      jobTitle: 'Software Engineer',
      jobLocation: 'San Francisco, USA',
      numOfApplicants: 15,
    ),
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jobs'),
      ),
      body: _selectedIndex == 1 ? _buildJobPage() : Container(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 26),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search , size: 26),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications, size: 26),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 26),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xff4069E5),
        unselectedItemColor: Color(0xff565E6C),
        onTap: _onItemTapped,
      ),
    );
  }
  Widget _buildJobPage() {
    return ListView.builder(
      itemCount: jobs.length,
      itemBuilder: (BuildContext context, int index) {
        final job = jobs[index];
        return JobTile(
          jobImage: job.jobImage,
          jobTitle: job.jobTitle,
          jobLocation: job.jobLocation,
          numOfApplicants: job.numOfApplicants,
        );
      },
    );
  }
}




class Job {
  final String jobImage;
  final String jobTitle;
  final String jobLocation;
  final int numOfApplicants;

  Job({
    required this.jobImage,
    required this.jobTitle,
    required this.jobLocation,
    required this.numOfApplicants,
  });
}