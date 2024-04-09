import 'package:flutter/material.dart';
import 'package:company/jobTitle.dart'; // Import the JobTile widget

class SearchJob extends StatefulWidget {
  @override
  _SearchJobState createState() => _SearchJobState();
}

class _SearchJobState extends State<SearchJob> {
  TextEditingController _controller = TextEditingController();
  String _searchText = "";
  List<String> _jobs = [
    "Software Engineer",
    "Web Developer",
    "Data Scientist",
    "UI/UX Designer",
    "Product Manager",
    "Android Developer",
    "Mobile App Developer",
    "Network Administrator",
    "Business Analyst",
    "Quality Assurance Engineer",
    "DevOps Engineer",
  ];
  List<String> _filteredJobs = [];

  @override
  void initState() {
    super.initState();
    _filteredJobs.addAll(_jobs);
  }

  void _filterJobs(String query) {
    setState(() {
      _filteredJobs = _jobs
          .where((job) => job.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: "Search...",
            suffixIcon: Icon(Icons.search)
          ),
          onChanged: (value) {
            setState(() {
              _searchText = value;
              _filterJobs(_searchText);
            });
          },
        ),
      ),
      body: ListView.builder(
        itemCount: _filteredJobs.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Navigate to DetailsPage and pass the job title
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsPage(job: _filteredJobs[index]),
                ),
              );
            },
            child: JobTile(
              // Pass job details as parameters to JobTile
              jobImage: "assets/images/microsoft.jpg", // Replace with actual path to image
              jobTitle: _filteredJobs[index],
              jobLocation: "Location", // Replace with actual location
              numOfApplicants: 10, // Replace with actual number of applicants
            ),
          );
        },
      ),
    );
  }
}

class DetailsPage extends StatelessWidget {
  final String job;

  DetailsPage({required this.job});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Job Details'),
      ),
      body: Center(
        child: Text('Details of $job'),
      ),
    );
  }
}
