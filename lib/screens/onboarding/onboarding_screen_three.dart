import 'package:flutter/material.dart';
import 'package:social_app/screens/auth/login.dart';
import 'package:social_app/screens/onboarding/onboarding_screen.dart';

class OnboardingScreenThree extends StatefulWidget {
  const OnboardingScreenThree({super.key});

  @override
  State<OnboardingScreenThree> createState() => _OnboardingScreenThreeState();
}

class _OnboardingScreenThreeState extends State<OnboardingScreenThree> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Skip button at top
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>Login(),));
                  },
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Body content in the middle
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Make Friends and Enjoy',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'This is an amazing social app where you can connect with friends and share your moments.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.black38),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Next button at bottom
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: SizedBox(
                  // width: double.infinity,
                  child: ElevatedButton(
                     style: ButtonStyle(backgroundColor:WidgetStatePropertyAll(Colors.pink[400])),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OnboardingScreen(),
                        ),
                      );
                    },
                    child: const Text('Previous',style: TextStyle(color: Colors.white),),
                  ),
                ),
              ),
              SizedBox(width: 70),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: SizedBox(
                  // width: double.infinity,
                  child: ElevatedButton(
                     style: ButtonStyle(backgroundColor:WidgetStatePropertyAll(Colors.pink[400])),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Login(),
                        ),
                      );
                    },
                    child: const Text('Next',style: TextStyle(color: Colors.white),),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
