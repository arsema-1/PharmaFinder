import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'user_shell.dart';

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
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled) {
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please turn on your device location.')),
        );

        await Geolocator.openLocationSettings();
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();

        if (permission == LocationPermission.denied) {
          if (!mounted) return;

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permission was denied.')),
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

      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
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

      // ignore: avoid_print
      debugPrint('Latitude: ${position.latitude}');
      // ignore: avoid_print
      debugPrint('Longitude: ${position.longitude}');
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Unable to get your location: $e')),
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
                  bottom: BorderSide(color: Color(0xFFE6E6EC), width: 1),
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
                  Image.asset(
                    'assets/images/city_map.jpg',
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),

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
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 26),
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
                        border: Border.all(color: const Color(0xFFC8D1CE)),
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
                          hintText: 'Search area, street, or building...',
                          hintStyle: TextStyle(
                            color: Color(0xFF7B8190),
                            fontSize: 16,
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 11),
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
                          side: const BorderSide(color: Color(0xFFC8D7E8)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),




                    SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () {
                          _finish();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const UserShell(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF007A59),
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

