import 'package:flutter/material.dart';
import 'package:one_million_voices_of_agroecology_app/models/location.dart';
import 'package:one_million_voices_of_agroecology_app/services/location_service.dart';

class NewLocation extends StatefulWidget {
  const NewLocation({super.key});

  @override
  State<NewLocation> createState() => _NewLocation();
}

class _NewLocation extends State<NewLocation> {
  final _formKey = GlobalKey<FormState>();
  var _enteredName = '';
  var _isSending = false;

  void _saveItem() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      setState(() {
        _isSending = true;
      });

      LocationService.sendLocation(Location(
          id: 0,
          name: _enteredName,
          country: '',
          farmAndFarmingSystem: '',
          farmAndFarmingSystemComplement: '',
          description: '',
          latitude: '',
          longitude: '',
          responsibleForInformation: '',
          url: '',
          imageUrl: '',
          createdAt: '',
          updatedAt: ''));

      if (!context.mounted) {
        return;
      }

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new Location'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                style: const TextStyle(color: Colors.white),
                maxLength: 100,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length <= 1 ||
                      value.trim().length > 100) {
                    return 'Must be between 1 and 100 characters long.';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  label: Text('Name'),
                ),
                onSaved: (value) {
                  _enteredName = value!;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _isSending
                        ? null
                        : () {
                            _formKey.currentState!.reset();
                          },
                    child: const Text('Reset'),
                  ),
                  ElevatedButton(
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
