import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StudentDetailPage extends StatefulWidget {
  final DocumentSnapshot application;
  final String email;

  StudentDetailPage({required this.application, required this.email});

  @override
  _StudentDetailPageState createState() => _StudentDetailPageState();
}

class _StudentDetailPageState extends State<StudentDetailPage> {
  bool isAccepted = false;

  @override
  void initState() {
    super.initState();
    var data = widget.application.data() as Map<String, dynamic>;
    isAccepted = data.containsKey('status') && data['status'] == 'accepted';
  }

  void acceptApplication() {
    FirebaseFirestore.instance
        .collection('studResponses')
        .doc(widget.application.id)
        .update({'status': 'accepted'}).then((_) {
      setState(() {
        isAccepted = true;
      });
    });
  }

  void deleteApplication() {
    FirebaseFirestore.instance
        .collection('studResponses')
        .doc(widget.application.id)
        .delete().then((_) {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    var data = widget.application.data() as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: Text('Student Details'),
        backgroundColor: Color.fromARGB(255, 17, 60, 232),
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('users').doc(widget.email).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No user data available'));
          }

          var userData = snapshot.data!.data() as Map<String, dynamic>?;
          var profileImageUrl = userData != null ? userData['imageUrl'] : null;

          return Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SingleChildScrollView(
              child: Container(
                color: Colors.grey[200],
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (profileImageUrl != null)
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(profileImageUrl),
                      )
                    else
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey,
                        child: Icon(Icons.person, size: 50, color: Colors.white),
                      ),
                    SizedBox(height: 20),
                    _buildDetailCard('Name', '${data['firstName'] ?? 'N/A'} ${data['lastName'] ?? 'N/A'}'),
                    _buildDetailCard('Email', data['email'] ?? 'N/A'),
                    _buildDetailCard('Gender', data['gender'] ?? 'N/A'),
                    _buildDetailCard('Company', data['company'] ?? 'N/A'),
                    _buildDetailCard('Phone', data['phone'] ?? 'N/A'),
                    _buildDetailCard('Year', data['year'] ?? 'N/A'),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: isAccepted ? null : acceptApplication,
                          child: isAccepted ? Icon(Icons.check, color: Colors.green) : Text('Accept'),
                        ),
                        SizedBox(width: 20),
                        ElevatedButton(
                          onPressed: deleteApplication,
                          child: Text('Delete'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetailCard(String title, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
