import 'dart:async';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String timeString = "00:00:00";
  Stopwatch stopwatch = Stopwatch();
  late Timer timer;

  void start(){
    stopwatch.start();
    timer = Timer.periodic(Duration(microseconds: 1), update);
  }

  void update(Timer t){
    if(stopwatch.isRunning){
      setState(() {
        timeString = (stopwatch.elapsed.inMinutes % 60).toString().padLeft(2, "0") + ":" +
            (stopwatch.elapsed.inSeconds % 60).toString().padLeft(2, "0") + ":" +
            (stopwatch.elapsed.inMilliseconds % 1000 / 10).clamp(0, 99).toStringAsFixed(0).padLeft(2, "0");
      });
    }
  }

  void stop(){
    setState(() {
      timer.cancel();
      stopwatch.stop();
    });
  }

  void reset(){
    timer.cancel();
    stopwatch.reset();
    setState(() {
      timeString = "00:00:00";
    });
    stopwatch.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60.0, vertical: 60.0),
            child: Text("STOPWATCH",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade900,
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: 280,
              height: 280,
              //color: Colors.grey,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                shape: BoxShape.circle,
                boxShadow: [
                  const BoxShadow(
                    offset: Offset(10, 10),
                    color: Colors.black38,
                    blurRadius: 15,
                  ),
                  BoxShadow(
                    offset: const Offset(-10, -10),
                    color: Colors.white.withOpacity(0.85),
                    blurRadius: 15,
                  )
                ]
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.timer_sharp, size: 90, color: Colors.grey.shade900,),
                  Text(timeString,
                    style: TextStyle(
                      fontSize: 40.0,
                      color: Colors.grey.shade900,
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: reset,
                  child: Container(
                    height: 100,
                    width: 100,
                    //color: Colors.white,
                    child: const Icon(Icons.refresh, size: 60,),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        shape: BoxShape.circle,
                        boxShadow: [
                          const BoxShadow(
                            offset: Offset(10, 10),
                            color: Colors.black38,
                            blurRadius: 15,
                          ),
                          BoxShadow(
                            offset: const Offset(-10, -10),
                            color: Colors.white.withOpacity(0.85),
                            blurRadius: 15,
                          )
                        ]
                    ),
                  )
                ),

                TextButton(
                  onPressed: (){
                    stopwatch.isRunning ? stop() : start();
                  },
                  child: Container(
                    height: 100,
                    width: 100,
                    //color: Colors.white,
                    child: Icon(stopwatch.isRunning ? Icons.pause : Icons.play_arrow, size: 60,),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        shape: BoxShape.circle,
                        boxShadow: [
                          const BoxShadow(
                            offset: Offset(10, 10),
                            color: Colors.black38,
                            blurRadius: 15,
                          ),
                          BoxShadow(
                            offset: const Offset(-10, -10),
                            color: Colors.white.withOpacity(0.85),
                            blurRadius: 15,
                          )
                        ]
                    ),
                  )
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
