import 'package:flutter/material.dart';

import 'profile_screen.dart';
import 'home_screen.dart';
import 'docs_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  static const routeName = '/main';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> _pages = const [
    HomeScreen(),
    DocsScreen(),
    ProfileScreen(),
  ];

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  IconButton buildIcon(int idx, IconData icon) {
    return IconButton(
      icon: Icon(
        icon,
        color: _selectedPageIndex != idx
            ? Theme.of(context).accentColor
            : Colors.white,
        size: 35,
      ),
      onPressed: () => _selectPage(idx),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: SafeArea(child: _pages[_selectedPageIndex]),
      bottomNavigationBar: SafeArea(
        child: Container(
            margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
            //padding: EdgeInsets.all(1),
            height: 70,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildIcon(0, Icons.home),
                buildIcon(1, Icons.local_hospital),
                buildIcon(2, Icons.person),
              ],
            )),
      ),
    );
  }
}
