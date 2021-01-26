import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'intTimerSetUp.dart';

void main() {
  runApp(IntervalTimerApp());
}

class IntervalTimerApp extends StatefulWidget {
  @override
  _IntervalTimerAppState createState() => _IntervalTimerAppState();
}

class _IntervalTimerAppState extends State<IntervalTimerApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: IntTimerSetUp_Page(),
        theme: ThemeData(
            textTheme: GoogleFonts.barlowTextTheme(
          Theme.of(context).textTheme,
        )));
  }
}
