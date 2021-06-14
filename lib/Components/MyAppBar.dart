import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyAppBar extends StatefulWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  _MyAppBarState createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 7),
        Text('VALET PARKING',style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
