import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('絞り込み/表示変更'),
      ),
      body: const Column(
        children: [
          Text('絞り込み'),
          Text('色'),
          Text('タグ'),
          Text('優先度'),
          Text('表示変更'),
        ],
      ),
    );
  }
}
