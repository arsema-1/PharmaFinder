import 'package:flutter/material.dart';
import 'login_screen.dart';
import '../../viewmodels/auth_vm.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isCustomer = true;
  bool obscurePassword = true;
  bool isLoading = false;

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final authVm = AuthViewModel();

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignup() async {
    final name = fullNameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text;

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      _showError('Please fill in all required fields.');
      return;
    }

    if (password.length < 8) {
      _showError('Password must be at least 8 characters.');
      return;
    }

    setState(() => isLoading = true);

    // Create account without auto-login
    try {
      final success = await authVm.createAccount(
        name: name,
        email: email,
        password: password,
      );

      if (!mounted) return;
      setState(() => isLoading = false);

      if (success) {
        // Show success message and navigate to login
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Account created successfully! Please login.'),
            backgroundColor: Colors.green.shade700,
            behavior: SnackBarBehavior.floating,
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      } else {
        _showError(authVm.errorMessage ?? 'Signup failed.');
      }
    } catch (e) {
      setState(() => isLoading = false);
      _showError('An unexpected error occurred.');
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red.shade700,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8FF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            children: [
              const SizedBox(height: 45),

              // Logo
              Image.asset(
                'assets/images/pharmafinder.png',
                width: 32,
                height: 32,
              ),

              const SizedBox(height: 20),

              // Title
              const Text(
                'Create Account',
                style: TextStyle(
                  color: Color(0xFF172033),
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                'Join the marketplace for medicines in Addis\nAbaba',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF4F5758),
                  fontSize: 10,
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 18),

              // Main card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(16, 18, 16, 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(9),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Customer / Pharmacist selector
                    Container(
                      height: 47,
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0F2FF),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: _roleButton(
                              title: 'I am a\nCustomer',
                              selected: isCustomer,
                              onTap: () {
                                setState(() {
                                  isCustomer = true;
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: _roleButton(
                              title: 'I am a\nPharmacist',
                              selected: !isCustomer,
                              onTap: () {
                                setState(() {
                                  isCustomer = false;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Full Name
                    _fieldLabel('Full Name'),

                    const SizedBox(height: 4),

                    _textField(
                      controller: fullNameController,
                      hint: 'Abebe Bikila',
                      icon: Icons.person_outline,
                    ),

                    const SizedBox(height: 10),

                    // Email
                    _fieldLabel('Email Address'),

                    const SizedBox(height: 4),

                    _textField(
                      controller: emailController,
                      hint: 'abebe@example.com',
                      icon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                    ),

                    const SizedBox(height: 10),

                    // Phone
                    _fieldLabel('Phone Number'),

                    const SizedBox(height: 4),

                    _textField(
                      controller: phoneController,
                      hint: '+251 911 234 567',
                      icon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                    ),

                    const SizedBox(height: 10),

                    // Password
                    _fieldLabel('Password'),

                    const SizedBox(height: 4),

                    TextField(
                      controller: passwordController,
                      obscureText: obscurePassword,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Color(0xFF4F5758),
                      ),
                      decoration: InputDecoration(
                        hintText: '••••••••',
                        hintStyle: const TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                        ),
                        prefixIcon: const Icon(Icons.lock_outline, size: 16),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obscurePassword = !obscurePassword;
                            });
                          },
                          icon: Icon(
                            obscurePassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            size: 16,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 10,
                        ),
                        border: _border(),
                        enabledBorder: _border(),
                        focusedBorder: _border(),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Create Account button
                    SizedBox(
                      width: double.infinity,
                      height: 32,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : _handleSignup,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF007A55),
                          foregroundColor: Colors.white,
                          disabledBackgroundColor: const Color(
                            0xFF007A55,
                          ).withValues(alpha: 0.6),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child:
                            isLoading
                                ? const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                                : const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Create Account',
                                      style: TextStyle(fontSize: 9),
                                    ),
                                    SizedBox(width: 4),
                                    Icon(Icons.arrow_forward, size: 13),
                                  ],
                                ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Login
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account? ',
                    style: TextStyle(fontSize: 9, color: Color(0xFF4F5758)),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 9,
                        color: Color(0xFF007A55),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _roleButton({
    required String title,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
          boxShadow:
              selected
                  ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 3,
                    ),
                  ]
                  : null,
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 9,
            height: 1.3,
            color: selected ? const Color(0xFF007A55) : const Color(0xFF4F5758),
            fontWeight: selected ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _fieldLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 8,
        color: Color(0xFF172033),
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _textField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(fontSize: 10, color: Color(0xFF4F5758)),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 10, color: Colors.grey),
        prefixIcon: Icon(icon, size: 16, color: const Color(0xFF4F5758)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        border: _border(),
        enabledBorder: _border(),
        focusedBorder: _border(),
      ),
    );
  }

  OutlineInputBorder _border() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(color: Color(0xFFC9D0D0)),
    );
  }
}
