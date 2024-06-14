import 'package:company/student_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'dart:io';

class ApplicantsPage extends StatelessWidget {
  final String companyName;

  ApplicantsPage({required this.companyName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Applicants'),
        backgroundColor: Color.fromARGB(255, 17, 60, 232),
        foregroundColor: Colors.white,
        actions: [
          PopupMenuButton<String>(
            onSelected: (String value) {
              if (value == 'save_pdf') {
                _saveAllDataAsPdf(context);
              }
            },
            itemBuilder: (BuildContext context) {
              return {'Save as PDF'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: 'save_pdf',
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.grey[200],
        child: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection('companies')
              .where('name', isEqualTo: companyName)
              .get()
              .then((querySnapshot) => querySnapshot.docs.first),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data == null) {
              return Center(child: Text('No data available'));
            }

            var companyId = snapshot.data!.id;

            return StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('studResponses')
                  .where('company', isEqualTo: companyName)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                var applications = snapshot.data!.docs;

                return Container(
                  color: Colors.white,
                  child: ListView.builder(
                    itemCount: applications.length,
                    itemBuilder: (context, index) {
                      var application = applications[index];
                      var studentEmail = application['email'];

                      return Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                        child: FutureBuilder<DocumentSnapshot>(
                          future: FirebaseFirestore.instance
                              .collection('studResponses')
                              .doc(studentEmail) // Assuming 'email' is the document ID in studResponses
                              .get(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(176, 17, 60, 232),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ListTile(
                                  title: Text(
                                    studentEmail,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.black,
                                    radius: 25,
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                    ),
                                  ),
                                ),
                              );
                            }

                            var userData = snapshot.data!.data() as Map<String, dynamic>?;

                            var profileImageUrl = userData != null ? userData['imageUrl'] : null;

                            return Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(176, 17, 60, 232),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListTile(
                                title: Text(
                                  studentEmail,
                                  style: TextStyle(color: Colors.white),
                                ),
                                leading: CircleAvatar(
                                  backgroundColor: Colors.black,
                                  radius: 25,
                                  child: profileImageUrl != null
                                      ? ClipRRect(
                                          borderRadius: BorderRadius.circular(25),
                                          child: Image.network(
                                            profileImageUrl,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : Icon(Icons.person, color: Colors.white),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => StudentDetailPage(
                                        email: studentEmail,
                                        application: application,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Future<void> _saveAllDataAsPdf(BuildContext context) async {
    final pdf = pw.Document();

    // Fetch all student responses
    final querySnapshot = await FirebaseFirestore.instance
        .collection('studResponses')
        .where('company', isEqualTo: companyName)
        .get();

    final applications = querySnapshot.docs;

    for (var application in applications) {
      var data = application.data();
      var studentEmail = application.id; // Assuming 'email' is the document ID in studResponses

      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('Student Email: ${data['email'] ?? 'N/A'}', style: pw.TextStyle(fontSize: 20)),
                pw.Text('Name: ${data['firstName'] ?? 'N/A'} ${data['lastName'] ?? 'N/A'}'),
                pw.Text('Gender: ${data['gender'] ?? 'N/A'}'),
                pw.Text('Company: ${data['company'] ?? 'N/A'}'),
                pw.Text('Phone: ${data['phone'] ?? 'N/A'}'),
                pw.Text('Year: ${data['year'] ?? 'N/A'}'),
                pw.Text('Status: ${data['status'] ?? 'N/A'}'),

                pw.SizedBox(height: 20),
                // Fetch additional data from studResponses using email
              
              ],
            );
          },
        ),
      );
    }

    // Save the PDF to a file in the device's documents directory
    final output = await getApplicationDocumentsDirectory();
    final file = File('${output.path}/students.pdf');
    await file.writeAsBytes(await pdf.save());

    // Show a snackbar with a message
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('PDF saved to ${file.path}'),
    ));

    // Share the PDF file
    Share.shareFiles([file.path], text: 'Here are the students details in PDF format.');
  }
}
