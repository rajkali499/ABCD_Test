import 'package:flutter/material.dart';
import 'package:newapp/helper/utils.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen(this.name, {super.key, required this.isGridEnabled});

  final String name;
  final bool isGridEnabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),
        _buildContent(isGridEnabled),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Center(
        child: Text(
          name,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildContent(bool isGridEnabled) {
    return isGridEnabled ? _buildGridContent() : _buildListContent();
  }

  Widget _buildGridContent() {
    return Column(
      children: [
        _buildRow("Stock", "Mutual Funds"),
        const SizedBox(height: 8),
        _buildRow("Gold", "Deposits"),
        const SizedBox(height: 8),
        _buildRow("Stock", "Mutual Funds"),
      ],
    );
  }

  Widget _buildListContent() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        children: [
          _buildListItem("Stock"),
          _buildListItem("Mutual Funds"),
          _buildListItem("Gold"),
          _buildListItem("Deposits"),
          _buildListItem("Stock"),
          _buildListItem("Mutual Funds"),
        ],
      ),
    );
  }

  Widget _buildRow(String name1, String name2) {
    return Row(
      children: [
        Flexible(child: _ScreenItem(name1, descriptions[name1] ?? "", isGrid: true)),
        const SizedBox(width: 8),
        Flexible(child: _ScreenItem(name2, descriptions[name2] ?? "", isGrid: true)),
      ],
    );
  }

  Widget _buildListItem(String name) {
    return _ScreenItem(name, descriptions[name] ?? "", isGrid: false);
  }
}

class _ScreenItem extends StatelessWidget {
  const _ScreenItem(this.name, this.description, {required this.isGrid});
  final String name;
  final String description;
  final bool isGrid;

  @override
  Widget build(BuildContext context) {
    return isGrid ? _buildGridItem() : _buildListItem();
  }

  Widget _buildGridItem() {
    return Card(
      child: Container(
        height: 150,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.white38,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Flexible(child: Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
                const SizedBox(width: 10,),
                const Icon(Icons.info, color: Colors.red,),
              ],
            ),
            const SizedBox(height: 8),
            Text(description, style: TextStyle(fontSize: 14, color: Colors.grey[700])),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 300, // Adjust width as needed
      child: ListTile(
        leading: const Icon(Icons.info, color: Colors.red,), // Placeholder for leading icon
        title: Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: Text(description, style: TextStyle(fontSize: 14, color: Colors.grey[700])),
        trailing: const Icon(Icons.arrow_forward), // Placeholder for trailing icon
      ),
    );
  }
}
