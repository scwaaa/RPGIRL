// custom_drawer.dart
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:provider/provider.dart';
import 'package:rpgirl2/config/auth_service.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 139, 10, 213),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 30,
                  child: Icon(
                    Icons.person,
                    size: 30,
                    color: const Color.fromARGB(255, 139, 10, 213),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Username',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'user@example.com',
                  style: TextStyle(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          
          ListTile(
            leading: Icon(FontAwesome5.box, color: const Color.fromARGB(255, 139, 10, 213)),
            title: Text('Inventory'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed(
                          '/inventory',
                        );
            },
          ),
          ListTile(
            leading: Icon(FontAwesome5.users, color: const Color.fromARGB(255, 139, 10, 213)),
            title: Text('Social'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed(
                          '/friends',
                        );
            },
          ),
           ListTile(
            leading: Icon(FontAwesome5.comments, color: const Color.fromARGB(255, 139, 10, 213)),
            title: Text('Messagaes'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed(
                          '/messages',
                        );
            },
          ),
          ListTile(
            leading: Icon(Icons.settings, color: const Color.fromARGB(255, 139, 10, 213)),
            title: Text('Settings'),
            onTap: () {
              Navigator.pop(context);
               Navigator.of(context).pushNamed(
                          '/settings',
                        );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.help, color: const Color.fromARGB(255, 139, 10, 213)),
            title: Text('Help & Support'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.logout, color: Color.fromARGB(255, 139, 10, 213)),
            title: Text('Logout'),
            onTap: () async {
              try {
                final authService = Provider.of<AuthService>(context, listen: false);
                await authService.logout();
                Navigator.pushNamedAndRemoveUntil(
                  context, 
                  '/', 
                  (route) => false
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Logout failed: $e')),
                );
              }
            },
          ),
          ],
      ),
    );
  }
}