import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:one_million_voices_of_agroecology_app/configs/config.dart';
import 'package:one_million_voices_of_agroecology_app/helpers/form_helper.dart';
import 'package:one_million_voices_of_agroecology_app/helpers/location_helper.dart';
import 'package:one_million_voices_of_agroecology_app/models/location.dart';
import 'package:one_million_voices_of_agroecology_app/screens/home.dart';
import 'package:one_million_voices_of_agroecology_app/screens/locations.dart';
import 'package:one_million_voices_of_agroecology_app/services/auth_service.dart';
import 'package:one_million_voices_of_agroecology_app/services/location_service.dart';
import 'package:one_million_voices_of_agroecology_app/widgets/image_input.dart';

class NewLocation extends StatefulWidget {
  const NewLocation({super.key});

  @override
  State<NewLocation> createState() => _NewLocation();
}

class _NewLocation extends State<NewLocation> {
  bool _isLoading = true;

  final LocationHelper _locationHelper = LocationHelper();
  final Location _location = Location.initLocation();
  late Position? _currentPosition;
  final LatLng _initialCenter = const LatLng(16.0, 16.0);
  MapController mapController = MapController();
  final _formKey = GlobalKey<FormState>();
  bool _isSending = false;
  bool _isLoggedIn = false;
  File? _selectedImage;
  Marker _marker = LocationHelper.buildMarker('', const LatLng(16.0, 16.0));

  void _checkIfIsLoggedIn() async {
    if (await AuthService.isLoggedIn()) {
      setState(() => _isLoggedIn = true);
    }
  }

  @override
  void initState() {
    super.initState();
    _checkIfIsLoggedIn();
    _getCurrentPosition();
    setState(() => _isLoading = false);
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

      String imageBase64 = '';

      if (_selectedImage != null) {
        imageBase64 = base64Encode(_selectedImage!.readAsBytesSync());
        _location.base64Image = imageBase64;
      }

      final Map<String, String> response = await LocationService.sendLocation(_location);

      String status = response['status'].toString();
      String message = response['message'].toString();

      if (!mounted) return;

      if (status == 'success') {
        FormHelper.successMessage(context, message);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(
              activePage: LocationsScreen(),
              activePageTitle: 'Locations',
            ),
          ),
        );
      } else {
        FormHelper.errorMessage(context, 'An error occured: $message');
      }
      setState(() => _isSending = false);
    }
  }

  void _updateCoordinates() async {
    LatLng coordinates = await LocationService.getCoordinates(_location.countryCode);

    setState(() {
      _location.latitude = coordinates.latitude.toString();
      _location.longitude = coordinates.longitude.toString();
      _marker = LocationHelper.buildMarker(_location.id.toString(), coordinates);
    });
    mapController.move(coordinates, 5);
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
                  const Text('Location Name', style: TextStyle(color: Colors.grey, fontSize: 18)),
                  TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    keyboardType: TextInputType.text,
                    autocorrect: true,
                    maxLength: 64,
                    style: const TextStyle(color: Colors.white),
                    validator: (value) => FormHelper.validateInputSize(value, 1, 64),
                    onSaved: (value) => _location.name = value!,
                    decoration: InputDecoration(
                      hintText: 'How would you like to name the place where you practice agroecology?',
                      hintStyle: TextStyle(
                        color: Colors.grey.withOpacity(0.4),
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text('Country', style: TextStyle(color: Colors.grey, fontSize: 18)),
                  DropdownButtonFormField(
                    items: LocationHelper.dropDownCountries,
                    value: _location.countryCode,
                    onChanged: (value) {
                      setState(() {
                        _location.country = value!;
                        _location.countryCode = _location.country;
                      });
                      _updateCoordinates();
                    },
                    decoration: const InputDecoration(
                      filled: false,
                      fillColor: Colors.blueAccent,
                    ),
                    dropdownColor: Theme.of(context).colorScheme.background,
                  ),
                  const SizedBox(height: 24),
                  const Text('Is it a farm?', style: TextStyle(color: Colors.grey, fontSize: 18)),
                  DropdownButtonFormField(
                    items: FormHelper.dropDownYesNo,
                    value: 'Yes',
                    onChanged: (value) => _location.isItAFarm = value!,
                    decoration: const InputDecoration(
                      filled: false,
                      fillColor: Colors.blueAccent,
                    ),
                    dropdownColor: Theme.of(context).colorScheme.background,
                  ),
                  const SizedBox(height: 24),
                  const Text('What do you have on your farm?', style: TextStyle(color: Colors.grey, fontSize: 18)),
                  for (final key in _locationHelper.farmAndFarmingSystemComplementValues.keys) ...[
                    CheckboxListTile(
                      title: Text(key),
                      value: _locationHelper.farmAndFarmingSystemComplementValues[key],
                      onChanged: (value) =>
                          setState(() => _locationHelper.farmAndFarmingSystemComplementValues[key] = value!),
                    )
                  ],
                  const SizedBox(height: 24),
                  const Text('What\'s the main purpose?', style: TextStyle(color: Colors.grey, fontSize: 18)),
                  DropdownButtonFormField(
                    items: LocationHelper.dropDownFarmAndFarmingSystemOptions,
                    value: 'Mainly Home Consumption',
                    onChanged: (value) => _location.farmAndFarmingSystem = value!,
                    decoration: const InputDecoration(
                      filled: false,
                      fillColor: Colors.blueAccent,
                    ),
                    dropdownColor: Theme.of(context).colorScheme.background,
                  ),
                  const SizedBox(height: 24),
                  const Text('What is your dream?', style: TextStyle(color: Colors.grey, fontSize: 18)),
                  TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    keyboardType: TextInputType.text,
                    maxLength: 512,
                    maxLines: null,
                    style: const TextStyle(color: Colors.white),
                    onSaved: (value) => _location.whatIsYourDream = value!,
                    decoration: InputDecoration(
                      hintText: 'Do you have a dream of transforming your farm and/or location?',
                      hintStyle: TextStyle(
                        color: Colors.grey.withOpacity(0.4),
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 21),
                  const Text('Photo', style: TextStyle(color: Colors.grey, fontSize: 18)),
                  const SizedBox(height: 21),
                  ImageInput(onPickImage: (image) => _selectedImage = image),
                  const SizedBox(height: 20),
                  const Text('Description', style: TextStyle(color: Colors.grey, fontSize: 18)),
                  TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    keyboardType: TextInputType.text,
                    maxLength: 512,
                    maxLines: null,
                    style: const TextStyle(color: Colors.white),
                    onSaved: (value) => _location.description = value!,
                    decoration: InputDecoration(
                      hintText: 'Tell us a bit about your place, what you do in the place you register',
                      hintStyle: TextStyle(
                        color: Colors.grey.withOpacity(0.4),
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 21),
                  const Text('Location', style: TextStyle(color: Colors.grey, fontSize: 18)),
                  const SizedBox(height: 21),
                  SizedBox(
                    width: double.infinity,
                    height: 300,
                    child: FlutterMap(
                      mapController: mapController,
                      options: MapOptions(
                        initialCenter: _initialCenter,
                        minZoom: 1.0,
                        maxZoom: 16.0,
                        initialZoom: 2.0,
                        interactionOptions: Config.interactionOptions,
                        onTap: (position, latlon) {
                          setState(() {
                            _location.latitude = latlon.latitude.toString();
                            _location.longitude = latlon.longitude.toString();
                            _marker = LocationHelper.buildMarker(_location.id.toString(), latlon);
                          });
                        },
                      ),
                      children: [
                        TileLayer(urlTemplate: Config.osmURL),
                        MarkerLayer(markers: [_marker])
                      ],
                    ),
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
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add a new Location'),
        ),
        body: content);
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (!mounted) return false;
      FormHelper.infoMessage(context, 'Location services are disabled. Please enable the services');
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (!mounted) return false;
        FormHelper.errorMessage(context, 'Location permissions are denied');
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      if (!mounted) return false;
      FormHelper.errorMessage(context, 'Location permissions are permanently denied, we cannot request permissions.');
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

    setState(() {
      LatLng coordinates = LatLng(double.parse(_location.latitude), double.parse(_location.longitude));
      _marker = LocationHelper.buildMarker(_location.id.toString(), coordinates);
      mapController.move(coordinates, 3);
    });
  }
}
