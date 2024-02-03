import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:one_million_voices_of_agroecology_app/helpers/form_helper.dart';
import 'package:one_million_voices_of_agroecology_app/models/gallery_item.dart';
import 'package:one_million_voices_of_agroecology_app/services/auth_service.dart';
import 'package:one_million_voices_of_agroecology_app/services/location_service.dart';
import 'package:one_million_voices_of_agroecology_app/widgets/image_input.dart';

class NewMediaWidget extends StatefulWidget {
  final String locationId;
  final void Function(int page) onSetPage;
  const NewMediaWidget({super.key, required this.locationId, required this.onSetPage});

  @override
  State<NewMediaWidget> createState() => _NewMediaWidget();
}

class _NewMediaWidget extends State<NewMediaWidget> {
  bool _isLoading = true;
  var _isSending = false;
  bool _isLoggedIn = false;

  // bool _isLoggedIn = false;
  final _formKey = GlobalKey<FormState>();
  File? _selectedImage;
  late GalleryItem _galleryItem;

  void _checkIfIsLoggedIn() async {
    if (await AuthService.isLoggedIn()) {
      setState(() {
        _isLoggedIn = true;
      });
    }
  }

  @override
  void initState() {
    _checkIfIsLoggedIn();
    _galleryItem = GalleryItem.initGalleryItem();
    _isLoading = false;

    super.initState();
  }

  void _saveItem() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      _galleryItem.locationId = widget.locationId;

      setState(() => _isSending = true);

      String imageBase64 = '';

      if (_selectedImage != null) {
        imageBase64 = base64Encode(_selectedImage!.readAsBytesSync());
        _galleryItem.base64Image = imageBase64;
      }

      final Map<String, String> response = await LocationService.sendMediaToLocation(_galleryItem);

      String status = response['status'].toString();
      String message = response['message'].toString();

      if (status == 'success') {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(message),
          backgroundColor: Colors.green,
        ));

        if (!context.mounted) {
          return;
        }
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('An error occured: $message'),
          backgroundColor: Colors.green,
        ));
      }
      setState(() {
        widget.onSetPage(1);
        _isSending = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: CircularProgressIndicator());

    if (!_isLoading) {
      if (!_isLoggedIn) {
        content = Column(children: [
          const SizedBox(height: 200),
          Center(
              child: Text(
            textAlign: TextAlign.center,
            'You need to login to add a new photo',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
          ))
        ]);
      } else {
        content = SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  const Text('Photo', style: TextStyle(color: Colors.grey, fontSize: 16)),
                  const SizedBox(height: 16),
                  ImageInput(onPickImage: (image) => _selectedImage = image),
                  const SizedBox(height: 16),
                  const Text('Description', style: TextStyle(color: Colors.grey, fontSize: 16)),
                  TextFormField(
                    maxLength: 64,
                    style: const TextStyle(color: Colors.white),
                    onSaved: (value) => _galleryItem.description = value!,
                    validator: (value) => FormHelper.validateInputSize(value, 4, 64),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(128, 36),
                          textStyle: const TextStyle(fontSize: 20),
                        ),
                        onPressed: _isSending ? null : _saveItem,
                        child: _isSending
                            ? const SizedBox(
                                height: 16,
                                width: 16,
                                child: CircularProgressIndicator(),
                              )
                            : const Text('Add'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }
    }

    return content;
  }
}
