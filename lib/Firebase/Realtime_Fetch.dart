import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class RealtimeFetchScreen extends StatefulWidget {
  const RealtimeFetchScreen({super.key});

  @override
  State<RealtimeFetchScreen> createState() => _RealtimeFetchScreenState();
}

class _RealtimeFetchScreenState extends State<RealtimeFetchScreen> {
  // ! create a instance
  final ref = FirebaseDatabase.instance.ref('Movies').child('Movies Title');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.amber,
      body: Center(
        child: Column(
          children: [
            // ! Streambuilder

            Expanded(
              child: FirebaseAnimatedList(
                defaultChild: Text('Loading.....'),
                query: ref,
                itemBuilder: (context, snapshot, animation, index) {
                  return ListTile(
                    title:
                        Text(snapshot.child('Movies Title').value.toString()),
                    subtitle:
                        Text(snapshot.child('Movies Text').value.toString()),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
