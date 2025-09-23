import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/rpg_awesome_icons.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:rpgirl2/pages/homepages/MyProfile.dart';
import 'package:rpgirl2/pages/homepages/play.dart';
import 'package:rpgirl2/pages/homepages/search.dart';
import 'package:rpgirl2/pages/homepages/Custom_Drawer.dart'; // Import the custom drawer

void main() => runApp(MaterialApp(
    builder: (context, child) {
      return Directionality(textDirection: TextDirection.ltr, child: child!);
    },
    title: 'RPGIRL',
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
  int _selectedIndex = 1;
  final PageController _pageController = PageController(
    initialPage: 1,
  );
  bool _isBottomMenuOpen = false;

  final List<Widget> _pages = [
    MyProfilePage(),
    PlayPage(),
    SearchPage(),
  ];
  
  final List<String> _appBarTitles = [
    'My Profile',
    'RPGIRL',
    'Search'
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      final page = _pageController.page?.round();
      if (page != null && page != _selectedIndex) {
        setState(() {
          _selectedIndex = page;
          _isBottomMenuOpen = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _toggleBottomMenu() {
    setState(() {
      _isBottomMenuOpen = !_isBottomMenuOpen;
    });
  }

  // Helper method to get the nav index from page index
  int _getNavIndexFromPageIndex(int pageIndex) {
    switch (pageIndex) {
      case 0: // MyProfilePage
        return 0;
      case 2: // DiscoveryPage
        return 1;
      default: // PlayPage or others
        return -1; // No selection in nav bar
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 20,
        centerTitle: true,
        title: Text(_appBarTitles[_selectedIndex],
          style: TextStyle(color: Colors.white),
        ),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              color: Colors.white,
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            color: Color(0xffffffff),
            iconSize: 30,
            onPressed: () {
              Navigator.of(context).pushNamed(
                          '/friends',
                        );
            },
          ),
          IconButton(
            icon: const Icon(FontAwesome5.comments),
            color: Color(0xffffffff),
            iconSize: 30,
            padding: EdgeInsets.fromLTRB(8, 0, 16, 0),
            onPressed: () {
              Navigator.of(context).pushNamed(
                          '/messages',
                        );
            },
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 138, 10, 213),
      ),
      drawer: Drawer(
        child: CustomDrawer(),
      ), // Using the custom drawer
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            physics: ClampingScrollPhysics(),
            onPageChanged: (index) {
              setState(() {
                _selectedIndex = index;
                _isBottomMenuOpen = false;
              });
            },
            children: _pages,
          ),
          
          // Bottom Menu Overlay
          if (_isBottomMenuOpen)
            Positioned.fill(
              child: GestureDetector(
                onTap: _toggleBottomMenu,
                child: Container(
                  color: Colors.black.withOpacity(0.3),
                ),
              ),
            ),
          
          // Bottom Menu Content
          if (_isBottomMenuOpen)
            Positioned(
              bottom: 80,
              left: 0,
              right: 0,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildMenuItem(RpgAwesome.player, 'Practice', () {
                      _toggleBottomMenu();
                       Navigator.of(context).pushNamed(
                          '/quickplay',
                        );
                    }),
                    Divider(height: 1),
                    _buildMenuItem(Icons.gamepad, 'Create / Join Room', () {
                      _toggleBottomMenu();
                      Navigator.of(context).pushNamed(
                          '/quickplay',
                        );
                    }),
                    Divider(height: 1),
                    _buildMenuItem(RpgAwesome.crossed_swords, 'Event', () {
                      _toggleBottomMenu();
                    }),
                    
                    
                  ],
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          if (_selectedIndex == 1) {
            _toggleBottomMenu();
          } else {  
            setState(() {
              _selectedIndex = 1;
              _isBottomMenuOpen = false;
            });
            _pageController.animateToPage(
              1,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }
        },
        child: const Icon(FontAwesome.play),
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
                  icon: FontAwesome.user,
                ),
                GButton(
                  icon: FontAwesome5.search,
                ),
              ],
              selectedIndex: _getNavIndexFromPageIndex(_selectedIndex),
              onTabChange: (index) {
                // Map navigation indices to page indices:
                // Nav index 0 -> Page index 0 (MyProfilePage)
                // Nav index 1 -> Page index 2 (DiscoveryPage)
                int pageIndex = index == 0 ? 0 : 2;
                
                setState(() {
                  _selectedIndex = pageIndex;
                  _isBottomMenuOpen = false;
                });
                _pageController.animateToPage(
                  pageIndex,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
  
  Widget _buildMenuItem(IconData icon, String text, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Color.fromARGB(255, 139, 10, 213)),
      title: Text(text),
      onTap: onTap,
    );
  }
}