import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:scratch_screen/Pages/Scratch.dart';

class RealtimeStoreScreen extends StatefulWidget {
  const RealtimeStoreScreen({super.key});

  @override
  State<RealtimeStoreScreen> createState() => _RealtimeStoreScreenState();
}

class _RealtimeStoreScreenState extends State<RealtimeStoreScreen> {
// ! Controllers--------------------------------
  final TextController = TextEditingController();

// ! Global key---------------------------------
  final _formkey = GlobalKey<FormState>();

// ! FirebaseDatabase instance------to fetch data -----------
  final fetchRef =
      FirebaseDatabase.instance.ref('Movies').child('Movies Title');

// ! FirebaseDatabase instance------to store data -----------
  final storeRef = FirebaseDatabase.instance.ref();

// ! Movies Title ---------------------------
  // final moviesName = 'Movies Title';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // !Floating Button
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ScratchPage(),
                ));
          },
          child: Icon(Icons.arrow_forward_ios_rounded),
        ),
        body: Form(
          key: _formkey,
          child: SingleChildScrollView(
            // physics: NeverScrollableScrollPhysics(),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Realtime Database',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Store & Fetch ',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50))),
              ),
              SizedBox(
                height: 10,
              ),
// -------------------------------DATA STOREING---------------------------------
              // ! TextFormField----------------------------------------
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Column(
                    children: [
                      TextFormField(
                        maxLines: 5,
                        textAlign: TextAlign.center,
                        controller: TextController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Text';
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'Enter what is in your mind',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      //  ! Button-----------------------------------------------
                      ElevatedButton(
                          onPressed: () {
                            storeRef
                                .child('Movies')
                                .child('Movies Title')
                                .push()
                                .set(TextController.text)
                                .asStream();
                            TextController.clear();
                          },
                          child: Text('      ADD       ')),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
// -------------------------------DATA FETCHING---------------------------------
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(15)),
                  height: MediaQuery.of(context).size.height,
                  child: FirebaseAnimatedList(
                    query: fetchRef,
                    itemBuilder: (context, snapshot, animation, index) {
                      return Column(
                        children: [
                          SingleChildScrollView(
                            child: ListTile(
                              title: Container(
                                margin: EdgeInsets.only(top: 10),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                    ),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                  snapshot
                                      .child(
                                        "Movies Title",
                                      )
                                      .value
                                      .toString(),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              trailing: Icon(
                                Icons.check_circle,
                                color: Colors.green,
                              ),
                            ),
                          ),
                          Divider(
                            color: Colors.black,
                            height: 10,
                          )
                        ],
                      );
                    },
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
