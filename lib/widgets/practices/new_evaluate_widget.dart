import 'package:flutter/material.dart';
import 'package:one_million_voices_of_agroecology_app/helpers/form_helper.dart';
import 'package:one_million_voices_of_agroecology_app/helpers/practice_helper.dart';
import 'package:one_million_voices_of_agroecology_app/models/practice.dart';
import 'package:one_million_voices_of_agroecology_app/models/practice/evaluate.dart';
import 'package:one_million_voices_of_agroecology_app/screens/home.dart';
import 'package:one_million_voices_of_agroecology_app/screens/practices.dart';
import 'package:one_million_voices_of_agroecology_app/services/auth_service.dart';
import 'package:one_million_voices_of_agroecology_app/services/practice_service.dart';

class NewEvaluate extends StatefulWidget {
  final Practice practice;
  const NewEvaluate({super.key, required this.practice});

  @override
  State<NewEvaluate> createState() => _NewEvaluate();
}

class _NewEvaluate extends State<NewEvaluate> {
  bool _isLoading = true;
  Practice _practice = Practice.initPractice();
  final Evaluate _evaluate = Evaluate.initEvaluate();
  final _formKey = GlobalKey<FormState>();
  bool _isSending = false;
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

      _evaluate.practiceId = _practice.id;
      _evaluate.generalPerformanceOfPractice = _practice.generalPerformanceOfPractice;
      _evaluate.generalPerformanceOfPracticeDetails = _practice.generalPerformanceOfPracticeDetails;
      _evaluate.unintendedPositiveSideEffectsOfPractice = _practice.unintendedPositiveSideEffectsOfPractice;
      _evaluate.unintendedPositiveSideEffectsOfPracticeDetails =
          _practice.unintendedPositiveSideEffectsOfPracticeDetails;
      _evaluate.unintendedNegativeSideEffectOfPractice = _practice.unintendedNegativeSideEffectOfPractice;
      _evaluate.unintendedNegativeSideEffectOfPracticeDetails = _practice.unintendedNegativeSideEffectOfPracticeDetails;
      _evaluate.knowledgeAndSkillsRequiredForPractice = _practice.knowledgeAndSkillsRequiredForPractice;
      _evaluate.knowledgeAndSkillsRequiredForPracticeDetails = _practice.knowledgeAndSkillsRequiredForPracticeDetails;
      _evaluate.labourRequiredForPractice = _practice.labourRequiredForPractice;
      _evaluate.labourRequiredForPracticeDetails = _practice.labourRequiredForPracticeDetails;
      _evaluate.costAssociatedWithPractice = _practice.costAssociatedWithPractice;
      _evaluate.costAssociatedWithPracticeDetails = _practice.costAssociatedWithPracticeDetails;
      _evaluate.doesItWorkInDegradedEnvironments = _practice.doesItWorkInDegradedEnvironments;
      _evaluate.doesItWorkInDegradedEnvironmentsDetails = _practice.doesItWorkInDegradedEnvironmentsDetails;
      _evaluate.doesItHelpRestoreLand = _practice.doesItHelpRestoreLand;
      _evaluate.doesItHelpRestoreLandDetails = _practice.doesItHelpRestoreLandDetails;
      _evaluate.climateChangeVulnerabilityEffects = _practice.climateChangeVulnerabilityEffects;
      _evaluate.climateChangeVulnerabilityEffectsDetails = _practice.climateChangeVulnerabilityEffectsDetails;
      _evaluate.timeRequirements = _practice.timeRequirements;
      _evaluate.timeRequirements = _practice.timeRequirementsDetails;

      _isLoading = false;
    });
  }

  void _saveItem() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      setState(() => _isSending = true);

      final Map<String, String> response = await PracticeService.updateEvaluate(_evaluate);

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
                  // General Performance
                  const SizedBox(height: 21),
                  const Text('General performance', style: TextStyle(color: Colors.grey, fontSize: 18)),
                  DropdownButtonFormField(
                    items: PracticeHelper.dropDownEffectiveOptions,
                    value: widget.practice.generalPerformanceOfPractice.isNotEmpty
                        ? widget.practice.generalPerformanceOfPractice
                        : '',
                    onChanged: (value) => _evaluate.generalPerformanceOfPractice = value!,
                    decoration: const InputDecoration(
                      filled: false,
                      fillColor: Colors.blueAccent,
                    ),
                    dropdownColor: Theme.of(context).colorScheme.background,
                  ),
                  const SizedBox(height: 30),
                  const Text('Details', style: TextStyle(color: Colors.grey, fontSize: 18)),
                  TextFormField(
                    initialValue: widget.practice.generalPerformanceOfPracticeDetails.isNotEmpty
                        ? widget.practice.generalPerformanceOfPracticeDetails
                        : '',
                    maxLength: 4096,
                    style: const TextStyle(color: Colors.white),
                    onSaved: (value) => _evaluate.generalPerformanceOfPracticeDetails = value!,
                  ),
                  //
                  // Unintended positive side effects of practice
                  const SizedBox(height: 21),
                  const Text('Unintended positive side effects of practice',
                      style: TextStyle(color: Colors.grey, fontSize: 18)),
                  DropdownButtonFormField(
                    items: FormHelper.dropDownYesNo,
                    value: widget.practice.unintendedPositiveSideEffectsOfPractice.isNotEmpty
                        ? widget.practice.unintendedPositiveSideEffectsOfPractice
                        : '',
                    onChanged: (value) => _evaluate.unintendedPositiveSideEffectsOfPractice = value!,
                    decoration: const InputDecoration(
                      filled: false,
                      fillColor: Colors.blueAccent,
                    ),
                    dropdownColor: Theme.of(context).colorScheme.background,
                  ),
                  const SizedBox(height: 30),
                  const Text('Details', style: TextStyle(color: Colors.grey, fontSize: 18)),
                  TextFormField(
                    initialValue: widget.practice.unintendedPositiveSideEffectsOfPracticeDetails.isNotEmpty
                        ? widget.practice.unintendedPositiveSideEffectsOfPracticeDetails
                        : '',
                    maxLength: 4096,
                    style: const TextStyle(color: Colors.white),
                    onSaved: (value) => _evaluate.unintendedPositiveSideEffectsOfPracticeDetails = value!,
                  ),
                  //
                  // Unintended negative side effects of practice
                  const SizedBox(height: 21),
                  const Text('Unintended negative side effects of practice',
                      style: TextStyle(color: Colors.grey, fontSize: 18)),
                  DropdownButtonFormField(
                    items: FormHelper.dropDownYesNo,
                    value: widget.practice.unintendedNegativeSideEffectOfPractice.isNotEmpty
                        ? widget.practice.unintendedNegativeSideEffectOfPractice
                        : '',
                    onChanged: (value) => _evaluate.unintendedNegativeSideEffectOfPractice = value!,
                    decoration: const InputDecoration(
                      filled: false,
                      fillColor: Colors.blueAccent,
                    ),
                    dropdownColor: Theme.of(context).colorScheme.background,
                  ),
                  const SizedBox(height: 30),
                  const Text('Details', style: TextStyle(color: Colors.grey, fontSize: 18)),
                  TextFormField(
                    initialValue: widget.practice.unintendedNegativeSideEffectOfPracticeDetails.isNotEmpty
                        ? widget.practice.unintendedNegativeSideEffectOfPracticeDetails
                        : '',
                    maxLength: 4096,
                    style: const TextStyle(color: Colors.white),
                    onSaved: (value) => _evaluate.unintendedNegativeSideEffectOfPracticeDetails = value!,
                  ),
                  //
                  // knowledge and skills required for practice
                  const SizedBox(height: 21),
                  const Text('Knowledge and skills required for practice',
                      style: TextStyle(color: Colors.grey, fontSize: 18)),
                  DropdownButtonFormField(
                    items: PracticeHelper.dropDownKnowledgeAndSkillsOptions,
                    value: widget.practice.knowledgeAndSkillsRequiredForPractice.isNotEmpty
                        ? widget.practice.knowledgeAndSkillsRequiredForPractice
                        : '',
                    onChanged: (value) => _evaluate.knowledgeAndSkillsRequiredForPractice = value!,
                    decoration: const InputDecoration(
                      filled: false,
                      fillColor: Colors.blueAccent,
                    ),
                    dropdownColor: Theme.of(context).colorScheme.background,
                  ),
                  const SizedBox(height: 30),
                  const Text('Details', style: TextStyle(color: Colors.grey, fontSize: 18)),
                  TextFormField(
                    initialValue: widget.practice.knowledgeAndSkillsRequiredForPracticeDetails.isNotEmpty
                        ? widget.practice.knowledgeAndSkillsRequiredForPracticeDetails
                        : '',
                    maxLength: 4096,
                    style: const TextStyle(color: Colors.white),
                    onSaved: (value) => _evaluate.knowledgeAndSkillsRequiredForPracticeDetails = value!,
                  ),
                  //
                  // labour required for practice
                  const SizedBox(height: 21),
                  const Text('Labour required for practice', style: TextStyle(color: Colors.grey, fontSize: 18)),
                  DropdownButtonFormField(
                    items: PracticeHelper.dropDownLabourOptions,
                    value: widget.practice.labourRequiredForPractice.isNotEmpty
                        ? widget.practice.labourRequiredForPractice
                        : '',
                    onChanged: (value) => _evaluate.labourRequiredForPractice = value!,
                    decoration: const InputDecoration(
                      filled: false,
                      fillColor: Colors.blueAccent,
                    ),
                    dropdownColor: Theme.of(context).colorScheme.background,
                  ),
                  const SizedBox(height: 30),
                  const Text('Details', style: TextStyle(color: Colors.grey, fontSize: 18)),
                  TextFormField(
                    initialValue: widget.practice.labourRequiredForPracticeDetails.isNotEmpty
                        ? widget.practice.labourRequiredForPracticeDetails
                        : '',
                    maxLength: 4096,
                    style: const TextStyle(color: Colors.white),
                    onSaved: (value) => _evaluate.labourRequiredForPracticeDetails = value!,
                  ),
                  //
                  // cost associated with practice
                  const SizedBox(height: 21),
                  const Text('Cost associated with practice', style: TextStyle(color: Colors.grey, fontSize: 18)),
                  DropdownButtonFormField(
                    items: PracticeHelper.dropDownCostsOptions,
                    value: widget.practice.costAssociatedWithPractice.isNotEmpty
                        ? widget.practice.costAssociatedWithPractice
                        : '',
                    onChanged: (value) => _evaluate.costAssociatedWithPractice = value!,
                    decoration: const InputDecoration(
                      filled: false,
                      fillColor: Colors.blueAccent,
                    ),
                    dropdownColor: Theme.of(context).colorScheme.background,
                  ),
                  const SizedBox(height: 30),
                  const Text('Details', style: TextStyle(color: Colors.grey, fontSize: 18)),
                  TextFormField(
                    initialValue: widget.practice.costAssociatedWithPracticeDetails.isNotEmpty
                        ? widget.practice.costAssociatedWithPracticeDetails
                        : '',
                    maxLength: 4096,
                    style: const TextStyle(color: Colors.white),
                    onSaved: (value) => _evaluate.costAssociatedWithPracticeDetails = value!,
                  ),
                  //
                  // does it work in degraded environments
                  const SizedBox(height: 21),
                  const Text('Does it work in degraded environments?',
                      style: TextStyle(color: Colors.grey, fontSize: 18)),
                  DropdownButtonFormField(
                    items: PracticeHelper.dropDownDegradedOptions,
                    value: widget.practice.doesItWorkInDegradedEnvironments.isNotEmpty
                        ? widget.practice.doesItWorkInDegradedEnvironments
                        : '',
                    onChanged: (value) => _evaluate.doesItWorkInDegradedEnvironments = value!,
                    decoration: const InputDecoration(
                      filled: false,
                      fillColor: Colors.blueAccent,
                    ),
                    dropdownColor: Theme.of(context).colorScheme.background,
                  ),
                  const SizedBox(height: 30),
                  const Text('Details', style: TextStyle(color: Colors.grey, fontSize: 18)),
                  TextFormField(
                    initialValue: widget.practice.doesItWorkInDegradedEnvironmentsDetails.isNotEmpty
                        ? widget.practice.doesItWorkInDegradedEnvironmentsDetails
                        : '',
                    maxLength: 4096,
                    style: const TextStyle(color: Colors.white),
                    onSaved: (value) => _evaluate.doesItWorkInDegradedEnvironmentsDetails = value!,
                  ),
                  //
                  // does it help restore land
                  const SizedBox(height: 21),
                  const Text('Does it help restore land?', style: TextStyle(color: Colors.grey, fontSize: 18)),
                  DropdownButtonFormField(
                    items: PracticeHelper.dropDownEffectiveOptions,
                    value:
                        widget.practice.doesItHelpRestoreLand.isNotEmpty ? widget.practice.doesItHelpRestoreLand : '',
                    onChanged: (value) => _evaluate.doesItHelpRestoreLand = value!,
                    decoration: const InputDecoration(
                      filled: false,
                      fillColor: Colors.blueAccent,
                    ),
                    dropdownColor: Theme.of(context).colorScheme.background,
                  ),
                  const SizedBox(height: 30),
                  const Text('Details', style: TextStyle(color: Colors.grey, fontSize: 18)),
                  TextFormField(
                    initialValue: widget.practice.doesItHelpRestoreLandDetails.isNotEmpty
                        ? widget.practice.doesItHelpRestoreLandDetails
                        : '',
                    maxLength: 4096,
                    style: const TextStyle(color: Colors.white),
                    onSaved: (value) => _evaluate.doesItHelpRestoreLandDetails = value!,
                  ),
                  //
                  // climage change vulnerability effects
                  const SizedBox(height: 21),
                  const Text('Climate change vulnerability effects',
                      style: TextStyle(color: Colors.grey, fontSize: 18)),
                  DropdownButtonFormField(
                    items: PracticeHelper.dropDownEffectiveOptions,
                    value: widget.practice.climateChangeVulnerabilityEffects.isNotEmpty
                        ? widget.practice.climateChangeVulnerabilityEffects
                        : '',
                    onChanged: (value) => _evaluate.climateChangeVulnerabilityEffects = value!,
                    decoration: const InputDecoration(
                      filled: false,
                      fillColor: Colors.blueAccent,
                    ),
                    dropdownColor: Theme.of(context).colorScheme.background,
                  ),
                  const SizedBox(height: 30),
                  const Text('Details', style: TextStyle(color: Colors.grey, fontSize: 18)),
                  TextFormField(
                    initialValue: widget.practice.climateChangeVulnerabilityEffectsDetails.isNotEmpty
                        ? widget.practice.climateChangeVulnerabilityEffectsDetails
                        : '',
                    maxLength: 4096,
                    style: const TextStyle(color: Colors.white),
                    onSaved: (value) => _evaluate.climateChangeVulnerabilityEffectsDetails = value!,
                  ),
                  //
                  // time required for practice
                  const SizedBox(height: 21),
                  const Text('Time requirements', style: TextStyle(color: Colors.grey, fontSize: 18)),
                  DropdownButtonFormField(
                    items: PracticeHelper.dropDownTimeOptions,
                    value: widget.practice.timeRequirements.isNotEmpty ? widget.practice.timeRequirements : '',
                    onChanged: (value) => _evaluate.timeRequirements = value!,
                    decoration: const InputDecoration(
                      filled: false,
                      fillColor: Colors.blueAccent,
                    ),
                    dropdownColor: Theme.of(context).colorScheme.background,
                  ),
                  const SizedBox(height: 30),
                  const Text('Details', style: TextStyle(color: Colors.grey, fontSize: 18)),
                  TextFormField(
                    initialValue: widget.practice.timeRequirementsDetails.isNotEmpty
                        ? widget.practice.timeRequirementsDetails
                        : '',
                    maxLength: 4096,
                    style: const TextStyle(color: Colors.white),
                    onSaved: (value) => _evaluate.timeRequirementsDetails = value!,
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
