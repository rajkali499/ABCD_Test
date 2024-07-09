import 'package:flutter/material.dart';

class AppLogoWidget extends StatelessWidget {
  const AppLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 26,
      height: 26,
      decoration: _buildDecoration(),
      child: const Center(
        child: _LogoText(),
      ),
    );
  }

  BoxDecoration _buildDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(6),
      color: Colors.white,
    );
  }
}

class _LogoText extends StatelessWidget {
  const _LogoText();

  @override
  Widget build(BuildContext context) {
    return const Text(
      "ab\ncd",
      style: TextStyle(
        color: Colors.red,
        fontSize: 11,
        height: 1.2,  // Improved readability by increasing the line height
        fontWeight: FontWeight.bold, // Added bold weight for better visibility
      ),
      textAlign: TextAlign.center, // Centered text alignment
    );
  }
}
