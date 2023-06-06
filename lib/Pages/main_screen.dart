import 'package:firebase2/Pages/home.dart';
import 'package:firebase2/Pages/iot_page.dart';
import 'package:firebase2/Pages/search.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> pages = [const HomePage(), const Search(), const IoT_Page()];

  final List<BottomNavigationBarItem> _items = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    const BottomNavigationBarItem(
        icon: Icon(Icons.search_outlined), label: "Search"),
    const BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "IoT"),
  ];
  int currentPage = 0;

  void _changedPage(int index) {
    setState(() {
      currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentPage],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green,
        selectedFontSize: 18,
        selectedItemColor: Colors.white,
        unselectedItemColor: Color.fromARGB(255, 255, 255, 255),
        unselectedFontSize: 16,
        currentIndex: currentPage,
        type: BottomNavigationBarType.fixed,
        items: _items,
        onTap: _changedPage,
      ),
    );
  }
}
