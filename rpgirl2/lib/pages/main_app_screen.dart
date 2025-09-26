// lib/pages/main_app_screen.dart
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/rpg_awesome_icons.dart';
import 'package:provider/provider.dart';
import 'package:rpgirl2/controllers/app_state.dart';
import 'package:rpgirl2/pages/homepages/MyProfile.dart';
import 'package:rpgirl2/pages/homepages/play.dart';
import 'package:rpgirl2/pages/homepages/search.dart';
import 'package:rpgirl2/pages/homepages/Custom_Drawer.dart';

class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key});

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  // Define pages list as instance variable to avoid const issues
  final List<Widget> _pages = [
    MyProfilePage(), // Index 0
    PlayPage(),      // Index 1
    SearchPage(),    // Index 2
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      drawer: Drawer(child: CustomDrawer()),
      body: _buildBody(context),
      floatingActionButton: _buildFAB(context),
      bottomNavigationBar: _buildCustomBottomNav(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    
    return AppBar(
      elevation: 20,
      centerTitle: true,
      title: Text(
        appState.currentPageTitle,
        style: TextStyle(color: Colors.white),
      ),
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications, color: Colors.white, size: 30),
          onPressed: () => Navigator.of(context).pushNamed('/friends'),
        ),
        IconButton(
          icon: const Icon(FontAwesome5.comments, color: Colors.white, size: 30),
          padding: EdgeInsets.fromLTRB(8, 0, 16, 0),
          onPressed: () => Navigator.of(context).pushNamed('/messages'),
        ),
      ],
      backgroundColor: const Color.fromARGB(255, 138, 10, 213),
    );
  }

  Widget _buildBody(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    
    // Double safety check
    final safeIndex = appState.currentPageIndex.clamp(0, _pages.length - 1);
    
    return Stack(
      children: [
        // Main Content - Using IndexedStack for better performance
        IndexedStack(
          index: safeIndex,
          children: _pages,
        ),

        // Bottom Menu Overlay
        if (appState.isBottomMenuOpen) _buildBottomMenuOverlay(context, appState),

        // Bottom Menu Content
        if (appState.isBottomMenuOpen) _buildBottomMenu(context, appState),
      ],
    );
  }

  Widget _buildBottomMenuOverlay(BuildContext context, AppState appState) {
    return Positioned.fill(
      child: GestureDetector(
        onTap: () => appState.toggleBottomMenu(),
        child: Container(color: Color.fromRGBO(0, 0, 0, 0.3)),
      ),
    );
  }

  Widget _buildBottomMenu(BuildContext context, AppState appState) {
    return Positioned(
      bottom: 80,
      left: 20,
      right: 20,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.2),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          children: [
            _buildMenuItem(RpgAwesome.player, 'Practice', () {
              appState.toggleBottomMenu();
              Navigator.of(context).pushNamed('/quickplay');
            }),
            Divider(height: 1),
            _buildMenuItem(Icons.gamepad, 'Create / Join Room', () {
              appState.toggleBottomMenu();
              Navigator.of(context).pushNamed('/quickplay');
            }),
            Divider(height: 1),
            _buildMenuItem(RpgAwesome.crossed_swords, 'Event', () {
              appState.toggleBottomMenu();
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String text, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Color.fromARGB(255, 139, 10, 213)),
      title: Text(text),
      onTap: onTap,
    );
  }

  Widget _buildFAB(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    
    return FloatingActionButton(
      onPressed: () {
        if (appState.currentPageIndex == 1) {
          appState.toggleBottomMenu();
        } else {
          appState.setCurrentPage(1); // Navigate to PlayPage
        }
      },
      child: const Icon(FontAwesome.play),
    );
  }

  Widget _buildCustomBottomNav(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final currentPageIndex = appState.currentPageIndex;
    
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 139, 10, 213),
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: Color.fromRGBO(0, 0, 0, 0.1),
          )
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Profile Tab
              _buildNavItem(
                icon: FontAwesome.user,
                label: 'Profile',
                isSelected: currentPageIndex == 0,
                onTap: () => appState.setCurrentPage(0),
              ),
              
              // Spacer for FAB
              SizedBox(width: 60),
              
              // Search Tab
              _buildNavItem(
                icon: FontAwesome5.search,
                label: 'Search',
                isSelected: currentPageIndex == 2,
                onTap: () => appState.setCurrentPage(2),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.grey[100] : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.black : Colors.white,
              size: 24,
            ),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.white,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}