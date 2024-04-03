import 'package:flutter/material.dart';


class ApplyForm extends StatefulWidget {
  const ApplyForm({super.key});
  @override
  State<ApplyForm> createState() => _ApplyForm();
}

class _ApplyForm extends State<ApplyForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const  Text("User Information",style: TextStyle(
          fontWeight: FontWeight.bold
        ),),
        centerTitle: true,
        leading: const Icon(Icons.arrow_back_sharp),
      ),
      body: Container(
        // color: Colors.grey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20,),
                const Text("First Name",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                TextField(
                  decoration: InputDecoration(
                    // contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 12),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(5)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(5)
                      ),
                      hintText: "First Name",
                  ),
                ),
                const SizedBox(height: 20,),
                const Text("Last Name",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                TextField(
                  decoration: InputDecoration(
                    // contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius:BorderRadius.circular(5)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide:const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(5)
                      ),
                      hintText: "Last Name"
                  ),
                ),
                const SizedBox(height: 20,),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Gender",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                        DropdownMenu(
                            enableSearch: true,
                            hintText: "Gender",
                            dropdownMenuEntries: [
                              DropdownMenuEntry(value: 'Male', label: 'Male'),
                              DropdownMenuEntry(value: 'Female', label: 'Female'),
                              DropdownMenuEntry(value: 'Other', label: 'Other')
                            ]
                        ),
                      ],
                    ),
                    // SizedBox(width: 40,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Year",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                        DropdownMenu(
                            enableSearch: true,
                            hintText: "Year",
                            dropdownMenuEntries: [
                              DropdownMenuEntry(value: '1st', label: 'First Year'),
                              DropdownMenuEntry(value: '2nd', label: 'Second Year'),
                              DropdownMenuEntry(value: '3rd', label: 'Third Year'),
                              DropdownMenuEntry(value: '4th', label: 'Final Year'),
                            ]
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 30,),
                const Divider(),
                const SizedBox(height: 20,),
                const Text("Contact Details",style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),),
                const SizedBox(height: 20,),
                const Text("Contact Email",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                TextField(
                  decoration: InputDecoration(
                    // contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 12),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color :Colors.black),
                      borderRadius: BorderRadius.circular(5)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color :Colors.black),
                        borderRadius: BorderRadius.circular(5)
                    ),
                    hintText: "Your Mail"
                  ),
                ),
                const SizedBox(height: 20,),
                const Text("Contact Phone", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                TextField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    // contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(5)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(5)
                      ),
                      hintText: "Enter Phone",
                    prefixText: "+91"
                  ),
                ),
                const SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                     SizedBox(
                      width: 175,
                      height: 50,
                      child: const OutlinedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(Colors.blue),
                            foregroundColor: MaterialStatePropertyAll(Colors.white),
                        ),
                        onPressed: null,
                        child: Text("Next",style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16
                        ),),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
