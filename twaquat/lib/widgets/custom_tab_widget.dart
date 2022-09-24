// ignore_for_file: prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_const_constructors, unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';

class CustomTabWidget extends StatelessWidget {
  const CustomTabWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Container(
                height: 50,
                width: 300,
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: TabBar(
                  labelStyle: Theme.of(context).textTheme.bodySmall,
                  indicatorColor: Theme.of(context).colorScheme.primary,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.grey,
                  indicator: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(15),
                    // border: Border.all(
                    //   width: 15,
                    //   color: Colors.blue,
                    // ),
                  ),
                  tabs: [
                    Tab(
                      text: 'Ranking',
                    ),
                    Tab(
                      text: "Alart",
                    ),
                    Tab(
                      text: 'Deications',
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    ListView.builder(
                      itemCount: 100,
                      itemBuilder: (context, index) => Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Center(
                          child: Text('Ranking ${index}'),
                        ),
                      ),
                    ),
                    Container(child: Center(child: Text('Alart'))),
                    Container(child: Center(child: Text('De'))),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
