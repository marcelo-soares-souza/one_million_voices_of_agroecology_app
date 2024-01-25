import 'package:flutter/material.dart';
import 'package:one_million_voices_of_agroecology_app/models/practice.dart';
import 'package:one_million_voices_of_agroecology_app/services/practice_service.dart';
import 'package:one_million_voices_of_agroecology_app/widgets/text_block_widget.dart';

class PracticeDetailsScreen extends StatefulWidget {
  final Practice practice;

  const PracticeDetailsScreen({super.key, required this.practice});

  @override
  State<PracticeDetailsScreen> createState() {
    return _LocationDetailsScreen();
  }
}

class _LocationDetailsScreen extends State<PracticeDetailsScreen> {
  bool isFavorite = false;
  int _selectedPageIndex = 0;
  late Practice _practice;

  void _retrieveFullPractice() async {
    _practice =
        await PracticeService.retrievePractice(widget.practice.id.toString());
  }

  @override
  void initState() {
    _retrieveFullPractice();
    super.initState();
  }

  void _setFavorite(Practice practice) {
    setState(() {
      isFavorite = true;
    });
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = SingleChildScrollView(
      child: Column(
        children: [
          Hero(
            tag: widget.practice.id,
            child: Image.network(
              widget.practice.imageUrl,
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          if (_selectedPageIndex == 0) ...[
            TextBlockWidget(
              label: 'Summary Description',
              value: widget.practice.summaryDescription,
            ),
            TextBlockWidget(
              label: 'Location',
              value: widget.practice.location,
            ),
            TextBlockWidget(
              label: 'Responsible for Information',
              value: widget.practice.responsibleForInformation,
            ),
          ] else if (_selectedPageIndex == 1) ...[
            TextBlockWidget(
              label: 'Where it is realized?',
              value: _practice.whereItIsRealized,
            ),
          ],
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.practice.name),
        actions: [
          IconButton(
            onPressed: () {
              _setFavorite(widget.practice);
            },
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: Icon(isFavorite ? Icons.star : Icons.star_border,
                  key: ValueKey(isFavorite)),
              transitionBuilder: (child, animation) => RotationTransition(
                turns: animation,
                child: child,
              ),
            ),
          )
        ],
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.work_outline),
            label: 'What you Do',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_objects_outlined),
            label: 'Characterise',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_available_outlined),
            label: 'Evaluate',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            label: 'Acknowledge',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo_library_outlined),
            label: 'Gallery',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.document_scanner_outlined),
            label: 'Documents',
          ),
        ],
      ),
    );
  }
}
