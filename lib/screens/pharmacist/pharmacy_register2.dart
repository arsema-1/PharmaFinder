import 'package:flutter/material.dart';
import 'pharmacy_register3.dart';

class RegisterPharmacyStep2 extends StatefulWidget {
  final String userId;
  final String ownerName;
  final String ownerPhone;

  const RegisterPharmacyStep2({
    super.key,
    required this.userId,
    required this.ownerName,
    required this.ownerPhone,
  });

  @override
  State<RegisterPharmacyStep2> createState() => _RegisterPharmacyStep2State();
}

class _RegisterPharmacyStep2State extends State<RegisterPharmacyStep2> {
  final _pharmacyNameController = TextEditingController();
  final _pharmacyPhoneController = TextEditingController();
  final _licenseController = TextEditingController();
  final _addressController = TextEditingController();

  // Placeholder for uploaded file name
  String? _uploadedFileName;

  @override
  void dispose() {
    _pharmacyNameController.dispose();
    _pharmacyPhoneController.dispose();
    _licenseController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _handleNext() {
    final name = _pharmacyNameController.text.trim();
    final address = _addressController.text.trim();

    if (name.isEmpty || address.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please fill in pharmacy name and address.'),
          backgroundColor: Colors.red.shade700,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (_) => RegisterPharmacyStep3(
              userId: widget.userId,
              ownerName: widget.ownerName,
              pharmacyName: name,
              pharmacyPhone: _pharmacyPhoneController.text.trim(),
              address: address,
              license: _licenseController.text.trim(),
            ),
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
                    // ── Title ────────────────────────────────────────────
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
                      'Step 2 of 3: Pharmacy Information',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // ── Step indicator ───────────────────────────────────
                    Row(
                      children: [
                        _stepBar(active: true),
                        const SizedBox(width: 6),
                        _stepBar(active: true),
                        const SizedBox(width: 6),
                        _stepBar(active: false),
                      ],
                    ),

                    const SizedBox(height: 28),

                    // ── Pharmacy Name ────────────────────────────────────
                    _label('Pharmacy Name'),
                    const SizedBox(height: 6),
                    _field(
                      controller: _pharmacyNameController,
                      hint: 'e.g. HealthCare Pharmacy Bole',
                      icon: Icons.store_outlined,
                    ),

                    const SizedBox(height: 18),

                    // ── Pharmacy Phone ───────────────────────────────────
                    _label('Pharmacy Phone'),
                    const SizedBox(height: 6),
                    _field(
                      controller: _pharmacyPhoneController,
                      hint: '+251 911 234 567',
                      icon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                    ),

                    const SizedBox(height: 18),

                    // ── License Number ───────────────────────────────────
                    _label('Registration/License Number'),
                    const SizedBox(height: 6),
                    _field(
                      controller: _licenseController,
                      hint: 'e.g. FMHACA-12345-AA',
                      icon: Icons.badge_outlined,
                    ),

                    const SizedBox(height: 18),

                    // ── Address ──────────────────────────────────────────
                    _label('Pharmacy Address (Detailed)'),
                    const SizedBox(height: 6),
                    _multilineField(
                      controller: _addressController,
                      hint:
                          'Building Name, Floor, Specific Area\n'
                          '(e.g. Next to Zefmesh Grand Mall)',
                    ),

                    const SizedBox(height: 24),

                    // ── Document upload ──────────────────────────────────
                    Row(
                      children: [
                        const Text(
                          'Pharmacy License Document (Optional)',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF30343B),
                          ),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.lock_outline,
                          size: 13,
                          color: Color(0xFF007A55),
                        ),
                        const SizedBox(width: 3),
                        Text(
                          'Secure',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    GestureDetector(
                      onTap: () {
                        // TODO: integrate file_picker when ready
                        setState(() => _uploadedFileName = 'license_doc.pdf');
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 28),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0F4FF),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: const Color(0xFFB8C8E8),
                            style: BorderStyle.solid,
                            width: 1.5,
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: const BoxDecoration(
                                color: Color(0xFFDDE6FA),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.insert_drive_file_outlined,
                                color: Color(0xFF4A6FA5),
                                size: 26,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              _uploadedFileName ??
                                  'Click to upload or drag and drop',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color:
                                    _uploadedFileName != null
                                        ? const Color(0xFF007A55)
                                        : const Color(0xFF30343B),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'PDF, JPG, PNG (Max 5MB)',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),

            // ── Bottom buttons ────────────────────────────────────────────
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
                  // Back
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

                  // Next
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        onPressed: _handleNext,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF007A55),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: const Text(
                          'Next: Location',
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

  // ── Helpers ───────────────────────────────────────────────────────────────

  Widget _stepBar({required bool active}) => Expanded(
    child: Container(
      height: 6,
      decoration: BoxDecoration(
        color: active ? const Color(0xFF007A55) : const Color(0xFFDDE3F7),
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );

  Widget _label(String text) => Text(
    text,
    style: const TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w500,
      color: Color(0xFF30343B),
    ),
  );

  Widget _field({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(fontSize: 14, color: Color(0xFF30343B)),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(fontSize: 14, color: Colors.grey.shade400),
        prefixIcon: Icon(icon, size: 20, color: Colors.grey.shade500),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF007A55), width: 1.5),
        ),
      ),
    );
  }

  Widget _multilineField({
    required TextEditingController controller,
    required String hint,
  }) {
    return TextField(
      controller: controller,
      maxLines: 3,
      style: const TextStyle(fontSize: 14, color: Color(0xFF30343B)),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(fontSize: 14, color: Colors.grey.shade400),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(bottom: 40),
          child: Icon(
            Icons.location_on_outlined,
            size: 20,
            color: Colors.grey.shade500,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF007A55), width: 1.5),
        ),
      ),
    );
  }
}
