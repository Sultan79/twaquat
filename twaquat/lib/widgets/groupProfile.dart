import 'package:flutter/material.dart';



class groupProfile extends StatelessWidget{
  final String child;
  groupProfile({required this.child});


  @override
  Widget build(BuildContext context)  {
    return Padding(
     padding: const EdgeInsets.symmetric(vertical: 8.0),
     child: Container(
      height: 150,
      color: Colors.deepPurple,
      child: Text(
        child,
        style: TextStyle(fontSize: 20),
      ),
     ),
    );
  }
}