import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState
    extends State<ForgotPasswordScreen> {
  bool useEmail = true;

  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
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
              constraints: const BoxConstraints(
                maxWidth: 500,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 55),

                  // Back button
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 23,
                        color: Color(0xFF172033),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  // Logo
                  Image.asset(
                    'assets/images/pharmafinder.png',
                    width: 55,
                    height: 55,
                  ),

                  const SizedBox(height: 15),

                  // Title
                  const Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Color(0xFF172033),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Enter your email or phone number and we\'ll\n'
                        'send you a verification code.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF596060),
                      fontSize: 12,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 28),

                  // Main card
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
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        // Email / Phone switch
                        Container(
                          height: 46,
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF0F2FF),
                            borderRadius:
                            BorderRadius.circular(7),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: _methodButton(
                                  title: 'Email',
                                  icon: Icons.email_outlined,
                                  selected: useEmail,
                                  onTap: () {
                                    setState(() {
                                      useEmail = true;
                                    });
                                  },
                                ),
                              ),
                              Expanded(
                                child: _methodButton(
                                  title: 'Phone',
                                  icon: Icons.phone_outlined,
                                  selected: !useEmail,
                                  onTap: () {
                                    setState(() {
                                      useEmail = false;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 22),

                        // Label
                        Text(
                          useEmail
                              ? 'Email Address'
                              : 'Phone Number',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF333333),
                          ),
                        ),

                        const SizedBox(height: 7),

                        // Input
                        if (useEmail)
                          TextField(
                            controller: emailController,
                            keyboardType:
                            TextInputType.emailAddress,
                            style: const TextStyle(
                              fontSize: 13,
                            ),
                            decoration: _inputDecoration(
                              hint: 'you@example.com',
                              icon: Icons.email_outlined,
                            ),
                          )
                        else
                          TextField(
                            controller: phoneController,
                            keyboardType:
                            TextInputType.phone,
                            style: const TextStyle(
                              fontSize: 13,
                            ),
                            decoration: _inputDecoration(
                              hint: '+251 911 234 567',
                              icon: Icons.phone_outlined,
                            ),
                          ),

                        const SizedBox(height: 23),

                        // Send code button
                        SizedBox(
                          width: double.infinity,
                          height: 46,
                          child: ElevatedButton(
                            onPressed: () {
                              // Send verification code
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                              const Color(0xFF007A55),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(6),
                              ),
                            ),
                            child: const Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Send Verification Code',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight:
                                    FontWeight.w500,
                                  ),
                                ),
                                SizedBox(width: 7),
                                Icon(
                                  Icons.arrow_forward,
                                  size: 18,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Return to login
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Remember your password? ',
                        style: TextStyle(
                          fontSize: 11,
                          color: Color(0xFF596060),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
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

  Widget _methodButton({
    required String title,
    required IconData icon,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          color: selected
              ? Colors.white
              : Colors.transparent,
          borderRadius: BorderRadius.circular(5),
          boxShadow: selected
              ? [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
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
              size: 17,
              color: selected
                  ? const Color(0xFF007A55)
                  : const Color(0xFF596060),
            ),
            const SizedBox(width: 6),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: selected
                    ? const Color(0xFF007A55)
                    : const Color(0xFF596060),
                fontWeight: selected
                    ? FontWeight.w500
                    : FontWeight.normal,
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
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        fontSize: 12,
        color: Colors.grey,
      ),

      prefixIcon: Icon(
        icon,
        size: 20,
        color: const Color(0xFF596060),
      ),

      contentPadding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 13,
      ),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: const BorderSide(
          color: Color(0xFFD0D5D5),
        ),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: const BorderSide(
          color: Color(0xFFD0D5D5),
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: const BorderSide(
          color: Color(0xFF007A55),
          width: 1.3,
        ),
      ),
    );
  }
}