import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:one_million_voices_of_agroecology_app/helpers/form_helper.dart';

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
  List<Practice> _practices = [];

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
    super.initState();
    _loadPractices();
  }

  void _removePractice(Practice practice) async {
    Map<String, String> response = await PracticeService.removePractice(practice.id);
    if (response['status'] == 'success') setState(() => _practices.remove(practice));

    if (!mounted) return;
    FormHelper.successMessage(context, 'Practice Removed');
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No practices'));

    if (_isLoading) {
      content = const Center(child: CircularProgressIndicator());
    } else {
      content = ListView.builder(
        itemCount: _practices.length,
        itemBuilder: (ctx, index) => Slidable(
          startActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              if (_practices[index].hasPermission) ...[
                SlidableAction(
                  onPressed: (onPressed) => selectPractice(context, _practices[index]),
                  label: 'Edit',
                  icon: FontAwesomeIcons.penToSquare,
                  backgroundColor: const Color(0xFF4A90E2),
                  foregroundColor: Colors.white,
                ),
              ]
            ],
          ),
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              if (_practices[index].hasPermission) ...[
                SlidableAction(
                  onPressed: (onPressed) => _removePractice(_practices[index]),
                  label: 'Delete',
                  icon: FontAwesomeIcons.trash,
                  backgroundColor: const Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                )
              ]
            ],
          ),
          key: ValueKey(_practices[index].id),
          child: PracticeItemWidget(
            key: ObjectKey(_practices[index].id),
            practice: _practices[index],
            onSelectPractice: selectPractice,
          ),
        ),
      );
    }

    return content;
  }
}
