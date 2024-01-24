import 'package:flutter/material.dart';

import 'package:one_million_voices_of_agroecology_app/models/practice.dart';
import 'package:one_million_voices_of_agroecology_app/screens/practice_details.dart';
import 'package:one_million_voices_of_agroecology_app/services/practice_service.dart';
import 'package:one_million_voices_of_agroecology_app/widgets/practice_item_widget.dart';

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

  void selectPractice(BuildContext context, Practice practice) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => PracticeDetailsScreen(
          practice: practice,
        ),
      ),
    );
  }

  void _loadPractices() async {
    try {
      _practices = await PracticeService.retrieveAllPractices();

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
          onSelectPractice: selectPractice,
        ),
      );
    }

    return content;
  }
}
