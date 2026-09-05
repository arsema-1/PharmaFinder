import 'package:flutter/material.dart';
import 'signup_screen.dart';
import 'forgotpassword_screen.dart';
import '../../viewmodels/auth_vm.dart';
import '../user/user_shell.dart';
import '../pharmacist/pharmacy_register1.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isCustomer = true;
  bool obscurePassword = true;
  bool isLoading = false;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final authVm = AuthViewModel();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      _showError('Please enter both email and password.');
      return;
    }

    setState(() => isLoading = true);

    final success = await authVm.login(email: email, password: password);

    if (!mounted) return;
    setState(() => isLoading = false);

    if (success) {
      // TODO: replace pharmacist destination with PharmacistShell once built
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const UserShell()),
        (route) => false,
      );
    } else {
      _showError(authVm.errorMessage ?? 'Login failed.');
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
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Column(
                children: [
                  const SizedBox(height: 55),

                  // Logo
                  Image.asset(
                    'assets/images/pharmafinder.png',
                    width: 55,
                    height: 55,
                  ),

                  const SizedBox(height: 10),

                  // App name
                  const Text(
                    'PharmaFinder',
                    style: TextStyle(
                      color: Color(0xFF007A55),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  const Text(
                    'Welcome Back',
                    style: TextStyle(
                      color: Color(0xFF172033),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 7),

                  Text(
                    isCustomer
                        ? 'Sign in to find medicines near you.'
                        : 'Sign in to manage your pharmacy.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF596060),
                      fontSize: 12,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ============================================================
                  // ROLE TOGGLE
                  // ============================================================
                  Container(
                    height: 44,
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F2FF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: _roleButton(
                            icon: Icons.person_outline,
                            label: 'Customer',
                            selected: isCustomer,
                            onTap: () => setState(() => isCustomer = true),
                          ),
                        ),
                        Expanded(
                          child: _roleButton(
                            icon: Icons.local_pharmacy_outlined,
                            label: 'Pharmacist',
                            selected: !isCustomer,
                            onTap: () => setState(() => isCustomer = false),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ============================================================
                  // LOGIN CARD
                  // ============================================================
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Email
                        const Text(
                          'Email Address',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF333333),
                          ),
                        ),

                        const SizedBox(height: 7),

                        TextField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          style: const TextStyle(fontSize: 13),
                          decoration: _inputDecoration(
                            hint: 'you@example.com',
                            icon: Icons.email_outlined,
                          ),
                        ),

                        const SizedBox(height: 17),

                        // Password row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Password',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF333333),
                              ),
                            ),
                            GestureDetector(
                              onTap:
                                  () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (_) => const ForgotPasswordScreen(),
                                    ),
                                  ),
                              child: const Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Color(0xFF007A55),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 7),

                        TextField(
                          controller: passwordController,
                          obscureText: obscurePassword,
                          style: const TextStyle(fontSize: 13),
                          decoration: _inputDecoration(
                            hint: '••••••••',
                            icon: Icons.lock_outline,
                            suffixIcon: IconButton(
                              onPressed:
                                  () => setState(
                                    () => obscurePassword = !obscurePassword,
                                  ),
                              icon: Icon(
                                obscurePassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                size: 20,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 22),

                        // Login button
                        SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: ElevatedButton(
                            onPressed: isLoading ? null : _handleLogin,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF007A55),
                              foregroundColor: Colors.white,
                              disabledBackgroundColor: const Color(
                                0xFF007A55,
                              ).withValues(alpha: 0.6),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
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
                                    : Text(
                                      isCustomer
                                          ? 'Login as Customer'
                                          : 'Login as Pharmacist',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                          ),
                        ),

                        const SizedBox(height: 18),

                        // Divider
                        Row(
                          children: [
                            const Expanded(
                              child: Divider(color: Color(0xFFD8D8D8)),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Text(
                                'Or continue with',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ),
                            const Expanded(
                              child: Divider(color: Color(0xFFD8D8D8)),
                            ),
                          ],
                        ),

                        const SizedBox(height: 15),

                        if (isCustomer)
                          _secondaryButton(
                            icon: Icons.person_outline,
                            text: 'Continue as Guest',
                            onPressed: () {},
                          ),

                        if (isCustomer) const SizedBox(height: 10),

                        _secondaryButton(
                          icon: Icons.g_mobiledata,
                          text: 'Login with Google',
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 18),

                  // Sign up / Register pharmacy
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        isCustomer
                            ? "Don't have an account? "
                            : "New pharmacy? ",
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFF596060),
                        ),
                      ),
                      GestureDetector(
                        onTap:
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (_) =>
                                        isCustomer
                                            ? RegisterScreen(
                                              initialIsCustomer: isCustomer,
                                            )
                                            : const RegisterPharmacyScreen(),
                              ),
                            ),
                        child: Text(
                          isCustomer ? 'Sign Up' : 'Register Pharmacy',
                          style: const TextStyle(
                            fontSize: 11,
                            color: Color(0xFF007A55),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _roleButton({
    required IconData icon,
    required String label,
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
          borderRadius: BorderRadius.circular(6),
          boxShadow:
              selected
                  ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 4,
                    ),
                  ]
                  : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 15,
              color:
                  selected ? const Color(0xFF007A55) : const Color(0xFF596060),
            ),
            const SizedBox(width: 5),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
                color:
                    selected
                        ? const Color(0xFF007A55)
                        : const Color(0xFF596060),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(fontSize: 12, color: Colors.grey),
      prefixIcon: Icon(icon, size: 20, color: const Color(0xFF596060)),
      suffixIcon: suffixIcon,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: const BorderSide(color: Color(0xFFD0D5D5)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: const BorderSide(color: Color(0xFFD0D5D5)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: const BorderSide(color: Color(0xFF007A55), width: 1.3),
      ),
    );
  }

  Widget _secondaryButton({
    required IconData icon,
    required String text,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 42,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 19, color: const Color(0xFF333333)),
        label: Text(
          text,
          style: const TextStyle(fontSize: 11, color: Color(0xFF333333)),
        ),
        style: OutlinedButton.styleFrom(
          backgroundColor: const Color(0xFFF9FAFC),
          side: const BorderSide(color: Color(0xFFD8DDE3)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
      ),
    );
  }
}
