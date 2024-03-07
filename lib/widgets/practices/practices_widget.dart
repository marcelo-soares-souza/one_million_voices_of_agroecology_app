import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:one_million_voices_of_agroecology_app/helpers/form_helper.dart';

import 'package:one_million_voices_of_agroecology_app/models/practice/practice.dart';
import 'package:one_million_voices_of_agroecology_app/screens/practice_details.dart';
import 'package:one_million_voices_of_agroecology_app/services/practice_service.dart';
import 'package:one_million_voices_of_agroecology_app/widgets/practices/practice_item_widget.dart';

class PracticesWidget extends StatefulWidget {
  final String filter;

  const PracticesWidget({super.key, this.filter = ''});

  @override
  State<PracticesWidget> createState() => _PracticesWidget();
}

class _PracticesWidget extends State<PracticesWidget> {
  bool _isLoading = true;
  List<Practice> _practices = [];

  void selectPractice(BuildContext context, Practice practice) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => PracticeDetailsScreen(
          onRemovePractice: (ctx) {
            _removePractice(practice);
          },
          practice: practice,
        ),
      ),
    );
  }

  Future<void> _loadPractices() async {
    _practices.clear();

    try {
      if (widget.filter.isNotEmpty) {
        _practices = await PracticeService.retrievePracticesByFilter(widget.filter);
      } else {
        _practices = await PracticeService.retrieveAllPractices();
      }

      setState(() => _isLoading = false);
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
    Widget content = Column(children: [
      const SizedBox(height: 200),
      Center(
          child: Text(
        textAlign: TextAlign.center,
        'No practices found',
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.secondary,
            ),
      ))
    ]);

    if (_isLoading) {
      content = const Center(child: CircularProgressIndicator());
    } else {
      if (_practices.isNotEmpty) {
        content = RefreshIndicator(
          onRefresh: () async {
            setState(() => _isLoading = true);
            await _loadPractices();
          },
          child: ListView.builder(
            itemCount: _practices.length,
            itemBuilder: (ctx, index) => Slidable(
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
          ),
        );
      }
    }

    return content;
  }
}
