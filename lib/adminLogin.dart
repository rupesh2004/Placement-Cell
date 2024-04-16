import 'dart:io';

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

  void _uploadCompanyLogo() {
    // Implement your logic to upload the company logo
    // You can use _companyLogo to get the selected image file
    // For demonstration, let's print the file path
    if (_companyLogo != null) {
      print('Uploading company logo: ${_companyLogo!.path}');
    } else {
      print('No company logo selected');
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
                          
                          width: double
                              .infinity, // Set width to match parent width
                          child: ElevatedButton(
                            onPressed: () {
                              
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
