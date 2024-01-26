import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
            //
            // What You do Block
            //
          ] else if (_selectedPageIndex == 1) ...[
            TextBlockWidget(
              label: 'Where it is realized?',
              value: _practice.whereItIsRealized,
            ),
            TextBlockWidget(
              label: 'Practical implementation of the practice',
              value: _practice.practicalImplementationOfThePractice,
            ),
            TextBlockWidget(
              label: 'Type of agroecological practice',
              value: _practice.typeOfAgroecologicalPractice,
            ),
            TextBlockWidget(
              label: 'Why you use and what you expect from this practice',
              value: _practice.whyYouUseAndWhatYouExpectFromThisPractice,
            ),
            TextBlockWidget(
              label: 'Land Size',
              value: _practice.landSize,
            ),
            TextBlockWidget(
              label: 'Substitution of less ecological alternative',
              value: _practice.substitutionOfLessEcologicalAlternative,
            ),
            //
            // Characterise
            //
          ] else if (_selectedPageIndex == 2) ...[
            TextBlockWidget(
              label: 'Agroecology principles addressed',
              value: _practice.agroecologyPrinciplesAddressed,
            ),
            TextBlockWidget(
              label: 'Food system components addressed',
              value: _practice.foodSystemComponentsAddressed,
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
            icon: Icon(FontAwesomeIcons.seedling),
            label: 'Summary',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.bookOpen),
            label: 'What you Do',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.info),
            label: 'Characterise',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.bookBookmark),
            label: 'Evaluate',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.userCheck),
            label: 'Acknowledge',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.photoFilm),
            label: 'Gallery',
          ),
        ],
      ),
    );
  }
}
