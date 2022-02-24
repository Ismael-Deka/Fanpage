import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageScreen extends StatelessWidget{



  MessageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Messages"),
        ),
        floatingActionButton: Visibility(

            child:FloatingActionButton(
              onPressed: () {  },
              child: const Icon(Icons.add),)
        ),
        body: Container(
          child: ListView(
            children: pullMessages(),
          ),
        )
      ),
    );
  }

  List<Row> pullMessages(){


    var message = "";

    FirebaseFirestore.instance
        .collection('fanpage-messages')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        message = doc["message"];

      });
    });
    return List<Row>.generate(2, (index) => Row(
      children: [Text(message)],
    ));

  }


}