import 'package:flutter/widgets.dart';
import 'package:friendly_chat/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:friendly_chat/chat.dart';

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late String currUserID = auth.currentUser!.uid;

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: Scaffold(
        appBar: AppBar(
            title: Text('Home Screen'),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.logout,color: Colors.white),
                  onPressed: () => showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                          content: Text('Are you sure you want to log out?'),
                          actions: <Widget>[

                            TextButton(
                              child: Text('Close'),
                              onPressed: () => Navigator.pop(context, 'Close'),
                            ),
                            TextButton(
                              child: Text('Yes'),
                              onPressed: () {
                                auth.signOut();
                                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Home()));
                              },
                            ),
                          ]
                      )
                  )
              )
            ]
        ),

        body: StreamBuilder<QuerySnapshot>(
          stream: firestore.collection('user').where('user_id', isNotEqualTo: currUserID).snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else
              return ListView(
                children: snapshot.data!.docs.map((doc) {
                  return Card(
                    child: ListTile(
                      title: Text(doc['username']),
                      trailing: ElevatedButton(
                        onPressed: (){
                          String username = doc['username'];
                          String userID = doc['user_id'];
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Chat(peer: username,
                              peerID: userID)));
                        },
                          child: Text('Message')
                      )
                    ),
                  );
                }).toList(),
              );
          },
        ),
      ),
    );
  }
}
