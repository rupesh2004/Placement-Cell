import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  late TextEditingController _companyNameController;
  late TextEditingController _companyInfoController;
  File? _companyLogo;

  Future<void> _pickCompanyLogo() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1024,
      maxHeight: 1024,
    );

    if (pickedFile != null) {
      setState(() {
        _companyLogo = File(pickedFile.path);
      });
    }
  }

 Future<void> _uploadCompanyLogo() async {
  if (_companyLogo != null) {
    try {
      // Show loader while uploading
      showDialog(
        context: context,
        barrierDismissible: false, // Prevent dialog from being dismissed by tapping outside
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      // Generate a unique document ID
      final String documentId = DateTime.now().millisecondsSinceEpoch.toString();

      // Upload image to Firebase Storage with the document ID as the filename
      final firebase_storage.Reference storageRef = firebase_storage.FirebaseStorage.instance.ref().child('company_logos/$documentId');
      await storageRef.putFile(_companyLogo!);

      // Get the download URL of the uploaded image
      final String downloadURL = await storageRef.getDownloadURL();

      // Upload textual data to Cloud Firestore with the same document ID
      await FirebaseFirestore.instance.collection('companies').doc(documentId).set({
        'name': _companyNameController.text,
        'info': _companyInfoController.text,
        'logo_url': downloadURL,
      });

      // Clear the controllers and image after successful upload
      _companyNameController.clear();
      _companyInfoController.clear();
      setState(() {
        _companyLogo = null;
      });

      // Close the loader dialog
      Navigator.of(context).pop();

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data uploaded successfully')),
      );
    } catch (e) {
      // Close the loader dialog
      Navigator.of(context).pop();

      // Show error message if upload fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading data: $e')),
      );
    }
  } else {
    // Show error message if no image is selected
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please select an image')),
    );
  }
}


  @override
  void initState() {
    super.initState();
    _companyNameController = TextEditingController();
    _companyInfoController = TextEditingController();
  }

  @override
  void dispose() {
    _companyNameController.dispose();
    _companyInfoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Page'),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _companyNameController,
                decoration: const InputDecoration(
                  labelText: 'Company Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _companyInfoController,
                maxLines: 5, // Adjust as needed
                decoration: const InputDecoration(
                  labelText: 'Company Information',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                margin: const EdgeInsets.only(),
                width: 190, // Set width to match parent width
                child: ElevatedButton(
                  onPressed: () {
                    _pickCompanyLogo();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(176, 17, 60, 232),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(6), // Set border radius here
                    ),
                  ),
                  child: const Text(
                    "Upload Company Logo",
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              if (_companyLogo != null)
                Column(
                  children: [
                    Image.file(
                      _companyLogo!,
                      width: double
                          .infinity, // Ensures the image takes up the entire width
                      height: 250,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity, // Set width to match parent width
                      child: ElevatedButton(
                        onPressed: () {_uploadCompanyLogo();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: const Color.fromARGB(176, 17, 60, 232),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                6), // Set border radius here
                          ),
                        ),
                        child: const Text(
                          "Upload Data",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
