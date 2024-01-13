import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class sample_screen extends StatefulWidget {
  const sample_screen({super.key});

  @override
  State<sample_screen> createState() => _sample_screenState();
}

class _sample_screenState extends State<sample_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Page Under Construction",
              style: GoogleFonts.poppins(
                  fontSize: 30, color: Color.fromARGB(255, 4, 0, 215)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.logout_rounded),
                  color: Colors.black,
                ),
                Text(
                  "Exit",
                  style: GoogleFonts.poppins(fontSize: 25, color: Colors.red),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
