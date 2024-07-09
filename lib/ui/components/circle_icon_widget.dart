import 'package:flutter/material.dart';

class CircleIconWidget extends StatelessWidget {
  final double? size;
  const CircleIconWidget({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size?? 30,
      height: size?? 30,
      decoration: _buildDecoration(),
    );
  }

  BoxDecoration _buildDecoration() {
    return BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(100),
      color: Colors.white,
    );
  }
}
