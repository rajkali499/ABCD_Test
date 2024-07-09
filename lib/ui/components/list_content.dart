import 'package:flutter/material.dart';
import 'package:newapp/ui/components/circle_icon_widget.dart';

class ListContent extends StatelessWidget {
  final String contentText;
  const ListContent({super.key, required this.contentText});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CircleIconWidget(size: 40,),
        const SizedBox(height: 10,),
        Text(contentText)
      ],
    );
  }
}
