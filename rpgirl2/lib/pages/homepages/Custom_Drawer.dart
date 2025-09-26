// custom_drawer.dart (Simplified)
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:provider/provider.dart';
import 'package:rpgirl2/config/auth_service.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final user = authService.currentUser;

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
                  child: user != null 
                      ? ClipOval(
                          child: Image.network(
                            "https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_1280.png",
                            width: 54,
                            height: 54,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Icon(
                          Icons.person,
                          size: 30,
                          color: const Color.fromARGB(255, 139, 10, 213),
                        ),
                ),
                SizedBox(height: 10),
                Text(
                  user?.name ?? 'Loading...',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  user?.email ?? 'Loading email...',
                  style: TextStyle(
                    color: Colors.white70,
                  ),
                ),
                /*if (user != null) 
                  Row(
                    children: [
                      Icon(
                        user.isEmailVerified ? Icons.verified : Icons.email,
                        color: user.isEmailVerified ? Colors.green : Colors.orange,
                        size: 14,
                      ),
                      SizedBox(width: 4),
                      Text(
                        user.isEmailVerified ? 'Verified' : 'Unverified',
                        style: TextStyle(
                          color: user.isEmailVerified ? Colors.green : Colors.orange,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),*/
              ],
            ),
          ),
          
          ListTile(
            leading: Icon(FontAwesome5.box, color: const Color.fromARGB(255, 139, 10, 213)),
            title: Text('Inventory'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed('/inventory');
            },
          ),
          ListTile(
            leading: Icon(FontAwesome5.users, color: const Color.fromARGB(255, 139, 10, 213)),
            title: Text('Social'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed('/friends');
            },
          ),
          ListTile(
            leading: Icon(FontAwesome5.comments, color: const Color.fromARGB(255, 139, 10, 213)),
            title: Text('Messages'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed('/messages');
            },
          ),
          ListTile(
            leading: Icon(Icons.settings, color: const Color.fromARGB(255, 139, 10, 213)),
            title: Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed('/settings');
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