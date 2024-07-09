import 'package:flutter/material.dart';
import 'package:newapp/helper/utils.dart';
import 'package:newapp/ui/components/app_logo_widget.dart';
import 'package:newapp/ui/components/list_content.dart';

class MyTrack extends StatelessWidget {
  const MyTrack({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: _buildDecoration(),
      child: _buildContent(), // Placeholder for potential content addition
    );
  }

  BoxDecoration _buildDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(14),
      color: Colors.white38,
    );
  }

  Widget _buildContent() {
    // This can be replaced or expanded with actual content
    return Column(
      children: [
       const Text(
          'My Track Content',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 10,),
        Flexible(child: buildContentList()),

      ],
    );
  }

 Widget buildContentList() {
    return ListView(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      children: listContents.map((element)=> Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListContent(contentText: element),
      )).toList(),
    );
 }
}
