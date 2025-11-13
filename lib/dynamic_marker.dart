

library dynamic_marker;

import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// ======================= MODEL =======================
///
/// Map এর LatLng + যেকোনো Flutter widget + anchor
class DynamicMarker {
  final LatLng position;
  final Widget child;

  /// Anchor alignment:
  /// (0,1) = bottomCenter, (-1,-1) = topLeft, (1,1) = bottomRight
  final Alignment anchor;

  const DynamicMarker({
    required this.position,
    required this.child,
    this.anchor = Alignment.bottomCenter,
  });
}

/// ======================= WIDGET =======================
///
/// GoogleMap + overlay widget markers
class DynamicMarkerGoogleMap extends StatefulWidget {
  /// GoogleMap এর initial camera
  final CameraPosition initialCameraPosition;

  /// Overlay হবে এমন dynamic widget markers
  final List<DynamicMarker> dynamicMarkers;

  /// GoogleMap এর normal markers (যদি লাগলে)
  final Set<Marker> googleMapMarkers;

  /// নিচেরগুলো GoogleMap এর common props
  final MapType mapType;
  final bool myLocationEnabled;
  final bool myLocationButtonEnabled;
  final bool zoomControlsEnabled;
  final bool compassEnabled;
  final EdgeInsets padding;

  /// Map তৈরি হলে callback (controller ধরার জন্য)
  final void Function(GoogleMapController controller)? onMapCreated;

  /// Camera move হলে external listener (optional)
  final void Function(CameraPosition position)? onCameraMove;

  /// Overlay marker touch কাজ করবে কিনা
  final bool allowMarkerInteraction;

  const DynamicMarkerGoogleMap({
    super.key,
    required this.initialCameraPosition,
    required this.dynamicMarkers,
    this.googleMapMarkers = const <Marker>{},
    this.mapType = MapType.normal,
    this.myLocationEnabled = false,
    this.myLocationButtonEnabled = false,
    this.zoomControlsEnabled = false,
    this.compassEnabled = true,
    this.padding = EdgeInsets.zero,
    this.onMapCreated,
    this.onCameraMove,
    this.allowMarkerInteraction = true,
  });

  @override
  State<DynamicMarkerGoogleMap> createState() =>
      _DynamicMarkerGoogleMapState();
}

class _DynamicMarkerGoogleMapState extends State<DynamicMarkerGoogleMap> {
  GoogleMapController? _controller;
  bool _isUpdating = false;

  /// প্রতিটা DynamicMarker এর screen position
  final Map<DynamicMarker, Offset> _markerScreenPositions = {};

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _updateMarkerPositions() async {
    if (!mounted) return;
    if (_controller == null) return;
    if (_isUpdating) return;

    _isUpdating = true;

    try {
      final mq = MediaQuery.maybeOf(context);
      if (mq == null) return;
      final devicePixelRatio = mq.devicePixelRatio;

      final Map<DynamicMarker, Offset> newPositions = {};

      for (final marker in widget.dynamicMarkers) {
        final screenCoord =
        await _controller!.getScreenCoordinate(marker.position);

        final dx = screenCoord.x / devicePixelRatio;
        final dy = screenCoord.y / devicePixelRatio;

        newPositions[marker] = Offset(dx, dy);
      }

      if (!mounted) return;

      setState(() {
        _markerScreenPositions
          ..clear()
          ..addAll(newPositions);
      });
    } finally {
      _isUpdating = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            GoogleMap(
              initialCameraPosition: widget.initialCameraPosition,
              mapType: widget.mapType,
              myLocationEnabled: widget.myLocationEnabled,
              myLocationButtonEnabled: widget.myLocationButtonEnabled,
              zoomControlsEnabled: widget.zoomControlsEnabled,
              compassEnabled: widget.compassEnabled,
              markers: widget.googleMapMarkers,
              padding: widget.padding,
              onMapCreated: (controller) async {
                _controller = controller;
                await _updateMarkerPositions();
                widget.onMapCreated?.call(controller);
              },
              onCameraMove: (position) {
                widget.onCameraMove?.call(position);
                // camera নড়লেই overlay আপডেট
                _updateMarkerPositions();
              },
              onCameraIdle: () {
                // idle এও একবার নিশ্চিত আপডেট
                _updateMarkerPositions();
              },
            ),

            /// Overlay markers
            IgnorePointer(
              ignoring: !widget.allowMarkerInteraction,
              child: Stack(
                children: _markerScreenPositions.entries.map((entry) {
                  final marker = entry.key;
                  final pos = entry.value;

                  // anchor অনুযায়ী offset ক্যাল্কুলেট:
                  // এইখানে আমরা আনুমানিক একটা default size ধরে নিচ্ছি
                  const defaultSize = Size(120, 80);
                  final halfW = defaultSize.width / 2;
                  final halfH = defaultSize.height / 2;

                  final ax = marker.anchor.x; // -1..1
                  final ay = marker.anchor.y; // -1..1

                  final offsetX = ax * halfW;
                  final offsetY = ay * halfH;

                  return Positioned(
                    left: pos.dx - offsetX,
                    top: pos.dy - offsetY,
                    child: marker.child,
                  );
                }).toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}

// TODO Implement this library.