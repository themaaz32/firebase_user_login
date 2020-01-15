import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final name;
  final imageUrl;

  HomeScreen({this.name, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("You are Logged in succesfully", style: TextStyle(color: Colors.lightBlue, fontSize: 32),),
            SizedBox(height: 16,),
            Text("Your name is $name", style: TextStyle(color: Colors.black, fontSize: 18),),
            Text("$imageUrl", style: TextStyle(color: Colors.grey, ),),
          ],
        ),
      ),
    );
  }
}
