import 'package:fanpage/createaccount.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'authenticationservice.dart';
import 'messagescreen.dart';


class SignInScreen extends StatelessWidget{

  String mEmail = "";
  String mPassword = "";
  String mUid = "";

  late TextField mEmailField;
  late TextField mPasswordField;

  SignInScreen({Key? key}) : super(key: key){
    mEmailField =  TextField(
        onChanged: (text) {mEmail = text;},
        decoration:const InputDecoration(
            hintText: 'Email')
    );
    mPasswordField = TextField(
        onChanged: (text) {mPassword = text;},
        obscureText: true,
        decoration:const InputDecoration(
            hintText: 'Password')
    );


  }


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
          ),
          StreamProvider(
            create: (context) => context.read<AuthenticationService>().authStateChanges, initialData: null,
        )
    ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            appBar: AppBar(
              title: const Text("Fan Page"),
            ),
          body: Builder(
            builder:  (BuildContext context){
              return Center(
                child: Container(
                  height: 400,
                  width: 300,
                  child: Column(
                    children:  [
                      const Text("Log-In",
                        style: TextStyle(fontSize: 20.0),),
                      mEmailField,
                      mPasswordField,
                      TextButton(
                          child: const Text("Enter"),
                          onPressed: () {

                            emailSignIn(context);
                          }
                      ),
                      SignInButton(
                          Buttons.Google,
                          onPressed: () {

                            googleSignIn(context);
                          }
                      ),
                      TextButton(
                          child: const Text("Create Account"),
                          onPressed: () {

                            _navigateToCreateAccount(context);
                          }
                      )

                    ],
                  ),
                ),
              );
            },
          )
          ),
        )
    );
  }



  void _navigateToCreateAccount(BuildContext context){
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder:
            (context) =>
                CreateAccountScreen()
        )
    );
  }

  void emailSignIn(BuildContext context) async {
    String auth = "";
    await context.read<AuthenticationService>().signIn(
      email: mEmail,
      password: mPassword,
    ).then((String value) => auth = value);
    _navigateToMessagesScreen(context, auth);

  }
  void googleSignIn(BuildContext context) async{
    String auth = "";
    await context.read<AuthenticationService>().signInWithGoogle(context).then(
            (String value) {
              auth = value;
            });
    _navigateToMessagesScreen(context,auth);
  }
  
  void _navigateToMessagesScreen(BuildContext context, String auth){

    mUid = FirebaseAuth.instance.currentUser!.uid;


    if (auth == "Signed-in") {

      if(Navigator.canPop(context)){
        Navigator.pop(context);
      }
      Navigator.push(context,
          MaterialPageRoute(builder:
              (context) =>
              MessageScreen()
          )
      );
    }else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Failed to authenticate."),
      ));
    }

  }



}