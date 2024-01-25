import 'package:flutter/material.dart';

class TextBlockWidget extends StatelessWidget {
  final String label;
  final String value;

  const TextBlockWidget({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (value.isNotEmpty) ...[
          const SizedBox(height: 14),
          Text(
            overflow: TextOverflow.ellipsis,
            label,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ],
    );
  }
}
