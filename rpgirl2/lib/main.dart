// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appwrite/appwrite.dart';
import 'package:rpgirl2/config/auth_service.dart';
import 'package:rpgirl2/config/auth_wrapper.dart';
import 'package:rpgirl2/controllers/app_state.dart';
import 'package:rpgirl2/routeGenerator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  Client client = Client()
      .setEndpoint("https://sfo.cloud.appwrite.io/v1")
      .setProject("68ba292d001f26db5160");
  Account account = Account(client);
  Databases databases = Databases(client);
  Teams teams = Teams(client); // Add Teams client

  runApp(MyApp(account: account, databases: databases, teams: teams)); // Pass teams to MyApp
}

class MyApp extends StatelessWidget {
  final Account account;
  final Databases databases;
  final Teams teams; // Add teams parameter

  const MyApp({
    super.key, 
    required this.account, 
    required this.databases,
    required this.teams, // Add to constructor
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthService>(
          create: (_) => AuthService(
            account: account, 
            databases: databases,
            teams: teams, // Add teams here
          ),
        ),
        ChangeNotifierProvider<AppState>(
          create: (_) => AppState(),
        ),
        Provider<Account>(create: (_) => account),
        Provider<Databases>(create: (_) => databases),
        Provider<Teams>(create: (_) => teams), // Add Teams provider
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
        home: AuthWrapper(),
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}