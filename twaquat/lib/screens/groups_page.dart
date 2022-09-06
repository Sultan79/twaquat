import 'package:flutter/material.dart';
import 'package:twaquat/screens/creat_group.dart';
import 'package:twaquat/widgets/groupProfile.dart';


class groupsPage  extends StatelessWidget {
static String routeName = '/groupsPage';
 groupsPage({Key? key}) : super(key: key);

  final List _posts = [
    'profile 1',
    'profile 2',
    'profile 3',
    'profile 4'];



  @override
  Widget build(BuildContext context) {

   

   return Scaffold( 
   body: SafeArea(
     child: Column(
     children:[
      Row(
        children:[
       Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () =>  Navigator.pushNamed(context, CreateGroupScreen.routeName),
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blueGrey,
            ),
            
          ),
        ),),
       
       Title(color: Colors.purple , child: const Text('Groups') ),
       
        ]
       ),

      
        Expanded(
          child: ListView.builder(
            itemCount: _posts.length,
            itemBuilder: (context, index){
              return groupProfile(
                child: _posts[index],
              );
            }),
        )
     ]
     ),
   )
  );
  }
}