
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingPage extends ConsumerWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageView(
      children: [
        Image.asset(
          'assets/icons/onboarding1.jpg',
          fit: BoxFit.cover,
        ),
        Image.asset(
          'assets/icons/onboarding2.jpg',
          fit: BoxFit.cover,
        ),
        Image.asset(
          'assets/icons/onboarding3.jpg',
          fit: BoxFit.cover,
        ),
        Image.asset(
          'assets/icons/onboarding4.jpg',
          fit: BoxFit.cover,
        )
      ],
    );
  }
}
