import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../../viewmodels/pharmacy_vm.dart';
import '../user/user_shell.dart';

class RegisterPharmacyStep3 extends StatefulWidget {
  final String userId;
  final String ownerName;
  final String pharmacyName;
  final String pharmacyPhone;
  final String address;
  final String license;

  const RegisterPharmacyStep3({
    super.key,
    required this.userId,
    required this.ownerName,
    required this.pharmacyName,
    required this.pharmacyPhone,
    required this.address,
    required this.license,
  });

  @override
  State<RegisterPharmacyStep3> createState() => _RegisterPharmacyStep3State();
}

class _RegisterPharmacyStep3State extends State<RegisterPharmacyStep3> {
  double? _latitude;
  double? _longitude;
  bool _locationFetched = false;
  bool _isLoading = false;

  final _pharmacyVm = PharmacyViewModel();

  Future<void> _fetchLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _showError('Please enable location services.');
      await Geolocator.openLocationSettings();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _showError('Location permission denied.');
        return;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      _showError(
        'Location permission is permanently denied. Enable it in Settings.',
      );
      await Geolocator.openAppSettings();
      return;
    }

    final pos = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );

    setState(() {
      _latitude = pos.latitude;
      _longitude = pos.longitude;
      _locationFetched = true;
    });
  }

  Future<void> _handleComplete() async {
    if (!_locationFetched || _latitude == null || _longitude == null) {
      _showError('Please set the pharmacy location first.');
      return;
    }

    setState(() => _isLoading = true);

    final success = await _pharmacyVm.savePharmacy(
      userId: widget.userId,
      name: widget.pharmacyName,
      address: widget.address,
      latitude: _latitude!,
      longitude: _longitude!,
      phone: widget.pharmacyPhone,
      licenseNumber: widget.license,
    );

    if (!mounted) return;
    setState(() => _isLoading = false);

    if (success) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const UserShell()),
        (route) => false,
      );
    } else {
      _showError(_pharmacyVm.errorMessage ?? 'Failed to save pharmacy.');
    }
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Colors.red.shade700,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F9FC),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF00805A)),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'PharmaFinder',
          style: TextStyle(
            color: Color(0xFF007A55),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: Colors.grey.shade200),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    const Text(
                      'Register Your Pharmacy',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF007A55),
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      'Step 3 of 3: Pharmacy Location',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Step indicator
                    Row(
                      children: [
                        _stepBar(active: true),
                        const SizedBox(width: 6),
                        _stepBar(active: true),
                        const SizedBox(width: 6),
                        _stepBar(active: true),
                      ],
                    ),

                    const SizedBox(height: 32),

                    // Map placeholder
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        'assets/images/city_map.jpg',
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),

                    const SizedBox(height: 24),

                    const Text(
                      'Pin Your Pharmacy Location',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF202838),
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      'Use your device GPS to set the exact location of your pharmacy so customers can find you.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Location button
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: OutlinedButton.icon(
                        onPressed: _fetchLocation,
                        icon: Icon(
                          _locationFetched
                              ? Icons.check_circle_outline
                              : Icons.my_location,
                          color: const Color(0xFF007A55),
                        ),
                        label: Text(
                          _locationFetched
                              ? 'Location set  '
                                  '(${_latitude!.toStringAsFixed(4)}, '
                                  '${_longitude!.toStringAsFixed(4)})'
                              : 'Use current device location',
                          style: const TextStyle(
                            color: Color(0xFF007A55),
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: const Color(0xFFF0F9F5),
                          side: BorderSide(
                            color:
                                _locationFetched
                                    ? const Color(0xFF007A55)
                                    : const Color(0xFFB8D8CC),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),

                    if (_locationFetched) ...[
                      const SizedBox(height: 14),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEBF7F2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: Color(0xFF007A55),
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                '${widget.address}\n'
                                'Lat: ${_latitude!.toStringAsFixed(6)}, '
                                'Lng: ${_longitude!.toStringAsFixed(6)}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF007A55),
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),

            // Bottom buttons
            Container(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 8,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFF007A55)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: const Text(
                          'Back',
                          style: TextStyle(
                            color: Color(0xFF007A55),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _handleComplete,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF007A55),
                          foregroundColor: Colors.white,
                          disabledBackgroundColor: const Color(
                            0xFF007A55,
                          ).withValues(alpha: 0.6),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child:
                            _isLoading
                                ? const SizedBox(
                                  width: 22,
                                  height: 22,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    color: Colors.white,
                                  ),
                                )
                                : const Text(
                                  'Complete Registration',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _stepBar({required bool active}) => Expanded(
    child: Container(
      height: 6,
      decoration: BoxDecoration(
        color: active ? const Color(0xFF007A55) : const Color(0xFFDDE3F7),
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}
