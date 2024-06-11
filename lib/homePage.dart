import 'package:company/applyForm.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CompanyListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Companies'),
            backgroundColor: const Color.fromARGB(176, 17, 60, 232),
            foregroundColor: Colors.white,
      ),
      backgroundColor: Color.fromARGB(255, 175, 238, 236),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('companies').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var companies = snapshot.data!.docs;

          return ListView.builder(
            itemCount: companies.length,
            itemBuilder: (context, index) {
              var company = companies[index];
              return CompanyCard(
                companyName: company['name'],
                companyInfo: company['info'],
                imageUrl: company['logo_url'],
              );
            },
          );
        },
      ),
    );
  }
}

class CompanyCard extends StatelessWidget {
  final String companyName;
  final String companyInfo;
  final String imageUrl;

  const CompanyCard({
    required this.companyName,
    required this.companyInfo,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color:  const Color.fromARGB(176, 17, 60, 232),
      
      elevation: 5.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
            child: Image.network(
              imageUrl,
              fit: BoxFit.fill,
              height: 150,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        companyName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.white
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        companyInfo,
                        style: TextStyle(fontSize: 16.0,
                          color: Colors.white
                        ),
                        
                      ),
                      SizedBox(height: 8.0),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ApplyForm(companyName: companyName),
      ),
    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 255, 255, 255),
                    onPrimary: Colors.black,
                  ),
                  child: Text('Apply'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
