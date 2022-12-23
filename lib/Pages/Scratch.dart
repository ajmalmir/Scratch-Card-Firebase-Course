import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:scratcher/scratcher.dart';

// ! HiveBox--------------------------------------------------------------------
Box? wallet = Hive.box("wallet");

class ScratchPage extends StatefulWidget {
  const ScratchPage({super.key});

  @override
  State<ScratchPage> createState() => _ScratchPageState();
}

class _ScratchPageState extends State<ScratchPage> {
// ! All Earning variable
  var earningsinrupee = wallet?.get(0);
// ! Key----------------------------------------------
  final scratchkey = GlobalKey<ScratcherState>();
// ! Random Number variable---------------------------
  var RandomNumber;
// ! ra variable--------------------------------------

  var ra;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
              color: Colors.grey[200],
              height: 50,
              width: 300,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Balance  ₹',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    earningsinrupee.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              )),
          SizedBox(
            height: 50,
          ),
          SizedBox(
            height: 50,
          ),
          Center(
// ! Top-Container--------------------------------------------------------------

            child: Scratcher(
              key: scratchkey,
              brushSize: 40,
              threshold: 50,
              color: Colors.green,
              image: Image.asset(
                'images/wheel.png',
              ),
              // ! onScratchStart---------------------------------------------
              onScratchStart: () {
                setState(() {
                  RandomNumber = (Random().nextInt(3) + 1);
                });
              },
              // ! onThreshold------------------------------------------------
              onThreshold: () {
                setState(() {
                  showDialog(
                      context: context,
                      builder: (context) {
                        // ! AlertDialog-Container------------------------------
                        return Container(
                          child: AlertDialog(
                            actions: [
                              Center(
                                child: Container(
                                  // ! Image------------------------------------
                                  child: Image(
                                      image: AssetImage('images/wheel.png')),
                                ),
                              ),
                              Center(
                                // ! Earnings-----------------------------------
                                child: Text('You Win ₹$RandomNumber',
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black)),
                              ),
                              Center(
                                  // ! Button-------------------------------------
                                  child: MaterialButton(
                                      onPressed: () {
                                        setState(() {
                                          if (earningsinrupee == null) {
                                            earningsinrupee = 0;
                                          } else {
                                            earningsinrupee = wallet?.get(0);
                                          }
                                          var allreward =
                                              (earningsinrupee + RandomNumber);
                                          wallet?.put(0, allreward);
                                        });

                                        scratchkey.currentState?.reset(
                                            duration:
                                                Duration(microseconds: 200));
                                        Navigator.pop(context);
                                      },
                                      color: Colors.amber,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Text('CLAIM',
                                          style:
                                              TextStyle(color: Colors.white)))),
                            ],
                          ),
                        );
                      });
                });
              },
              // ! Bottom-Container-----------------------------------------------------------
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "images/trophy.png",
                        fit: BoxFit.contain,
                        width: 200,
                        height: 200,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
