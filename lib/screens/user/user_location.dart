import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';


class SetLocationScreen extends StatefulWidget {
  const SetLocationScreen({super.key});

  @override
  State<SetLocationScreen> createState() => _SetLocationScreenState();
}

class _SetLocationScreenState extends State<SetLocationScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _useCurrentLocation() async {
    try {
      bool serviceEnabled =
      await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled) {
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Please turn on your device location.',
            ),
          ),
        );

        await Geolocator.openLocationSettings();
        return;
      }

      LocationPermission permission =
      await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();

        if (permission == LocationPermission.denied) {
          if (!mounted) return;

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Location permission was denied.',
              ),
            ),
          );

          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Location permission is permanently denied. '
                  'Please enable it in Settings.',
            ),
          ),
        );

        await Geolocator.openAppSettings();
        return;
      }

      // Get the current location
      Position position =
      await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Location found: '
                '${position.latitude.toStringAsFixed(5)}, '
                '${position.longitude.toStringAsFixed(5)}',
          ),
        ),
      );

      print('Latitude: ${position.latitude}');
      print('Longitude: ${position.longitude}');
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Unable to get your location: $e',
          ),
        ),
      );
    }
  }

  void _finish() {
    final location = _searchController.text.trim();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          location.isEmpty
              ? 'Location selected'
              : 'Location selected: $location',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FF),
      body: SafeArea(
        child: Column(
          children: [
            // ------------------------------------------------
            // TOP BAR
            // ------------------------------------------------
            Container(
              height: 58,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFFF9F9FF),
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xFFE6E6EC),
                    width: 1,
                  ),
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    left: 16,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Color(0xFF007A59),
                        size: 25,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),

                  const Text(
                    'PharmaFinder',
                    style: TextStyle(
                      color: Color(0xFF007A59),
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),

            // ------------------------------------------------
            // MAP
            // ------------------------------------------------
            SizedBox(
              height: screenHeight * 0.315,
              width: double.infinity,
              child: Stack(
                children: [
                  // Replace this Container with your actual map widget
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: const Color(0xFFE8EAE4),

                    child: CustomPaint(
                      painter: MapPlaceholderPainter(),
                    ),
                  ),

                  // Pin in center
                  const Center(
                    child: Icon(
                      Icons.location_pin,
                      color: Color(0xFF007A59),
                      size: 42,
                    ),
                  ),
                ],
              ),
            ),


            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(
                  16,
                  10,
                  16,
                  26,
                ),
                decoration: const BoxDecoration(
                  color: Color(0xFFF9F9FF),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(22),
                    topRight: Radius.circular(22),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Drag indicator
                    Center(
                      child: Container(
                        width: 44,
                        height: 5,
                        decoration: BoxDecoration(
                          color: const Color(0xFFB7C8C1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),

                    const SizedBox(height: 27),

                    // Title
                    const Text(
                      'Set Location',
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1B2438),
                      ),
                    ),

                    const SizedBox(height: 7),

                    // Description
                    const Text(
                      'Drag the map to pinpoint your exact location in\n'
                          'Addis Ababa, or search for an\n'
                          'area.',
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.45,
                        color: Color(0xFF4D5957),
                      ),
                    ),

                    const SizedBox(height: 27),

                    // ------------------------------------------------
                    // SEARCH FIELD
                    // ------------------------------------------------
                    Container(
                      height: 46,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all(
                          color: const Color(0xFFC8D1CE),
                        ),
                      ),
                      child: TextField(
                        controller: _searchController,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xFF252D3D),
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Color(0xFF72807D),
                            size: 25,
                          ),
                          hintText:
                          'Search area, street, or building...',
                          hintStyle: TextStyle(
                            color: Color(0xFF7B8190),
                            fontSize: 16,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 11,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 22),

                    // ------------------------------------------------
                    // CURRENT LOCATION BUTTON
                    // ------------------------------------------------
                    SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: OutlinedButton.icon(
                        onPressed: _useCurrentLocation,
                        icon: const Icon(
                          Icons.my_location,
                          color: Color(0xFF007A59),
                          size: 22,
                        ),
                        label: const Text(
                          'Use current device location',
                          style: TextStyle(
                            color: Color(0xFF007A59),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: const Color(0xFFF2F5FF),
                          side: const BorderSide(
                            color: Color(0xFFC8D7E8),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // ------------------------------------------------
                    // INFORMATION CARD
                    // ------------------------------------------------
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all(
                          color: const Color(0xFFC8D1CE),
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x12000000),
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          // Info icon
                          Container(
                            width: 20,
                            height: 20,
                            decoration: const BoxDecoration(
                              color: Color(0xFF007A72),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.info_outline,
                              color: Colors.white,
                              size: 14,
                            ),
                          ),

                          const SizedBox(width: 10),

                          // Text
                          const Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Select location on map',
                                  style: TextStyle(
                                    color: Color(0xFF202939),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),

                                SizedBox(height: 4),

                                Text(
                                  'Move the map until the pin is exactly over your\n'
                                      'location. This ensures accurate routing.',
                                  style: TextStyle(
                                    color: Color(0xFF68716F),
                                    fontSize: 12,
                                    height: 1.35,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Spacer(),

                    // ------------------------------------------------
                    // FINISH BUTTON
                    // ------------------------------------------------
                    SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: _finish,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                          const Color(0xFF007A59),
                          foregroundColor: Colors.white,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                        child: const Text(
                          'Finish',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// SIMPLE MAP PLACEHOLDER
// ============================================================
// Replace this with Google Maps, OpenStreetMap, etc.
// when you connect the actual map functionality.

class MapPlaceholderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    // Roads
    paint.color = const Color(0xFFD1D3CE);

    canvas.drawLine(
      Offset(0, size.height * 0.45),
      Offset(size.width, size.height * 0.65),
      paint,
    );

    canvas.drawLine(
      Offset(size.width * 0.2, 0),
      Offset(size.width * 0.65, size.height),
      paint,
    );

    canvas.drawLine(
      Offset(size.width * 0.75, 0),
      Offset(size.width * 0.4, size.height),
      paint,
    );

    // Green areas
    final greenPaint = Paint()
      ..color = const Color(0xFFDDE9D8)
      ..style = PaintingStyle.fill;

    canvas.drawRect(
      Rect.fromLTWH(
        size.width * 0.05,
        size.height * 0.1,
        size.width * 0.4,
        size.height * 0.3,
      ),
      greenPaint,
    );

    canvas.drawRect(
      Rect.fromLTWH(
        size.width * 0.6,
        size.height * 0.55,
        size.width * 0.35,
        size.height * 0.35,
      ),
      greenPaint,
    );

    // Main road
    final mainRoad = Paint()
      ..color = const Color(0xFFA8D1A9)
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke;

    canvas.drawLine(
      Offset(0, size.height * 0.18),
      Offset(size.width, size.height * 0.3),
      mainRoad,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}