import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:friendly_chat/post.dart';

class signUp extends StatefulWidget{
  @override
  _signUpState createState() => new _signUpState();
}

class _signUpState extends State<signUp> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String first, last, username, email, password;
  late String currUserID = auth.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Sign Up'), centerTitle: true),
        body: Form(
            key: _formKey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    child: TextFormField(
                      validator: (String? input){
                        if(input == null || input.isEmpty){ //return error if empty field
                          return 'Enter your first name';
                        }
                        return null;
                      },
                      onChanged: (value){
                        setState((){
                          first = value.trim();
                          first = value.trim();
                        });
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'First Name'
                      ),
                    ),
                  ),
                  //last name text box
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    child: TextFormField(
                        validator: (String? input){
                          //if nothing is input into field, return error
                          if(input == null || input.isEmpty){
                            return 'Enter your last name';
                          }
                          return null;
                        },
                        onChanged: (value){
                          setState((){
                            last = value.trim();
                          });
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Last Name'
                        )
                    ),
                  ),
                  //username Text box
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    child: TextFormField(
                        validator: (String? input){
                          //if nothing is input into field, return error
                          if(input == null || input.isEmpty){
                            return 'Enter username';
                          }
                          return null;
                        },
                        onChanged: (value){
                          setState((){
                            username = value.trim();
                          });
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Username'
                        )
                    ),
                  ),
                  //email text box
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: TextFormField(
                        validator: (String? input){
                          //if nothing is input into field, return error
                          if(input == null || input.isEmpty){
                            return 'Enter your Email';
                          }
                          return null;
                        },
                        onChanged: (value){
                          setState((){
                            email = value.trim();
                          });
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email'
                        )
                    ),
                  ),
                  //Textbox for password
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: TextFormField(
                      validator: (String? input){
                        //if nothing is input into field, return error
                        if(input == null || input.isEmpty){
                          return 'Please enter a password';
                        }
                        return null;
                      },
                      onChanged: (value){
                        setState((){
                          password = value.trim();
                        });
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password: 6 or more characters'
                      ),
                      //hides characters when typing
                      obscureText: true,
                    ),
                  ),
                  //Register button
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton(
                        onPressed: () {
                          signUp(first, last, email, password);
                          signUp(first, last, email, password);
                        },
                        child: Text('Register'),
                        style: ElevatedButton.styleFrom(primary: Colors.pink
                        )
                    ),
                  ),
                ]
            )
        )
    );
  }

  Future<String?> signUp(String first, String last, String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      CollectionReference user = firestore.collection('user'); //user info
      user.doc(currUserID).set({
        'user_id': currUserID,
        'first': first,
        'last': last,
        'username': username,
        'dateTime': DateTime.now(),
        'type': 'customer'
      }).then((value) => print("User Successfully Added")).catchError((error) =>
          print("Unable to Add User:$error"));

      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MyHomePage())); //goes back to homepage

      return 'Signed Up';
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}