import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: _buildDecoration(),
      child: const Center(
        child: _ProfileInitials(),
      ),
    );
  }

  BoxDecoration _buildDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(100),
      color: Colors.white,
    );
  }
}

class _ProfileInitials extends StatelessWidget {
  const _ProfileInitials();

  @override
  Widget build(BuildContext context) {
    return const Text(
      "SI",
      style: TextStyle(
        color: Colors.red,
        fontSize: 11,
        fontWeight: FontWeight.bold, // Added for better visibility
      ),
    );
  }
}
