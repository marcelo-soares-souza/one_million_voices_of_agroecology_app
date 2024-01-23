import 'package:flutter/material.dart';
import 'package:one_million_voices_of_agroecology_app/configs/config.dart';
import 'package:one_million_voices_of_agroecology_app/widgets/practice_item_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/practice.dart';

class PracticesWidget extends StatefulWidget {
  const PracticesWidget({super.key});
  @override
  State<PracticesWidget> createState() {
    return _PracticesWidget();
  }
}

class _PracticesWidget extends State<PracticesWidget> {
  bool _isLoading = true;
  late final List<Practice> _practices;

  void _loadPractices() async {
    try {
      _practices = [];
      final res = await http.get(Uri.https(Config.omvUrl, 'practices.json'));
      for (final practice in json.decode(res.body.toString())) {
        _practices.add(Practice.fromJson(practice));
      }

      if (_practices.isNotEmpty) {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      throw Exception('[PracticesWidget] Error: $e');
    }

    return;
  }

  @override
  void initState() {
    _loadPractices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No practices'));

    if (_isLoading) {
      content = const Center(child: CircularProgressIndicator());
    } else {
      content = ListView.builder(
        itemCount: _practices.length,
        itemBuilder: (ctx, index) => PracticeItemWidget(
          key: ObjectKey(_practices[index].id),
          practice: _practices[index],
        ),
      );
    }

    return content;
  }
}
