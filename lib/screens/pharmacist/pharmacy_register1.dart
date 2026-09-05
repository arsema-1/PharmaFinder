import 'package:flutter/material.dart';
import '../../viewmodels/auth_vm.dart';
import 'pharmacy_register2.dart';
import '../auth/login_screen.dart';

class RegisterPharmacyScreen extends StatefulWidget {
  const RegisterPharmacyScreen({super.key});

  @override
  State<RegisterPharmacyScreen> createState() => _RegisterPharmacyScreenState();
}

class _RegisterPharmacyScreenState extends State<RegisterPharmacyScreen> {
  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool showPassword = false;
  bool showConfirmPassword = false;
  bool isLoading = false;
  bool _submitted = false;

  final _authVm = AuthViewModel();

  @override
  void dispose() {
    fullNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleNext() async {
    if (_submitted) return; // prevent double-tap
    final name = fullNameController.text.trim();
    final phone = phoneController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text;
    final confirm = confirmPasswordController.text;

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      _showError('Please fill in all required fields.');
      return;
    }
    if (password.length < 8) {
      _showError('Password must be at least 8 characters.');
      return;
    }
    if (password != confirm) {
      _showError('Passwords do not match.');
      return;
    }

    setState(() {
      isLoading = true;
      _submitted = true;
    });

    final success = await _authVm.createAccountWithRole(
      name: name,
      email: email,
      password: password,
      role: 'pharmacist',
      phone: phone,
    );

    if (!mounted) return;
    setState(() {
      isLoading = false;
      _submitted = false;
    });

    if (success) {
      // Pass the authenticated userId + basic info to step 2
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (_) => RegisterPharmacyStep2(
                userId: _authVm.currentUser!.$id,
                ownerName: name,
                ownerPhone: phone,
              ),
        ),
      );
    } else {
      _showError(_authVm.errorMessage ?? 'Registration failed.');
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
          child: Container(height: 1, color: Colors.grey.shade300),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.15),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Green top bar
                Container(
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFF00805A),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 18, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Register Pharmacy',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF30343B),
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        'Step 1 of 3: Account Information',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),

                      const SizedBox(height: 18),

                      // Step indicator
                      Row(
                        children: [
                          _stepBar(active: true),
                          const SizedBox(width: 8),
                          _stepBar(active: false),
                          const SizedBox(width: 8),
                          _stepBar(active: false),
                        ],
                      ),

                      const SizedBox(height: 32),

                      // Fields
                      _label('Full Name'),
                      const SizedBox(height: 7),
                      _field(
                        controller: fullNameController,
                        hint: 'John Doe',
                        icon: Icons.person_outline,
                      ),

                      const SizedBox(height: 19),
                      _label('Phone Number'),
                      const SizedBox(height: 7),
                      _field(
                        controller: phoneController,
                        hint: '+251 911 234 567',
                        icon: Icons.phone_outlined,
                        keyboardType: TextInputType.phone,
                      ),

                      const SizedBox(height: 19),
                      _label('Email Address'),
                      const SizedBox(height: 7),
                      _field(
                        controller: emailController,
                        hint: 'pharmacy@example.com',
                        icon: Icons.mail_outline,
                        keyboardType: TextInputType.emailAddress,
                      ),

                      const SizedBox(height: 19),
                      _label('Password'),
                      const SizedBox(height: 7),
                      _field(
                        controller: passwordController,
                        hint: '••••••••',
                        icon: Icons.lock_outline,
                        obscureText: !showPassword,
                        suffixIcon: _visibilityToggle(
                          visible: showPassword,
                          onTap:
                              () =>
                                  setState(() => showPassword = !showPassword),
                        ),
                      ),

                      const SizedBox(height: 19),
                      _label('Confirm Password'),
                      const SizedBox(height: 7),
                      _field(
                        controller: confirmPasswordController,
                        hint: '••••••••',
                        icon: Icons.lock_reset_outlined,
                        obscureText: !showConfirmPassword,
                        suffixIcon: _visibilityToggle(
                          visible: showConfirmPassword,
                          onTap:
                              () => setState(
                                () =>
                                    showConfirmPassword = !showConfirmPassword,
                              ),
                        ),
                      ),

                      const SizedBox(height: 18),

                      // Next button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: isLoading ? null : _handleNext,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF007A55),
                            foregroundColor: Colors.white,
                            disabledBackgroundColor: const Color(
                              0xFF007A55,
                            ).withValues(alpha: 0.6),
                            elevation: 0,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                          child:
                              isLoading
                                  ? const SizedBox(
                                    width: 22,
                                    height: 22,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.5,
                                      color: Colors.white,
                                    ),
                                  )
                                  : const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Next: Pharmacy Details',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Icon(Icons.arrow_forward, size: 22),
                                    ],
                                  ),
                        ),
                      ),

                      const SizedBox(height: 26),

                      // Back to login
                      Center(
                        child: GestureDetector(
                          onTap:
                              () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const LoginScreen(),
                                ),
                              ),
                          child: RichText(
                            text: TextSpan(
                              text: 'Already have an account? ',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 14,
                              ),
                              children: const [
                                TextSpan(
                                  text: 'Back to Login',
                                  style: TextStyle(
                                    color: Color(0xFF007A55),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
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
        ),
      ),
    );
  }

  Widget _stepBar({required bool active}) {
    return Expanded(
      child: Container(
        height: 8,
        decoration: BoxDecoration(
          color: active ? const Color(0xFF00805A) : const Color(0xFFDDE3F7),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _label(String text) => Text(
    text,
    style: const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      color: Color(0xFF30343B),
    ),
  );

  Widget _visibilityToggle({
    required bool visible,
    required VoidCallback onTap,
  }) {
    return IconButton(
      icon: Icon(
        visible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
        color: Colors.grey.shade600,
      ),
      onPressed: onTap,
    );
  }

  Widget _field({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscureText = false,
    Widget? suffixIcon,
    TextInputType? keyboardType,
  }) {
    return SizedBox(
      height: 50,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: const TextStyle(fontSize: 15, color: Color(0xFF6F7782)),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xFF7D8490), fontSize: 15),
          prefixIcon: Icon(icon, color: const Color(0xFF7C8A83), size: 22),
          suffixIcon: suffixIcon,
          filled: true,
          fillColor: const Color(0xFFF8F8FC),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 14,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: Color(0xFF00805A), width: 1.5),
          ),
        ),
      ),
    );
  }
}
