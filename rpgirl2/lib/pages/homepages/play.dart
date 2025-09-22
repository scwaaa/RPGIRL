import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class PlayPage extends StatelessWidget {
  const PlayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter: LatLng(33.98341,-118.32023 ),
              initialZoom: 18,
            ),
            children: [
              TileLayer(
                  urlTemplate: 'https://maps.geoapify.com/v1/tile/toner-grey/{z}/{x}/{y}@2x.png?apiKey=b71d184b32ab42828fa025dd0f277544',
                  userAgentPackageName: 'com.example.rpgirl2',
              ),
            ],
          ),
        ],
      ),
    );
  }
}