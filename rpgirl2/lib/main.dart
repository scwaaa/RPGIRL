// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appwrite/appwrite.dart';
import 'package:rpgirl2/config/auth_service.dart';
import 'package:rpgirl2/config/auth_wrapper.dart'; // Add this import
import 'package:rpgirl2/controllers/app_state.dart';
import 'package:rpgirl2/routeGenerator.dart'; // Add this import

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  Client client = Client()
      .setEndpoint("https://sfo.cloud.appwrite.io/v1")
      .setProject("68ba292d001f26db5160");
  Account account = Account(client);

  runApp(MyApp(account: account));
}

class MyApp extends StatelessWidget {
  final Account account;

  const MyApp({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthService>(
          create: (_) => AuthService(account: account),
        ),
        ChangeNotifierProvider<AppState>(
          create: (_) => AppState(),
        ),
        Provider<Account>(create: (_) => account),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return Directionality(textDirection: TextDirection.ltr, child: child!);
        },
        title: 'RPGIRL',
        theme: ThemeData(
          primaryColor: Color.fromARGB(255, 139, 10, 213),
        ),
        home: AuthWrapper(), // This should work now
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}