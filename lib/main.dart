import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyDev());

class MyDev extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    );
  }
}

int max_sec = 59;
int sec = 0;
int min = 0;
Timer? timer;
String minut = "";
final audio = AudioPlayer();

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  Widget icons(IconData sk, Function()? dast()) {
    return InkWell(
      onTap: () {
        setState(() {
          dast();
        });
      },
      child: Icon(
        sk,
        color: Color(0xFFFB6BBC4),
      ),
    );
  }

  Widget start_stop(String start_text, Function()? starts(), colors_reset) {
    return InkWell(
      onTap: () {
        setState(() {
          starts();
        });
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(50, 15, 50, 15),
        decoration: BoxDecoration(
          border: Border.all(color: colors_reset),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          start_text,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }

  Widget texts(int min_sec) {
    return Text(
      min_sec < 10 ? "0$min_sec" : "$min_sec",
      style: TextStyle(fontSize: 50, color: Color(0xFFFF0ECE5)),
    );
  }

  Widget speed(int speedsss) {
    return InkWell(
      onTap: () {
        setState(() {
          sec += speedsss;
          if (sec >= 60) {
            sec = sec - 60;
            min += 1;
            print(sec);
          }
        });
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromARGB(255, 53, 41, 41),
          ),
        ),
        child: Text(
          "$speedsss",
          style: TextStyle(fontSize: 25, color: Colors.amber),
        ),
      ),
    );
  }

  start() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        sec--;
        if (min >= 1 && sec < 0) {
          sec = 59;
          min -= 1;
        } else if (min == 0 && sec == 0) {
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF161A30),
      appBar: AppBar(
        title: Text("Timer"),
        backgroundColor: Color(0xFFF31304D),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
              decoration: BoxDecoration(
                  // border: Border.all(color: Colors.red),
                  ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      icons(Icons.expand_less, () {
                        setState(() {
                          min += 5;
                        });
                      }),
                      texts(min),
                      icons(Icons.expand_more, () {
                        setState(() {
                          min -= 5;
                          if (min < 0) {
                            min = 0;
                          }
                        });
                      }),
                    ],
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        ":",
                        style:
                            TextStyle(color: Color(0xFFFB6BBC4), fontSize: 40),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      icons(Icons.expand_less, () {
                        setState(() {
                          sec += 5;
                          if (sec > max_sec) {
                            sec = 0;
                            min += 1;
                          }
                        });
                      }),
                      texts(sec),
                      icons(Icons.expand_more, () {
                        setState(() {
                          sec -= 5;
                          if (min >= 1 && sec < 0) {
                            sec = max_sec;
                            min -= 1;
                          } else if (min == 0 && sec < 0) {
                            sec = 0;
                          }
                        });
                      }),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                speed(15),
                speed(30),
                speed(60),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                start_stop(
                  "Start",
                  () {
                    timer = Timer.periodic(Duration(seconds: 1), (timer) {
                      setState(() {
                        sec--;
                        if (min >= 1 && sec < 0) {
                          sec = max_sec;
                          min -= 1;
                        } else if (min == 0 && sec == 0 ||
                            min == 0 && sec < 1) {
                          sec = 0;
                          timer.cancel();
                          audio.play(AssetSource("54.mp3"));
                        }
                      });
                    });
                  },
                  Colors.blue,
                ),
                start_stop("Reset", () {
                  setState(() {
                    min = 0;
                    sec = 0;
                    timer?.cancel();
                    audio.stop();
                  });
                }, Colors.red)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
