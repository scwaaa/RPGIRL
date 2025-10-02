import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:rpgirl2/config/auth_service.dart';
import 'package:rpgirl2/config/auth_wrapper.dart';
import 'package:rpgirl2/routeGenerator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Appwrite client
  Client client = Client()
      .setEndpoint("https://sfo.cloud.appwrite.io/v1")
      .setProject("68ba292d001f26db5160");
  Account account = Account(client);

  runApp(MyApp(account: account));
}

class MyApp extends StatefulWidget {
  final Account account;

  const MyApp({super.key, required this.account});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    
    return MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => AuthService(account: widget.account)),
        // You might also want to provide the Appwrite client/account directly
        Provider<Account>(create: (_) => widget.account),
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
        home: AuthWrapper(), // Use the auth wrapper as home
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}

