import 'package:flutter/material.dart';

class Description_Of_The_Application extends StatefulWidget {
  const Description_Of_The_Application({ super.key });
    static String routeName = '/description-of-the-application';
  @override
  State<Description_Of_The_Application> createState() => _Description_Of_The_ApplicationState();
}

class _Description_Of_The_ApplicationState extends State<Description_Of_The_Application> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(title: Text('WELCOME'),),

    );
  
  
  
  }
}