import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class PlayPage extends StatefulWidget {
  const PlayPage({super.key});

  @override
  State<PlayPage> createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  LatLng? _currentLocation;
  bool _isLoading = true;
  Stream<Position>? _positionStream;
  final MapController _mapController = MapController();

  // Define the rectangle coordinates
  final LatLng _rectTopLeft = const LatLng(33.987672, -118.322519);
  final LatLng _rectBottomRight = const LatLng(33.987568, -118.322055);

  @override
  void initState() {
    super.initState();
    _initializeLocation();
  }

  Future<void> _initializeLocation() async {
    // Check and request location permissions
    final status = await Permission.location.request();
    
    if (status.isGranted) {
      // Get initial position
      try {
        final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        
        setState(() {
          _currentLocation = LatLng(position.latitude, position.longitude);
          _isLoading = false;
        });
        
        // Move map to current location
        _mapController.move(_currentLocation!, 18);
        
        // Start listening to location updates
        _positionStream = Geolocator.getPositionStream(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.high,
            distanceFilter: 10, // Update every 10 meters
          ),
        );
        
        // Listen to stream and update location
        _positionStream?.listen((Position position) {
          if (mounted) {
            setState(() {
              _currentLocation = LatLng(position.latitude, position.longitude);
            });
            // Update map center to follow the device
            _mapController.move(_currentLocation!, _mapController.camera.zoom);
          }
        });
      } catch (e) {
        print("Error getting location: $e");
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Helper method to create the rectangle polygon
  List<LatLng> _getRectanglePolygon() {
    return [
      _rectTopLeft, // Top-left
      LatLng(_rectTopLeft.latitude, _rectBottomRight.longitude), // Top-right
      _rectBottomRight, // Bottom-right
      LatLng(_rectBottomRight.latitude, _rectTopLeft.longitude), // Bottom-left
      _rectTopLeft, // Close the polygon
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _currentLocation ?? const LatLng(33.98341, -118.32023),
              initialZoom: 18,
              onMapReady: () {
                // If location is already available when map is ready, center it
                if (_currentLocation != null) {
                  _mapController.move(_currentLocation!, 18);
                }
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://maps.geoapify.com/v1/tile/toner-grey/{z}/{x}/{y}@2x.png?apiKey=b71d184b32ab42828fa025dd0f277544',
                userAgentPackageName: 'com.example.rpgirl2',
              ),
              // Rectangle overlay layer
              PolygonLayer(
                polygons: [
                  Polygon(
                    points: _getRectanglePolygon(),
                    color: Colors.blue.withOpacity(0.3), // 30% transparent blue
                    borderColor: Colors.blue.withOpacity(0.7),
                    borderStrokeWidth: 2,
                    //isFill: true,
                  ),
                ],
              ),
              // Marker layer for current location dot
              if (_currentLocation != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: _currentLocation!,
                      width: 20,
                      height: 20,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
          // Loading indicator
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
          // Error message if location is not available
          if (!_isLoading && _currentLocation == null)
            const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_off, size: 64, color: Colors.red),
                  SizedBox(height: 16),
                  Text(
                    'Location access required',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      'Please enable location permissions to use this feature',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Cancel any ongoing stream subscriptions
    _positionStream = null;
    super.dispose();
  }
}