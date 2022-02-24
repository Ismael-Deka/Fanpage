import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';


class CreateAccountScreen extends StatelessWidget{

  String mFirstName = "";
  String mLastName = "";
  String mUserName = "";
  String mPassword = "";
  bool mIsPasswordMatching = false;

  late TextField mFirstNameField;
  late TextField mLastNameField;
  late TextField mUserNameField;
  late TextField mPasswordField;
  late TextField mVerifyPasswordField;


  CreateAccountScreen({Key? key}) : super(key: key){
    mFirstNameField = TextField(
      onChanged: (firstname) {mFirstName = firstname;},
        decoration:const InputDecoration(
            hintText: 'First Name',
            contentPadding: EdgeInsets.all(20.0)
        )
    );
    mLastNameField =TextField(
        onChanged: (lastname) {mLastName = lastname;},
        decoration:const InputDecoration(
            hintText: 'Last Name',
            contentPadding: EdgeInsets.all(20.0))
    );
    mUserNameField = TextField(
        onChanged: (username) {mUserName = username;},
        decoration:const InputDecoration(
            hintText: 'Username',
            contentPadding: EdgeInsets.all(20.0))
    );
    mPasswordField = TextField(
        onChanged: (password) {mPassword = password;},
        obscureText: true,
        decoration:const InputDecoration(
            hintText: 'Password',
            contentPadding: EdgeInsets.all(20.0))

    );
    mVerifyPasswordField = TextField(
        onChanged: (verifypassword) {_verifyPassword(verifypassword);},
        obscureText: true,
        decoration:const InputDecoration(
            hintText: 'Password',
            contentPadding: EdgeInsets.all(20.0))
    );
  }

  @override
  Widget build(BuildContext context) {
    // Create a CollectionReference called users that references the firestore collection
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Create Account"),
        ),
        body: Center(
          child: Container(

            child: Column(
              children:  [
              mFirstNameField,
              mLastNameField,
              mUserNameField,
              mPasswordField,
              mVerifyPasswordField,
              TextButton(
                    child: const Text("Enter"),
                    onPressed: () {
                      _createAccount(context);
                    }
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
  void _verifyPassword(String password){
    mIsPasswordMatching = (password == mPassword);

  }

  void _createAccount(BuildContext context){

    if(!mIsPasswordMatching){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Passwords don't match."),
      ));
      return;
    }
    if(mFirstName == "" || mLastName == "" || mUserName == "" || mPassword == "" ){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("All field must be completed"),
      ));
      return;
    }
    addUser();

  }
  Future<void> addUser() {
    // Call the user's CollectionReference to add a new user
    CollectionReference users = FirebaseFirestore.instance.collection('fanpage-db');
    return users
        .add({
      'firstname': mFirstName,
      'lastname': mLastName,
      'username': mUserName,
      'password': mPassword,
      'role': 'customer',
      'reg_date': _getTodaysDate(),
      'user_ID': _generateUserID()

    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  String _getTodaysDate(){
    var now = DateTime.now();
    var formatter = DateFormat('MM-dd-yyyy');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }

  int _generateUserID(){
    int id = DateTime.now().millisecondsSinceEpoch;
    return id;


  }





}