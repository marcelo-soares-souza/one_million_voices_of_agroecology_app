import 'package:flutter/material.dart';

class PracticesScreen extends StatelessWidget {
  const PracticesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Practices',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground)),
      ),
    );
  }
}
