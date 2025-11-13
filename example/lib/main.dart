import 'package:dynamic_marker/dynamic_marker.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


void main() {
  runApp(const DynamicMarkerExampleApp());
}

class DynamicMarkerExampleApp extends StatelessWidget {
  const DynamicMarkerExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'dynamic_marker demo',
      theme: ThemeData(useMaterial3: true),
      home: const DemoHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DemoHomePage extends StatelessWidget {
  const DemoHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final markers = <DynamicMarker>[
      DynamicMarker(
        position: const LatLng(23.8103, 90.4125),
        anchor: Alignment.bottomCenter,
        child: const _DemoMarkerCard(
          title: 'Dhaka',
          subtitle: 'Custom widget marker',
          color: Colors.deepOrange,
        ),
      ),
      DynamicMarker(
        position: const LatLng(22.5726, 88.3639),
        anchor: Alignment.bottomCenter,
        child: const _DemoMarkerCard(
          title: 'Kolkata',
          subtitle: 'Any Flutter widget',
          color: Colors.purple,
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('dynamic_marker demo')),
      body: DynamicMarkerGoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(23.8103, 90.4125),
          zoom: 5,
        ),
        dynamicMarkers: markers,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),
    );
  }
}

class _DemoMarkerCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color color;

  const _DemoMarkerCard({
    required this.title,
    required this.subtitle,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 140,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.place, color: Colors.white, size: 24),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              subtitle,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 11,
              ),
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
