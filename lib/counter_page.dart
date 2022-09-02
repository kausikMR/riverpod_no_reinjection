import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'nested_counter_page.dart';

class CounterPage extends ConsumerWidget {
  const CounterPage({super.key, required this.index, required this.onNavNext, required this.onNavPrev});

  final int index;
  final void Function(int index) onNavNext;
  final void Function(int index) onNavPrev;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterProvider);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('$index Page', style: const TextStyle(fontSize: 36)),
          const SizedBox(height: 40),
          Text('$count', style: const TextStyle(fontSize: 26)),
          TextButton(
            onPressed: () {
              ref.read(counterProvider.notifier).increment();
            },
            child: const Text('Increment'),
          ),
          const SizedBox(height: 40),
          TextButton(
            onPressed: () {
              onNavNext(index + 1);
            },
            child: const Text('Move to next page'),
          ),
          TextButton(
            onPressed: () {
              onNavPrev(index - 1);
            },
            child: const Text('Move to prev page'),
          ),
        ],
      ),
    );
  }
}
