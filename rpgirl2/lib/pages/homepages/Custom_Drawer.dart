// lib/pages/homepages/custom_drawer.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rpgirl2/config/auth_service.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  Future<void> _logout(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    
    try {
      await authService.logout();
      
      // Use Navigator with a context that's guaranteed to be available
      Navigator.of(context).pushNamedAndRemoveUntil('/auth', (route) => false);
    } catch (e) {
      // Handle logout error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Logout failed: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final user = authService.currentUser;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(user?.name ?? 'User'),
            accountEmail: Text(user?.email ?? 'email@example.com'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: user?.profilePhotoUrl != null && user!.profilePhotoUrl!.isNotEmpty
                  ? ClipOval(
                      child: Image.network(
                        user.profilePhotoUrl!,
                        fit: BoxFit.cover,
                        width: 60,
                        height: 60,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.person,
                            color: Colors.purple,
                            size: 40,
                          );
                        },
                      ),
                    )
                  : Icon(
                      Icons.person,
                      color: Colors.purple,
                      size: 40,
                    ),
            ),
            decoration: BoxDecoration(
              color: Color(0xffae69d5),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/profile');
            },
          ),
          ListTile(
            leading: Icon(Icons.inventory),
            title: Text('Inventory'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/inventory');
            },
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text('Friends'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/friends');
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/settings');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            title: Text('Logout', style: TextStyle(color: Colors.red)),
            onTap: () => _logout(context),
          ),
        ],
      ),
    );
  }
}