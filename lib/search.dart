import 'package:flutter/material.dart';

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
              // Handle navigation to a new page here
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsPage(job: _filteredJobs[index]),
                ),
              );
            },
            child: ListTile(
              title: Text(_filteredJobs[index]),
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