import 'package:flutter/material.dart';
import 'onboarding_screen2.dart';
import '../auth/login_screen.dart';
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFD8FFCC),
              Color(0xFF91A58B),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [

              // Skip
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 20,
                    top: 10,
                  ),
                  child: TextButton(
                    onPressed: () {

                      // Navigate to login
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                               LoginScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'SKIP',
                      style: TextStyle(
                        color: Color(0xFF65705F),
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),


              Expanded(
                flex: 5,
                child: Image.asset(
                  'assets/images/onboarding1.png',
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
              ),


              Expanded(
                flex: 2,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Text(
                      'DISCOVER NEARBY PHARMACIES WITH THE\nMEDICINE YOU NEED.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: size.width * 0.035,
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                      ),
                    ),
                  ),
                ),
              ),

              // Next button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 67),
                child: SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                          const OnboardingSecondScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFB9DDB0),
                      foregroundColor: Colors.white,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      'NEXT',
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: size.height * 0.10),
            ],
          ),
        ),
      ),
    );
  }
}