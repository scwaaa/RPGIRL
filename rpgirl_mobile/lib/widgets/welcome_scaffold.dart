import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WelocomeScaffold extends StatelessWidget {
  const WelocomeScaffold({super.key, this.child, required double height, required double width});
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Center(
          child:Lottie.network(
            "https://lottie.host/25d91c54-8cb0-4bd2-bdb2-d5622a3bebbb/jxeDFH40aG.json",
          
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
            repeat: true,
            animate: true,
          ),),
          SafeArea(
            
            child: child!,
          ),
        ],
      ),
    );
  }
}
