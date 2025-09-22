import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:rpgirl2/pages/homepages/MyProfile.dart';
import 'package:rpgirl2/pages/homepages/play.dart';
import 'package:rpgirl2/pages/homepages/discovery.dart';

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
class MyCascadingMenu extends StatefulWidget {
  const MyCascadingMenu({super.key});

  @override
  State<MyCascadingMenu> createState() => _MyCascadingMenuState();
}

class _MyCascadingMenuState extends State<MyCascadingMenu> {
  final FocusNode _buttonFocusNode = FocusNode(debugLabel: 'Menu Button');

  @override
  void dispose() {
    _buttonFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      childFocusNode: _buttonFocusNode,
      menuChildren: <Widget>[
        MenuItemButton(onPressed: () {}, child: const Text('Revert')),
        MenuItemButton(onPressed: () {}, child: const Text('Setting')),
        MenuItemButton(onPressed: () {}, child: const Text('Send Feedback')),
      ],
      builder: (_, MenuController controller, Widget? child) {
        return IconButton(
          focusNode: _buttonFocusNode,
          onPressed: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          icon: const Icon(Icons.settings),
          
        );
      },
    );
  }
}

class _HomeState extends State<Home> {
  int _selectedIndex = 1;
  final PageController _pageController = PageController(
    initialPage: 1,
  );

  final List<Widget> _pages = [
    MyProfilePage(),
    DiscoveryPage(),
    PlayPage(),
    
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
      // Optional: Sync page controller with bottom nav
      final page = _pageController.page?.round();
      if (page != null && page != _selectedIndex) {
        setState(() {
          _selectedIndex = page;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        
        elevation: 20,
        centerTitle: true,
        title:  Text(_appBarTitles[_selectedIndex],
          style: TextStyle(color: Colors.white),
        ),
       /* leading: IconButton(
          icon: const Icon(Icons.settings),
          color: Color(0xffffffff),
          iconSize: 30,
          onPressed: () {
            open
          },
        ),*/
        actions: [
           IconButton(
          icon: const Icon(Icons.add),
          color: Color(0xffffffff),
          iconSize: 30,
          onPressed: () {
            
          },
        ),
         /*  IconButton(
          icon: const Icon(Icons.play_arrow),
          color: Color(0xffffffff),
          iconSize: 30,
          onPressed: () {
            
          },
        ),*/
            
          ],
        backgroundColor: const Color.fromARGB(255, 138, 10, 213),
      ),
      drawer: Drawer(),
      body: PageView(
        controller: _pageController,
        physics: ClampingScrollPhysics(), // Smooth scrolling
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: _pages,
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
                    icon: LineIcons.portrait,
                  ),
                  GButton(
                    icon: LineIcons.play,
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
                  _pageController.animateToPage(
                    index,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
              ),
            ),
          ),
        ),
      
    );
  }
}