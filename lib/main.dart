import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(CupertinoExample());
}

class CupertinoExample extends StatefulWidget {
  @override
  _CupertinoExampleState createState() => _CupertinoExampleState();
}

class _CupertinoExampleState extends State<CupertinoExample> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ExamplePage(),
        theme: ThemeData(
            textTheme: GoogleFonts.barlowTextTheme(
          Theme.of(context).textTheme,
        )));
  }
}

class ExamplePage extends StatefulWidget {
  @override
  _ExamplePageState createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  Duration initialOnTimer = new Duration(minutes: 0, seconds: 45);
  Duration initialOffTimer = new Duration(minutes: 0, seconds: 15);

  Widget onTimePicker() {
    return CupertinoTimerPicker(
      mode: CupertinoTimerPickerMode.ms,
      minuteInterval: 1,
      secondInterval: 1,
      initialTimerDuration: initialOnTimer,
      onTimerDurationChanged: (Duration changedTimer) {
        setState(() {
          initialOnTimer = changedTimer;

          int m = changedTimer.inMinutes;
          int s = changedTimer.inSeconds % 60;
          String min = (m < 10) ? '0' + m.toString() : m.toString();
          String sec = (s < 10) ? '0' + s.toString() : s.toString();

          onTime = min + ':' + sec;

          initialOnTimer = changedTimer;
        });
      },
    );
  }

  Widget offTimePicker() {
    return CupertinoTimerPicker(
      mode: CupertinoTimerPickerMode.ms,
      minuteInterval: 1,
      secondInterval: 1,
      initialTimerDuration: initialOffTimer,
      onTimerDurationChanged: (Duration changedTimer) {
        setState(() {
          initialOffTimer = changedTimer;

          int m = changedTimer.inMinutes;
          int s = changedTimer.inSeconds % 60;
          String min = (m < 10) ? '0' + m.toString() : m.toString();
          String sec = (s < 10) ? '0' + s.toString() : s.toString();

          offTime = min + ':' + sec;

          initialOffTimer = changedTimer;
        });
      },
    );
  }

  Future<void> bottomSheet(BuildContext context, Widget child,
      {double height}) {
    return showModalBottomSheet(
        isScrollControlled: false,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(13), topRight: Radius.circular(13))),
        backgroundColor: Colors.white,
        context: context,
        builder: (context) => Container(
            height: height ?? MediaQuery.of(context).size.height / 3,
            child: child));
  }

  Widget button(String text, {Function onPressed, Color color}) {
    return Container(
        width: 450,
        height: 120,
        margin: EdgeInsets.symmetric(vertical: 5),
        // color: Colors.green,
        child: MaterialButton(
            child: Text(
              '$text',
              style: GoogleFonts.barlow(
                  textStyle: TextStyle(
                      color: dijon,
                      fontSize: 110.0,
                      letterSpacing: 5,
                      fontWeight: FontWeight.w300)),
            ),
            onPressed: onPressed));
  }

  Widget startButton(String text, {Function onPressed, Color color}) {
    return Container(
        width: 250,
        height: 65,
        margin: EdgeInsets.only(top: 40),
        decoration: BoxDecoration(
            color: cream,
            borderRadius: BorderRadius.all(
              Radius.circular(50.0),
            )),
        child: MaterialButton(
            child: Text(
              '$text',
              style: GoogleFonts.barlow(
                  textStyle: TextStyle(
                      color: sage,
                      fontSize: 36.0,
                      letterSpacing: 2,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600)),
            ),
            onPressed: onPressed));
  }

  String onTime = '00:45';
  String offTime = '00:15';

  //COLOR PALETTE
  Color salmon = Color(0xFFe07a5f);
  Color cream = Color(0xFFf4f1de);
  Color midnight = Color(0xFF3d405b);
  Color sage = Color(0xFF81b29a);
  Color dijon = Color(0xFFf2cc8f);

  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(title: Text('Interval Timer')),
        backgroundColor: salmon,
        body: Center(
          child: Container(
            // color: sage,
            width: 345.0,
            margin: EdgeInsets.only(top: 135.0),

            // alignment: Alignment.center,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'INTERVAL TIMER',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.barlow(
                    textStyle: TextStyle(
                        color: cream,
                        letterSpacing: 1.5,
                        fontSize: 40.0,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.italic),
                  ),
                ),
                Container(
                    width: 305,
                    margin: EdgeInsets.only(top: 35.0),
                    child: Text(
                      'ON (MIN:SEC)',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.barlow(
                        textStyle: TextStyle(
                            color: cream,
                            letterSpacing: .5,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w300),
                      ),
                    )),
                Divider(
                  color: cream,
                  height: 0,
                  thickness: 1,
                  indent: 20,
                  endIndent: 20,
                ),
                Container(
                    transform: Matrix4.translationValues(0.0, -20.0, 0.0),
                    child: button(onTime, onPressed: () {
                      bottomSheet(context, onTimePicker());
                    })),
                Container(
                    width: 305,
                    child: Text(
                      'OFF (MIN:SEC)',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.barlow(
                        textStyle: TextStyle(
                            color: cream,
                            letterSpacing: .5,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w300),
                      ),
                    )),
                Divider(
                  color: cream,
                  height: 0,
                  thickness: 1,
                  indent: 20,
                  endIndent: 20,
                ),
                Container(
                    transform: Matrix4.translationValues(0.0, -20.0, 0.0),
                    child: button(offTime, onPressed: () {
                      bottomSheet(context, offTimePicker());
                    })),
                Container(
                    width: 305,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'REPS',
                            textAlign: TextAlign.left,
                            style: GoogleFonts.barlow(
                              textStyle: TextStyle(
                                  color: cream,
                                  letterSpacing: 1.5,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          Transform.scale(
                              scale: 1.2,
                              child: Switch(
                                value: isSwitched,
                                onChanged: (value) {
                                  setState(() {
                                    isSwitched = value;
                                  });
                                },
                                activeTrackColor: dijon.withOpacity(0.7),
                                activeColor: dijon,
                                inactiveTrackColor: cream.withOpacity(0.3),
                                inactiveThumbColor: cream.withOpacity(0.7),
                              )),
                        ])),
                (isSwitched)
                    ? Container(
                        width: 305,
                        height: 100,
                        // color: cream.withOpacity(0.25),
                        decoration: BoxDecoration(
                            color: cream.withOpacity(0.25),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            )),
                        child: Container(
                            transform: Matrix4.translationValues(0.0, 7.0, 0.0),
                            child: Column(children: <Widget>[
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'x',
                                      style: GoogleFonts.barlow(
                                        textStyle: TextStyle(
                                            color: cream,
                                            letterSpacing: 1.5,
                                            fontSize: 36.0,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    Text(
                                      ' ',
                                      style: GoogleFonts.barlow(
                                        textStyle: TextStyle(fontSize: 48.0),
                                      ),
                                    ),
                                    Text(
                                      '20',
                                      style: GoogleFonts.barlow(
                                        textStyle: TextStyle(
                                            color: cream,
                                            letterSpacing: 1.5,
                                            fontSize: 48.0,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    )
                                  ]),
                              Text(
                                'Total Duration: 20 min 0 sec',
                                style: GoogleFonts.barlow(
                                  textStyle: TextStyle(
                                      color: cream,
                                      letterSpacing: .5,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ])))
                    : Container(),
                startButton('START', onPressed: () {
                  bottomSheet(context, onTimePicker());
                })
              ],
            ),
          ),
        ));
  }
}