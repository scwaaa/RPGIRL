import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

void main() => runApp(MaterialApp(
    builder: (context, child) {
      return Directionality(textDirection: TextDirection.ltr, child: child!);
    },
    title: 'GNav',
    theme: ThemeData(
      primaryColor: Color.fromARGB(255, 139, 10, 213),
    ),
    home: Home()));

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Inventory',
      style: optionStyle,
    ),
    Text(
      'Inventory',
      style: optionStyle,
    ),
    Text(
      'play',
      style: optionStyle,
    ),
    Text(
      'Social',
      style: optionStyle,
    ),
    Image(
                            image: AssetImage("lib/assets/images/github.png"),
                            height: 35,
                            width: 35,
                            fit: BoxFit.cover,
                          ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 20,
        title: const Text('RPGIRL',
          style: TextStyle(
           color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255,138, 10, 213),
        
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 139, 10, 213),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 30,
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.white,
              tabs: [
                GButton(
                  icon: LineIcons.box,
                ),
                GButton(
                  icon: LineIcons.portrait,
                ),
                GButton(
                  icon: LineIcons.play,
                ),
                GButton(
                  icon: LineIcons.userFriends,
                ),
                GButton(
                  icon: LineIcons.search,
                 
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}