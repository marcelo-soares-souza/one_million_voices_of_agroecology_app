import 'package:flutter/material.dart';
import 'package:one_million_voices_of_agroecology_app/helpers/form_helper.dart';
import 'package:one_million_voices_of_agroecology_app/helpers/practice_helper.dart';
import 'package:one_million_voices_of_agroecology_app/models/practice.dart';
import 'package:one_million_voices_of_agroecology_app/models/practice/acknowledge.dart';
import 'package:one_million_voices_of_agroecology_app/screens/home.dart';
import 'package:one_million_voices_of_agroecology_app/screens/practices.dart';
import 'package:one_million_voices_of_agroecology_app/services/auth_service.dart';
import 'package:one_million_voices_of_agroecology_app/services/practice_service.dart';

class NewAcknowledge extends StatefulWidget {
  final Practice practice;
  const NewAcknowledge({super.key, required this.practice});

  @override
  State<NewAcknowledge> createState() => _NewAcknowledge();
}

class _NewAcknowledge extends State<NewAcknowledge> {
  bool _isLoading = true;
  Practice _practice = Practice.initPractice();
  final Acknowledge _acknowledge = Acknowledge.initAcknowledge();
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

      _acknowledge.practiceId = _practice.id;
      _acknowledge.knowledgeProducts = _practice.knowledgeProducts;
      _acknowledge.knowledgeSource = _practice.knowledgeSource;
      _acknowledge.knowledgeTiming = _practice.knowledgeTiming;
      _acknowledge.uptakeMotivation = _practice.uptakeMotivation;
      _acknowledge.knowledgeSourceDetails = _practice.knowledgeSourceDetails;
      _acknowledge.knowledgeTimingDetails = _practice.knowledgeTimingDetails;

      _practice.knowledgeSource.split(',').forEach((element) {
        String key = element.trim();
        if (key.isNotEmpty) {
          _practiceHelper.knowledgeSourceValues[key] = true;
        }
      });

      _isLoading = false;
    });
  }

  void _saveItem() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      setState(() => _isSending = true);

      _acknowledge.knowledgeSource = _practiceHelper.knowledgeSourceValues.entries
          .where((entry) => entry.value == true)
          .map((entry) => entry.key)
          .toList()
          .join(', ');

      final Map<String, String> response = await PracticeService.updateAcknowledge(_acknowledge);

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
                  // Knowledge source
                  const SizedBox(height: 21),
                  const Text('Knowledge source', style: TextStyle(color: Colors.grey, fontSize: 18)),
                  for (final key in _practiceHelper.knowledgeSourceValues.keys) ...[
                    CheckboxListTile(
                      title: Text(key),
                      value: _practiceHelper.knowledgeSourceValues[key],
                      onChanged: (value) => setState(() => _practiceHelper.knowledgeSourceValues[key] = value!),
                    )
                  ],
                  const SizedBox(height: 30),
                  const Text('Details', style: TextStyle(color: Colors.grey, fontSize: 18)),
                  TextFormField(
                    initialValue:
                        widget.practice.knowledgeSourceDetails.isNotEmpty ? widget.practice.knowledgeSourceDetails : '',
                    maxLength: 4096,
                    style: const TextStyle(color: Colors.white),
                    onSaved: (value) => _acknowledge.knowledgeSourceDetails = value!,
                  ),
                  //
                  // Knowledge timing
                  const SizedBox(height: 21),
                  const Text('Knowledge timing', style: TextStyle(color: Colors.grey, fontSize: 18)),
                  DropdownButtonFormField(
                    items: PracticeHelper.dropDownKnowledgeTimingOptions,
                    value: widget.practice.knowledgeTiming.isNotEmpty ? widget.practice.knowledgeTiming : '',
                    onChanged: (value) => _acknowledge.knowledgeTiming = value!,
                    decoration: const InputDecoration(
                      filled: false,
                      fillColor: Colors.blueAccent,
                    ),
                    dropdownColor: Theme.of(context).colorScheme.background,
                  ),
                  const SizedBox(height: 30),
                  const Text('Details', style: TextStyle(color: Colors.grey, fontSize: 18)),
                  TextFormField(
                    initialValue:
                        widget.practice.knowledgeTimingDetails.isNotEmpty ? widget.practice.knowledgeTimingDetails : '',
                    maxLength: 4096,
                    style: const TextStyle(color: Colors.white),
                    onSaved: (value) => _acknowledge.knowledgeTimingDetails = value!,
                  ),
                  //
                  // Uptake motivation
                  const SizedBox(height: 30),
                  const Text('Uptake motivation', style: TextStyle(color: Colors.grey, fontSize: 18)),
                  TextFormField(
                    initialValue: widget.practice.uptakeMotivation.isNotEmpty ? widget.practice.uptakeMotivation : '',
                    maxLength: 4096,
                    style: const TextStyle(color: Colors.white),
                    onSaved: (value) => _acknowledge.uptakeMotivation = value!,
                  ),
                  //
                  // Knowledge products
                  const SizedBox(height: 30),
                  const Text('Knowledge products', style: TextStyle(color: Colors.grey, fontSize: 18)),
                  TextFormField(
                    initialValue: widget.practice.knowledgeProducts.isNotEmpty ? widget.practice.knowledgeProducts : '',
                    maxLength: 4096,
                    style: const TextStyle(color: Colors.white),
                    onSaved: (value) => _acknowledge.knowledgeProducts = value!,
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
