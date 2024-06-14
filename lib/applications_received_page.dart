import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'applicants_page.dart';

class ApplicationsReceivedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('companies').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        var companies = snapshot.data!.docs;

        return ListView.builder(
          itemCount: companies.length,
          itemBuilder: (context, index) {
            var company = companies[index];
            return ListTile(
              leading: company['logo_url'] != null
                  ? Image.network(
                      company['logo_url'],
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    )
                  : Icon(Icons.business),
              title: Text(company['name']),
              subtitle: Text(company['info']),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ApplicantsPage(companyName: company['name'],),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
