import 'package:flutter/material.dart';



class groupProfile extends StatelessWidget{
  final String child;
  groupProfile({required this.child});


  @override
  Widget build(BuildContext context)  {
    return Padding(
     padding: const EdgeInsets.symmetric(vertical: 8.0),
     child: Container(
      height: 400,
      color: Color.fromARGB(255, 16, 98, 116),
      child: Text(
        child,
        style: TextStyle(fontSize: 40),
      ),
     ),
     
     
     
     
      // body: Column(
      //   children: [
      //     Expanded(
      //     child: ListView.builder(
      //       itemCount: _posts.length,
      //       itemBuilder: (context, index) {
      //         return groupProfile(
      //           child: _posts[index],
      //         );
      //       },
      //       )
      //      )
          
          
      //   ],
      // ),

    );
  }
}