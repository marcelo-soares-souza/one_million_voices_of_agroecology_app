import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:one_million_voices_of_agroecology_app/models/gallery_item.dart';
import 'package:one_million_voices_of_agroecology_app/models/practice.dart';
import 'package:one_million_voices_of_agroecology_app/services/practice_service.dart';
import 'package:one_million_voices_of_agroecology_app/widgets/text_block_widget.dart';
import 'package:transparent_image/transparent_image.dart';

class PracticeDetailsScreen extends StatefulWidget {
  final Practice practice;

  const PracticeDetailsScreen({super.key, required this.practice});

  @override
  State<PracticeDetailsScreen> createState() {
    return _LocationDetailsScreen();
  }
}

class _LocationDetailsScreen extends State<PracticeDetailsScreen> {
  bool _isLoading = true;
  bool isFavorite = false;
  int _selectedPageIndex = 0;
  late Practice _practice;
  late List<GalleryItem> _gallery;

  void _retrieveFullPractice() async {
    _practice =
        await PracticeService.retrievePractice(widget.practice.id.toString());

    _gallery = await PracticeService.retrievePracticeGallery(
        widget.practice.id.toString());

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _retrieveFullPractice();
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
    Widget activePage = const Center(child: Text('No items'));

    if (_isLoading) {
      activePage = const Center(child: CircularProgressIndicator());
    } else {
      activePage = SingleChildScrollView(
        child: Column(
          children: [
            if (_selectedPageIndex != 5) ...[
              Hero(
                tag: widget.practice.id,
                child: Image.network(
                  widget.practice.imageUrl,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              )
            ],
            if (_selectedPageIndex == 0) ...[
              //
              // Main Block
              //
              for (final i in _practice.main.entries)
                TextBlockWidget(
                  label: i.key,
                  value: _practice.getFieldByName(i.value),
                ),
            ] else if (_selectedPageIndex == 1) ...[
              //
              // What You do Block
              //
              for (final i in _practice.whatYouDo.entries)
                TextBlockWidget(
                  label: i.key,
                  value: _practice.getFieldByName(i.value),
                ),
            ] else if (_selectedPageIndex == 2) ...[
              //
              // Characterise
              //
              for (final i in _practice.characterises.entries)
                TextBlockWidget(
                  label: i.key,
                  value: _practice.getFieldByName(i.value),
                ),
            ] else if (_selectedPageIndex == 3) ...[
              //
              // Evaluate
              //
              for (final i in _practice.evaluates.entries)
                TextBlockWidget(
                  label: i.key,
                  value: _practice.getFieldByName(i.value),
                ),
            ] else if (_selectedPageIndex == 4) ...[
              //
              // Acknowledge
              //
              for (final i in _practice.acknowledges.entries)
                TextBlockWidget(
                  label: i.key,
                  value: _practice.getFieldByName(i.value),
                ),
            ] else if (_selectedPageIndex == 5) ...[
              //
              // Gallery
              //
              if (_gallery.isEmpty)
                Center(
                  child: Text(
                    'No items',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                  ),
                )
              else
                for (final i in _gallery) ...[
                  Stack(
                    children: [
                      Hero(
                        tag: i.description,
                        child: FadeInImage(
                          placeholder: MemoryImage(kTransparentImage),
                          image: NetworkImage(i.imageUrl),
                          fit: BoxFit.cover,
                          height: 300,
                          width: double.infinity,
                        ),
                      ),
                      if (i.description.length > 5)
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            color: Colors.black54,
                            padding: const EdgeInsets.symmetric(
                              vertical: 6,
                              horizontal: 44,
                            ),
                            child: Column(
                              children: [
                                Text(
                                  i.description,
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
            ],
          ],
        ),
      );
    }

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
