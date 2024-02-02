import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:one_million_voices_of_agroecology_app/helpers/form_helper.dart';
import 'package:one_million_voices_of_agroecology_app/helpers/location_helper.dart';
import 'package:one_million_voices_of_agroecology_app/models/location.dart';
import 'package:one_million_voices_of_agroecology_app/services/location_service.dart';

class NewLocation extends StatefulWidget {
  const NewLocation({super.key});

  @override
  State<NewLocation> createState() => _NewLocation();
}

class _NewLocation extends State<NewLocation> {
  final LocationHelper _locationHelper = LocationHelper();
  late Location _location;
  late Position? _currentPosition;
  final _formKey = GlobalKey<FormState>();
  var _isSending = false;

  @override
  void initState() {
    _location = Location.initLocation();
    _getCurrentPosition();
    super.initState();
  }

  void _saveItem() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      setState(() => _isSending = true);

      _location.farmAndFarmingSystemComplement = _locationHelper.farmAndFarmingSystemComplementValues.entries
          .where((entry) => entry.value == true)
          .map((entry) => entry.key)
          .toList()
          .join(', ');

      await LocationService.sendLocation(_location);

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  maxLength: 64,
                  style: const TextStyle(color: Colors.white),
                  validator: (value) => FormHelper.validateInputSize(value, 1, 64),
                  decoration: const InputDecoration(
                    label: Text('Name'),
                  ),
                  onSaved: (value) => _location.name = value!,
                ),
                DropdownButtonFormField(
                  items: LocationHelper.dropDownCountries,
                  value: _location.country,
                  onChanged: (value) => _location.country = value!,
                  decoration: const InputDecoration(
                    label: Text('Country'),
                    filled: false,
                    fillColor: Colors.blueAccent,
                  ),
                  dropdownColor: Colors.black,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField(
                  items: FormHelper.dropDownYesNo,
                  value: 'true',
                  onChanged: (value) => _location.isItAFarm = value!,
                  decoration: const InputDecoration(
                    label: Text('Is it a farm?'),
                    filled: false,
                    fillColor: Colors.blueAccent,
                  ),
                  dropdownColor: Colors.black,
                ),
                const SizedBox(height: 16),
                const Text('What do you have on your farm?', style: TextStyle(color: Colors.grey, fontSize: 13)),
                for (final key in _locationHelper.farmAndFarmingSystemComplementValues.keys) ...[
                  CheckboxListTile(
                    title: Text(key),
                    value: _locationHelper.farmAndFarmingSystemComplementValues[key],
                    onChanged: (value) =>
                        setState(() => _locationHelper.farmAndFarmingSystemComplementValues[key] = value!),
                  )
                ],
                TextFormField(
                  maxLength: 512,
                  minLines: 2,
                  maxLines: null,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    label: Text('Description'),
                  ),
                  onSaved: (value) => _location.description = value!,
                ),
                //
                // Buttons
                //
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: _isSending ? null : () => _formKey.currentState!.reset(),
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
      ),
    );
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((Position position) {
      setState(() {
        _currentPosition = position;
        _location.latitude = _currentPosition?.latitude.toString() ?? '-15.75';
        _location.longitude = _currentPosition?.longitude.toString() ?? '-47.89';
      });
    });
  }
}
