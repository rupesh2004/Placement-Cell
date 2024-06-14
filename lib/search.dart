import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchJob extends StatefulWidget {
  @override
  _SearchJobState createState() => _SearchJobState();
}

class _SearchJobState extends State<SearchJob> {
  TextEditingController _controller = TextEditingController();
  String _searchText = "";
  List<DocumentSnapshot> _allJobs = [];
  List<DocumentSnapshot> _filteredJobs = [];

  @override
  void initState() {
    super.initState();
    _fetchJobs();
  }

  Future<void> _fetchJobs() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('companies').get();
    setState(() {
      _allJobs = snapshot.docs;
      _filteredJobs = _allJobs;
    });
  }

  void _filterJobs(String query) {
    setState(() {
      _filteredJobs = _allJobs.where((job) {
        String jobName = job['name'].toString().toLowerCase();
        return jobName.contains(query.toLowerCase());
      }).toList();
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
            suffixIcon: Icon(Icons.search),
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
          DocumentSnapshot job = _filteredJobs[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsPage(job: job),
                ),
              );
            },
            child: JobTile(
              jobImage: job['logo_url'],
              jobTitle: job['name'],
              jobInfo: job['info'], 

            ),
          );
        },
      ),
    );
  }
}

class DetailsPage extends StatelessWidget {
  final DocumentSnapshot job;

  DetailsPage({required this.job});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Job Details'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(job['logo_url']),
            Text('Name: ${job['name']}'),
            Text('Info: ${job['info']}'),
          ],
        ),
      ),
    );
  }
}

class JobTile extends StatelessWidget {
  final String jobImage;
  final String jobTitle;
  final String jobInfo;


  JobTile({
    required this.jobImage,
    required this.jobTitle,
    required this.jobInfo,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(jobImage),
      title: Text(jobTitle),
      subtitle: Text('$jobInfo'),
      isThreeLine: true,
    );
  }
}
