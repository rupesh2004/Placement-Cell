import 'package:flutter/material.dart';

 // Import the JobTile widget
class JobTile extends StatefulWidget {
  final String jobImage;
  final String jobTitle;
  final String jobLocation;
  final int numOfApplicants;

  const JobTile({
    Key? key,
    required this.jobImage,
    required this.jobTitle,
    required this.jobLocation,
    required this.numOfApplicants,
  }) : super(key: key);

  @override
  State<JobTile> createState() => _JobTileState();
}

class _JobTileState extends State<JobTile> {
  bool isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset('${widget.jobImage}',width: 48, height: 48,),
              SizedBox(width: 20,),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.jobTitle}',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    '${widget.jobLocation}',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xffF5F2FD),
                      borderRadius: BorderRadius.circular(6.0)
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Text(
                      '${widget.numOfApplicants} applicants',
                      style: TextStyle(
                        color: Color(0xff8353E2),
                        fontSize: 16,
                      ),
                    ),
                  )
                ],
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: isBookmarked
                          ? Icon(Icons.bookmark, size: 26, color: Color(0xff8353E2))
                          : Icon(Icons.bookmark_border, size: 26),
                      onPressed: () {
                        setState(() {
                          isBookmarked = !isBookmarked;
                        });
                      },
                    ),
                  ],
                ),
              ),

            ],
          ),
          SizedBox(height: 10,),
          Divider(),
        ],
      ),
    );
  }
}