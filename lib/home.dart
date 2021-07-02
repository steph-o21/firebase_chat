import 'package:flutter/material.dart';
import 'package:friendly_chat/login.dart';
import 'package:friendly_chat/signup.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text('Friendly Chat App')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(15),
                child: Image.asset('assets/chat.jpeg'),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => signUp()),
                          );
                        },
                        child: Text('Sign Up'),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.pink)
                    ),
                    SizedBox(width: 50),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                          );
                        },
                        child: Text('Log In'),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.pink))
                  ]
              ),
              SizedBox(height: 50),
              //sign up
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 20.0, right: 20.0),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 20.0, right: 20.0),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}