// ignore_for_file: prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_const_constructors, unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';

class CustomTabWidget extends StatelessWidget {
  CustomTabWidget({
    this.tabss = const [
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
    required this.children,
    Key? key,
  }) : super(key: key);

  final List<Tab> tabss;
  List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabss.length,
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Container(
                height: 60,
                width: 350,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                  ),
                  tabs: tabss,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: TabBarView(
                  children: children,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
