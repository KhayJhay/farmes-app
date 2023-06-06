import 'package:firebase2/drawer.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
        backgroundColor: Colors.green,
        elevation: 0,
      ),
      drawer: CustomDrawer(),
      body: Container(
        width: double.infinity,
        color: Colors.white,
      ),
    );
  }
}
