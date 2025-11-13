# 🗺️ dynamic_marker

> Bring your **Flutter UI** onto **Google Maps** – not just icons, but *any* widget.

<p align="center">
  <a href="https://ibb.co.com/3yydzcQp">
    <img src="https://ibb.co.com/3yydzcQp" alt="dynamic_marker demo" width="320">
  </a>
</p>

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
  dynamic_marker:
    path: ../dynamic_marker    # or use the pub.dev version when published
