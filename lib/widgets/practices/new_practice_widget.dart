import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:one_million_voices_of_agroecology_app/helpers/form_helper.dart';
import 'package:one_million_voices_of_agroecology_app/models/location.dart';
import 'package:one_million_voices_of_agroecology_app/models/practice.dart';
import 'package:one_million_voices_of_agroecology_app/screens/home.dart';
import 'package:one_million_voices_of_agroecology_app/screens/practices.dart';
import 'package:one_million_voices_of_agroecology_app/services/auth_service.dart';
import 'package:one_million_voices_of_agroecology_app/services/location_service.dart';
import 'package:one_million_voices_of_agroecology_app/services/practice_service.dart';
import 'package:one_million_voices_of_agroecology_app/widgets/image_input.dart';

class NewPractice extends StatefulWidget {
  const NewPractice({super.key});

  @override
  State<NewPractice> createState() => _NewPractice();
}

class _NewPractice extends State<NewPractice> {
  bool _isLoading = true;
  final Practice _practice = Practice.initPractice();
  List<Location> _locations = [];
  final _formKey = GlobalKey<FormState>();
  bool _isSending = false;
  bool _isLoggedIn = false;
  File? _selectedImage;

  void _checkIfIsLoggedIn() async {
    if (await AuthService.isLoggedIn()) {
      setState(() => _isLoggedIn = true);
    }
  }

  void _retrieveLocations() async {
    String accountId = await AuthService.getCurrentAccountId();
    List<Location> locations = await LocationService.retrieveAllLocationsByAccount(accountId);
    setState(() => _locations = locations);
  }

  @override
  void initState() {
    super.initState();
    _checkIfIsLoggedIn();
    _retrieveLocations();

    setState(() => _isLoading = false);
  }

  List<DropdownMenuItem<String>> get dropDownLocations {
    List<DropdownMenuItem<String>> locationItems = [];
    for (Location location in _locations) {
      locationItems.add(
        DropdownMenuItem(
          value: location.id.toString(),
          child: Text(location.name),
        ),
      );
    }

    return locationItems;
  }

  void _saveItem() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      setState(() => _isSending = true);

      _practice.accountId = await AuthService.getCurrentAccountId();
      _practice.locationId = _practice.locationId.isNotEmpty ? _practice.locationId : _locations[0].id.toString();

      String imageBase64 = '';

      if (_selectedImage != null) {
        imageBase64 = base64Encode(_selectedImage!.readAsBytesSync());
        _practice.base64Image = imageBase64;
      }

      final Map<String, String> response = await PracticeService.sendPractice(_practice);

      String status = response['status'].toString();
      String message = response['message'].toString();

      if (!mounted) return;

      if (status == 'success') {
        FormHelper.successMessage(context, message);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(
              activePage: PracticesScreen(),
              activePageTitle: 'Practices',
            ),
          ),
        );
      } else {
        FormHelper.errorMessage(context, 'An error occured: $message');
      }
      setState(() => _isSending = false);
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
                  const SizedBox(height: 10),
                  const Text('Location', style: TextStyle(color: Colors.grey, fontSize: 18)),
                  DropdownButtonFormField(
                    items: dropDownLocations,
                    value: _locations.isNotEmpty ? _locations[0].id.toString() : null,
                    onChanged: (value) {
                      setState(() {
                        _practice.locationId = value!;
                      });
                    },
                    decoration: const InputDecoration(
                      filled: false,
                      fillColor: Colors.blueAccent,
                    ),
                    dropdownColor: Theme.of(context).colorScheme.background,
                  ),
                  const SizedBox(height: 21),
                  const Text('Practice Name', style: TextStyle(color: Colors.grey, fontSize: 18)),
                  TextFormField(
                    maxLength: 64,
                    style: const TextStyle(color: Colors.white),
                    validator: (value) => FormHelper.validateInputSize(value, 1, 64),
                    onSaved: (value) => _practice.name = value!,
                  ),
                  const SizedBox(height: 21),
                  const Text('Photo', style: TextStyle(color: Colors.grey, fontSize: 18)),
                  const SizedBox(height: 21),
                  ImageInput(onPickImage: (image) => _selectedImage = image),
                  const SizedBox(height: 20),
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
                            : const Text('Add'),
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
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add a new Practice'),
        ),
        body: content);
  }
}
