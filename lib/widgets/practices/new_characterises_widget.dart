import 'package:flutter/material.dart';
import 'package:one_million_voices_of_agroecology_app/helpers/form_helper.dart';
import 'package:one_million_voices_of_agroecology_app/helpers/practice_helper.dart';
import 'package:one_million_voices_of_agroecology_app/models/practice.dart';
import 'package:one_million_voices_of_agroecology_app/models/practice/characterises.dart';
import 'package:one_million_voices_of_agroecology_app/screens/home.dart';
import 'package:one_million_voices_of_agroecology_app/screens/practices.dart';
import 'package:one_million_voices_of_agroecology_app/services/auth_service.dart';
import 'package:one_million_voices_of_agroecology_app/services/practice_service.dart';

class NewCharacterises extends StatefulWidget {
  final Practice practice;
  const NewCharacterises({super.key, required this.practice});

  @override
  State<NewCharacterises> createState() => _NewCharacterises();
}

class _NewCharacterises extends State<NewCharacterises> {
  bool _isLoading = true;
  Practice _practice = Practice.initPractice();
  final Characterises _characterises = Characterises.initCharacterises();
  final _formKey = GlobalKey<FormState>();
  bool _isSending = false;
  bool _isLoggedIn = false;
  final PracticeHelper _practiceHelper = PracticeHelper();

  void _checkIfIsLoggedIn() async {
    if (await AuthService.isLoggedIn()) {
      setState(() => _isLoggedIn = true);
    }
  }

  @override
  void initState() {
    super.initState();
    _checkIfIsLoggedIn();

    setState(() {
      _practice = widget.practice;

      _characterises.practiceId = _practice.id;
      _characterises.agroecologyPrinciplesAddressed = _practice.agroecologyPrinciplesAddressed;
      _characterises.foodSystemComponentsAddressed = _practice.foodSystemComponentsAddressed;

      _practice.agroecologyPrinciplesAddressed.split(',').forEach((element) {
        String key = element.trim();
        if (key.isNotEmpty) {
          _practiceHelper.agroecologyPrinciplesAddressedValues[key] = true;
        }
      });

      _practice.foodSystemComponentsAddressed.split(',').forEach((element) {
        String key = element.trim();
        if (key.isNotEmpty) {
          _practiceHelper.foodSystemComponentsAddressedValues[element.trim()] = true;
        }
      });

      _isLoading = false;
    });
  }

  void _saveItem() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      setState(() => _isSending = true);

      _characterises.agroecologyPrinciplesAddressed = _practiceHelper.agroecologyPrinciplesAddressedValues.entries
          .where((entry) => entry.value == true)
          .map((entry) => entry.key)
          .toList()
          .join(', ');

      _characterises.foodSystemComponentsAddressed = _practiceHelper.foodSystemComponentsAddressedValues.entries
          .where((entry) => entry.value == true)
          .map((entry) => entry.key)
          .toList()
          .join(', ');

      final Map<String, String> response = await PracticeService.updateCharacterises(_characterises);

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
                  const SizedBox(height: 21),
                  const Text('Agroecology principles invoked?', style: TextStyle(color: Colors.grey, fontSize: 18)),
                  for (final key in _practiceHelper.agroecologyPrinciplesAddressedValues.keys) ...[
                    CheckboxListTile(
                      title: Text(key),
                      value: _practiceHelper.agroecologyPrinciplesAddressedValues[key],
                      onChanged: (value) =>
                          setState(() => _practiceHelper.agroecologyPrinciplesAddressedValues[key] = value!),
                    )
                  ],
                  const SizedBox(height: 21),
                  const Text('Food system components addressed?', style: TextStyle(color: Colors.grey, fontSize: 18)),
                  for (final key in _practiceHelper.foodSystemComponentsAddressedValues.keys) ...[
                    CheckboxListTile(
                      title: Text(key),
                      value: _practiceHelper.foodSystemComponentsAddressedValues[key],
                      onChanged: (value) =>
                          setState(() => _practiceHelper.foodSystemComponentsAddressedValues[key] = value!),
                    )
                  ],
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
