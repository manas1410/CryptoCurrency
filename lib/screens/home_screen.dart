import 'package:crypto_tracker/screens/first_screen.dart';
import 'package:crypto_tracker/screens/screens.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen>{
  int _selectedIndex = 0;
  static  const List<Widget> _screenList = [
    FirstScreen(),
    SecondScreen(),
    ThirdScreen(),
  ];
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: _screenList[_selectedIndex],
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(items: const <BottomNavigationBarItem> [
        BottomNavigationBarItem(icon: Icon(Icons.stairs), label: 'Crypto',),
        BottomNavigationBarItem(icon: Icon(Icons.flutter_dash), label: 'Flutter Dash',),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile',),
      ],
      currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
        backgroundColor: Colors.black,
      ),

    );
  }
  void _onItemTapped(int value){
    setState(() {
      _selectedIndex = value;
    });
  }
}
