import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:friendly_chat/post.dart';

class Login extends StatefulWidget{
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String email, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Log In'), centerTitle: true),
        body: Form(
            key: _formKey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding( //for email
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text('Email')
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    child: TextFormField(
                        validator: (String? input){
                          if(input == null || input.isEmpty){
                            return 'Enter Email';
                          }
                          return null;
                        },
                        onChanged: (value){
                          setState((){
                            email = value.trim();
                          });
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder()
                        )
                    ),
                  ),
                  Padding( //password
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text('Password')
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    child: TextFormField(
                      validator: (String? input){
                        if(input == null || input.isEmpty){ //return error if nothing happens
                          return 'Enter a password';
                        }
                        if(input.length<6){
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                      onChanged: (value){
                        setState((){
                          password = value.trim();
                        });
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder()
                      ),
                      //hides characters when typing
                      obscureText: true,
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: ElevatedButton(
                        onPressed: () {
                          signIn(email, password);
                        },
                        child: Text('Log In'),
                        style: ElevatedButton.styleFrom(primary: Colors.pink[600],
                        )
                    ),
                  ),
                ]
            )
        )
    );
  }

  Future<String?> signIn(String email, String password) async{ //for firebase auth
    try{
      await auth.signInWithEmailAndPassword(email: email, password: password);

      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> MyHomePage()));
      return 'Signed In';
    } on FirebaseAuthException catch(e){
      if(e.code == 'user-not-found'){
        return 'No user found for that email'; //message if user isn't found
      }
      else if(e.code =='wrong-password'){ //message for wrong password
        return 'Wrong password';
      }
    }
  }
}