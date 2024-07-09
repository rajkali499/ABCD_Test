import 'package:flutter/material.dart';

class AlertWidget extends StatelessWidget {
  const AlertWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      decoration: _buildDecoration(),
      child: const Icon(
        Icons.assistant,
        size: 30,
        color: Colors.white,
      ),
    );
  }

  BoxDecoration _buildDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(100),
      color: Colors.red,
    );
  }
}
