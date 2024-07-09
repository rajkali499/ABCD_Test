import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      decoration: _buildDecoration(),
      child: _buildTextField(),
    );
  }

  BoxDecoration _buildDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(100),
    );
  }

  TextField _buildTextField() {
    return TextField(
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        labelText: 'Search "Wedding Loan"',
        labelStyle: const TextStyle(color: Colors.grey, fontSize: 12),
        prefixIcon: const Icon(Icons.search_rounded, size: 22, color: Colors.grey),
        suffixIcon: const Icon(Icons.mic, size: 22, color: Colors.grey),
        fillColor: Colors.white,
        enabledBorder: _buildBorder(),
        border: _buildBorder(),
        errorBorder: _buildBorder(),
      ),
    );
  }

  OutlineInputBorder _buildBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.grey),
      borderRadius: BorderRadius.circular(100),
    );
  }
}
