# 🗺️ dynamic_marker

> Bring your **Flutter UI** onto **Google Maps** – not just icons, but *any* widget.

![Linear Date Picker Demo](https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExZHh0ZTh6NmllcHg3cnFpOGxycWxpcWszNHU4b3YwMXdyZm11MW05ZiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/Y4GgydqhMTi7Mz2ggr/giphy.gif)

### Add **ANY Flutter Widget** as a Google Maps Marker

`dynamic_marker` lets you place **custom Flutter widgets** on top of `GoogleMap` — instead of being limited to static bitmap icons.

Want a card with title + subtitle?  
A profile bubble?  
A fully interactive bottom sheet–style marker with buttons and animations?

All of that works. If it’s a Flutter widget, it can be a marker. ✅

You can use:

- `Container`, `Card`, `Column`, `Row`
- `Image` / network images
- `Text` & badges
- `ElevatedButton`, `IconButton`
- Animations, `Lottie`, `Hero`
- Even `VideoPlayer` or other interactive widgets

Perfect for building **rich, dynamic map interfaces**.

---

## ⭐ Features

- 🎨 **Any widget as a marker**  
  Use your existing Flutter widgets directly on the map.

- 🧭 **Auto-updated positions**  
  Markers stay in the right place while you **pan**, **zoom**, or **tilt** the map.

- 🎯 **Anchor alignment control**  
  Choose where your widget is anchored:  
  top-left, center, bottom-center, etc.

- 🗺 **Plays nicely with normal `Marker`s**  
  You can mix `dynamic_marker` widgets with regular `google_maps_flutter` markers.

- ⚡ **Pure Flutter implementation**  
  No extra native iOS/Android code required.

- 🤝 **Use cases**
  - Live delivery & driver tracking
  - Real-estate / hotel / listing previews
  - Social & location-based apps
  - Profile bubbles and user pins
  - Store / product popups
  - Animated or interactive map markers

---





## 📦 Installation

Add this to your project's `pubspec.yaml`:

```yaml
dependencies:
  google_maps_flutter: ^2.9.0
  dynamic_marker: ^0.0.5


```
## Usage

Then import

```dart
import 'package:dynamic_marker/dynamic_marker.dart';
```

Then use this code


```dart

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dynamic_marker/dynamic_marker.dart';

class DynamicMarkerExample extends StatelessWidget {
  const DynamicMarkerExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DynamicMarkerGoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(23.7808, 90.2794), // Example: Dhaka
          zoom: 13,
        ),
        dynamicMarkers: [
          DynamicMarker(
            position: const LatLng(23.7808, 90.2794),
            anchor: Alignment.bottomCenter,
            child: Container(
              width: 160,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      "https://picsum.photos/120",
                      height: 80,
                      width: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "Premium Location",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Open details page / bottom sheet
                    },
                    child: const Text("Open Details"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}





```
