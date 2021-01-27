import 'dart:async';
import 'dart:io';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_beep/flutter_beep.dart';
import 'intTimerSetUp.dart';
import 'main.dart';

class Timer_Page extends StatefulWidget {
  @override
  _Timer_PageState createState() => _Timer_PageState();
}

bool starterVisible = true;

class _Timer_PageState extends State<Timer_Page> {
  int onDuration = initialOnTimer.inSeconds;
  int offDuration = initialOffTimer.inSeconds;

  bool onInterval = true;
  String pauseOrResume = 'TAP TO PAUSE';

  CountDownController timerController = CountDownController();
  CountDownController startController = CountDownController();

  String repsString = reps.toString();

  int repCount = 1;

  void onGoBack() {
    setState(() {
      initialOnTimer = new Duration(minutes: 0, seconds: 5);
      initialOffTimer = new Duration(minutes: 0, seconds: 5);
      repsIsSwitched = false;
      reps = 2;
    });
  }

  // Timer t;
  // String tt;
  // bool notPaused = true;
  // void lastThreeSeconds() {
  //   t = Timer.periodic(Duration(seconds: 1), (timer) {
  //     String getTime = timerController.getTime();
  //     int sec = int.parse(getTime.split(':')[1]);
  //     if ((sec < 4 && sec > 0) & notPaused) {
  //       FlutterBeep.beep();
  //       // FlutterBeep.playSysSound(iOSSoundIDs.TouchTone1);
  //       // FlutterBeep.playSysSound(iOSSoundIDs.AudioToneBusy);
  //     }
  //     setState(() {
  //       tt = getTime;
  //     });
  //   });
  // }

  Future<void> doneAlert() {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, //user must tap button
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
              title: Text(
                'TIMER COMPLETE',
                style: GoogleFonts.barlow(
                  textStyle: TextStyle(
                    color: midnight,
                    letterSpacing: 1.5,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              actions: <Widget>[
                TextButton(
                    child: Text(
                      'RESTART',
                      style: GoogleFonts.barlow(
                        textStyle: TextStyle(
                          color: salmon,
                          letterSpacing: 1.5,
                          fontSize: 24.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {
                        repCount = 1;
                        starterVisible = true;
                        startController.restart();
                      });
                    }),
                TextButton(
                    child: Text(
                      'DONE',
                      style: GoogleFonts.barlow(
                        textStyle: TextStyle(
                          color: salmon,
                          letterSpacing: 1.5,
                          fontSize: 24.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    onPressed: () {
                      onGoBack();
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/', (_) => false);
                    })
              ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: onInterval ? salmon : midnight,
        body: Stack(children: <Widget>[
          Center(
              child: Container(
                  width: 345.0,
                  margin: EdgeInsets.only(top: 135.0),
                  child: Column(children: <Widget>[
                    Text(
                      onInterval ? 'ON' : 'OFF',
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
                    Stack(alignment: Alignment.center, children: <Widget>[
                      Container(
                        transform: Matrix4.translationValues(0.0, 75.0, 0.0),
                        child: Text('$pauseOrResume',
                            style: GoogleFonts.barlow(
                              textStyle: TextStyle(
                                color: cream.withOpacity(0.5),
                                letterSpacing: 1.5,
                                fontSize: 24.0,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.italic,
                              ),
                            )),
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 50, bottom: 50),
                          child: InkWell(
                              onTap: () {
                                if (pauseOrResume == 'TAP TO PAUSE') {
                                  timerController.pause();
                                  setState(() {
                                    pauseOrResume = 'TAP TO RESUME';
                                    // notPaused = false;
                                  });
                                } else {
                                  timerController.resume();
                                  setState(() {
                                    // notPaused = true;
                                    pauseOrResume = 'TAP TO PAUSE';
                                  });
                                }
                              },
                              child: CircularCountDownTimer(
                                duration: onDuration,
                                controller: timerController,
                                fillColor: onInterval ? midnight : sage,
                                color: onInterval ? dijon : cream,
                                width: MediaQuery.of(context).size.width * 0.75,
                                height:
                                    MediaQuery.of(context).size.width * 0.75,
                                strokeWidth: 10,
                                textFormat: CountdownTextFormat.MM_SS,
                                textStyle: TextStyle(
                                  color: onInterval ? dijon : sage,
                                  letterSpacing: 1.5,
                                  fontSize: 90.0,
                                  fontWeight: FontWeight.w300,
                                ),
                                isReverse: true,
                                autoStart: false,
                                // onStart: lastThreeSeconds,
                                onComplete: () {
                                  if (onInterval) {
                                    if ((repsIsSwitched) && repCount == reps) {
                                      doneAlert();
                                      // t.cancel();
                                      FlutterBeep.playSysSound(
                                          iOSSoundIDs.CalendarAlert);
                                    } else {
                                      FlutterBeep.beep();
                                      // FlutterBeep.playSysSound(
                                      //     iOSSoundIDs.AudioToneBusy);
                                      setState(() {
                                        onInterval = false;
                                        timerController.restart(
                                            duration: offDuration);
                                      });
                                    }
                                  } else {
                                    // FlutterBeep.playSysSound(
                                    //     iOSSoundIDs.AudioToneBusy);
                                    FlutterBeep.beep();
                                    setState(() {
                                      onInterval = true;
                                      if (repsIsSwitched) {
                                        repCount += 1;
                                      }
                                      timerController.restart(
                                          duration: onDuration);
                                    });
                                  }
                                },
                              ))),
                    ]),
                    (repsIsSwitched)
                        ? Container(
                            child: Column(children: <Widget>[
                            LinearProgressIndicator(
                              value: repCount / reps,
                              backgroundColor: dijon.withOpacity(0.3),
                              valueColor: AlwaysStoppedAnimation<Color>(dijon),
                              minHeight: 10,
                            ),
                            SizedBox(height: 10),
                            Text(
                                repCount.toString() +
                                    '/' +
                                    repsString +
                                    ' REPS',
                                style: GoogleFonts.barlow(
                                  textStyle: TextStyle(
                                    color: cream.withOpacity(0.5),
                                    letterSpacing: 1.5,
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ))
                          ]))
                        : Container(),
                  ]))),
          Container(
            alignment: Alignment(0, 0.85),
            child: MaterialButton(
                child: Text('CANCEL',
                    style: GoogleFonts.barlow(
                      textStyle: TextStyle(
                        color: cream.withOpacity(0.5),
                        letterSpacing: 1.5,
                        fontSize: 24.0,
                        fontWeight: FontWeight.w500,
                      ),
                    )),
                onPressed: () {
                  onGoBack();
                  // t.cancel();
                  Navigator.pop(context);
                  Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
                }),
          ),
          Visibility(
              visible: starterVisible,
              maintainState: true,
              child: Center(
                  child: Container(
                      padding: EdgeInsets.only(top: 175),
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white.withOpacity(0.75),
                      child: Column(
                        children: <Widget>[
                          Container(
                              transform:
                                  Matrix4.translationValues(0.0, 30.0, 0.0),
                              child: Text('STARTING IN',
                                  style: GoogleFonts.barlow(
                                    textStyle: TextStyle(
                                      color: salmon,
                                      fontSize: 64.0,
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ))),
                          CircularCountDownTimer(
                            duration: 3,
                            warningBeeps: true,
                            isStartCountdown: true,
                            fillColor: cream.withOpacity(0),
                            color: cream.withOpacity(0),
                            controller: startController,
                            width: 400,
                            height: 400,
                            strokeWidth: 10,
                            textFormat: CountdownTextFormat.SS,
                            textStyle: TextStyle(
                              color: salmon,
                              letterSpacing: 1.5,
                              fontSize: 250.0,
                              fontWeight: FontWeight.w700,
                            ),
                            isReverse: true,
                            autoStart: true,
                            onComplete: () {
                              setState(() {
                                starterVisible = false;
                                timerController.restart();
                              });
                            },
                          )
                        ],
                      )))),
        ]));
  }
}
