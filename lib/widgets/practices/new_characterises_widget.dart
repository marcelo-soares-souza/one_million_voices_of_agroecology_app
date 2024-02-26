import 'package:flutter/material.dart';
import 'package:one_million_voices_of_agroecology_app/helpers/form_helper.dart';
import 'package:one_million_voices_of_agroecology_app/helpers/practice_helper.dart';
import 'package:one_million_voices_of_agroecology_app/models/practice.dart';
import 'package:one_million_voices_of_agroecology_app/models/practice/what_you_do.dart';
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
  final WhatYouDo _whatYouDo = WhatYouDo.initWhatYouDo();
  final _formKey = GlobalKey<FormState>();
  var _isSending = false;
  bool _isLoggedIn = false;

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
      _isLoading = false;
    });
  }

  void _saveItem() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      setState(() => _isSending = true);
      _whatYouDo.practiceId = _practice.id;

      final Map<String, String> response = await PracticeService.updateWhatYouDo(_whatYouDo);

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
                  const Text('Where it is realized?', style: TextStyle(color: Colors.grey, fontSize: 18)),
                  DropdownButtonFormField(
                    items: PracticeHelper.dropDownWhereItIsRealizedOptions,
                    value: widget.practice.whereItIsRealized.isNotEmpty ? widget.practice.whereItIsRealized : 'On-farm',
                    onChanged: (value) => _whatYouDo.whereItIsRealized = value!,
                    decoration: const InputDecoration(
                      filled: false,
                      fillColor: Colors.blueAccent,
                    ),
                    dropdownColor: Theme.of(context).colorScheme.background,
                  ),
                  const SizedBox(height: 21),
                  const Text('Summary description', style: TextStyle(color: Colors.grey, fontSize: 18)),
                  TextFormField(
                    initialValue:
                        widget.practice.summaryDescription.isNotEmpty ? widget.practice.summaryDescription : '',
                    maxLength: 4096,
                    style: const TextStyle(color: Colors.white),
                    onSaved: (value) => _whatYouDo.summaryDescriptionOfAgroecologicalPractice = value!,
                  ),
                  const SizedBox(height: 21),
                  const Text('Type of agroecological practice', style: TextStyle(color: Colors.grey, fontSize: 18)),
                  TextFormField(
                    initialValue: widget.practice.typeOfAgroecologicalPractice.isNotEmpty
                        ? widget.practice.typeOfAgroecologicalPractice
                        : '',
                    maxLength: 4096,
                    style: const TextStyle(color: Colors.white),
                    onSaved: (value) => _whatYouDo.typeOfAgroecologicalPractice = value!,
                  ),
                  const SizedBox(height: 21),
                  const Text('Implementing the practice', style: TextStyle(color: Colors.grey, fontSize: 18)),
                  TextFormField(
                    initialValue: widget.practice.practicalImplementationOfThePractice.isNotEmpty
                        ? widget.practice.practicalImplementationOfThePractice
                        : '',
                    maxLength: 4096,
                    style: const TextStyle(color: Colors.white),
                    onSaved: (value) => _whatYouDo.practicalImplementationOfThePractice = value!,
                    decoration: InputDecoration(
                      hintText: 'How do you do prepare and/or implement the practice?',
                      hintStyle: TextStyle(
                        color: Colors.grey.withOpacity(0.4),
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 21),
                  const Text('Substitution of less ecological alternative?',
                      style: TextStyle(color: Colors.grey, fontSize: 18)),
                  DropdownButtonFormField(
                    items: FormHelper.dropDownYesNo,
                    value: widget.practice.substitutionOfLessEcologicalAlternative.isNotEmpty
                        ? widget.practice.substitutionOfLessEcologicalAlternative
                        : 'Yes',
                    onChanged: (value) => _whatYouDo.substitutionOfLessEcologicalAlternative = value!,
                    decoration: const InputDecoration(
                      filled: false,
                      fillColor: Colors.blueAccent,
                    ),
                    dropdownColor: Theme.of(context).colorScheme.background,
                  ),
                  const SizedBox(height: 30),
                  const Text('Why you use and what you expect from this practice?',
                      style: TextStyle(color: Colors.grey, fontSize: 18)),
                  TextFormField(
                    initialValue: widget.practice.whyYouUseAndWhatYouExpectFromThisPractice.isNotEmpty
                        ? widget.practice.whyYouUseAndWhatYouExpectFromThisPractice
                        : '',
                    maxLength: 4096,
                    style: const TextStyle(color: Colors.white),
                    onSaved: (value) => _whatYouDo.whyYouUseAndWhatYouExpectFromThisPractice = value!,
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
