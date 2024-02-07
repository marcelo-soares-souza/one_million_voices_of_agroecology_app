import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:one_million_voices_of_agroecology_app/models/practice.dart';
import 'package:one_million_voices_of_agroecology_app/services/auth_service.dart';
import 'package:one_million_voices_of_agroecology_app/services/practice_service.dart';

class NewWhatYouDos extends StatefulWidget {
  final String practiceId;
  const NewWhatYouDos({super.key, required this.practiceId});

  @override
  State<NewWhatYouDos> createState() => _NewWhatYouDos();
}

class _NewWhatYouDos extends State<NewWhatYouDos> {
  bool _isLoading = true;
  Practice _practice = Practice.initPractice();
  final _formKey = GlobalKey<FormState>();
  var _isSending = false;
  bool _isLoggedIn = false;
  File? _selectedImage;

  void _checkIfIsLoggedIn() async {
    if (await AuthService.isLoggedIn()) {
      setState(() => _isLoggedIn = true);
    }
  }

  void _retrieveFullPractice() async {
    _practice = await PracticeService.retrievePractice(widget.practiceId);
    debugPrint(_practice.summaryDescription);
  }

  @override
  void initState() {
    super.initState();
    _checkIfIsLoggedIn();
    _retrieveFullPractice();
    setState(() => _isLoading = false);
  }

  void _saveItem() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      setState(() => _isSending = true);

      String imageBase64 = '';

      if (_selectedImage != null) {
        imageBase64 = base64Encode(_selectedImage!.readAsBytesSync());
        _practice.base64Image = imageBase64;
      }

      _practice.accountId = await AuthService.getCurrentAccountId();

      final Map<String, String> response = await PracticeService.sendPractice(_practice);
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

        Navigator.of(context).pop();
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('An error occured: $message'),
          backgroundColor: Colors.green,
        ));

        setState(() {
          _isSending = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: CircularProgressIndicator());

    if (!_isLoading) {
      content = Center(
        child: Text(
          'You need to login to add a new record',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Theme.of(context).colorScheme.secondary),
        ),
      );

      if (_isLoggedIn) {
        content = SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 21),
                  const Text('Summary description', style: TextStyle(color: Colors.grey, fontSize: 18)),
                  TextFormField(
                    initialValue: _practice.summaryDescription.isNotEmpty ? _practice.summaryDescription : '',
                    maxLength: 64,
                    style: const TextStyle(color: Colors.white),
                    onSaved: (value) => _practice.summaryDescription = value!,
                  ),
                  //
                  // Buttons
                  //
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(128, 36),
                          textStyle: const TextStyle(fontSize: 21),
                        ),
                        onPressed: _isSending ? null : _saveItem,
                        child: _isSending
                            ? const SizedBox(
                                height: 21,
                                width: 16,
                                child: CircularProgressIndicator(),
                              )
                            : const Text('Save'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
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
