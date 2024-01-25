import 'package:flutter/material.dart';
import 'package:one_million_voices_of_agroecology_app/models/practice.dart';

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
          const SizedBox(height: 14),
          if (widget.practice.summaryDescription.isNotEmpty) ...[
            Text(
              'Summary Description',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 14),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                widget.practice.summaryDescription,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
            )
          ],
          const SizedBox(height: 14),
          Text(
            'Location',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 14),
          Text(
            widget.practice.location,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          const SizedBox(height: 14),
          Text(
            'Responsible for Information',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 14),
          Text(
            widget.practice.responsibleForInformation,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          const SizedBox(height: 14),
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
