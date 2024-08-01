import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ErrorView extends ConsumerWidget {
  const ErrorView({
    super.key,
    required this.errorMessage,
    required this.providerClass,
  });

  final String errorMessage;
  final AlwaysAliveProviderBase providerClass;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Error",
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onError,
                ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Center(
                child: Text(
                  errorMessage,
                  style: const TextStyle(fontSize: 20, color: Colors.red),
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: () {
                  ref.invalidate(providerClass);
                },
                label: const Text("Retry"),
                icon: const Icon(Icons.refresh),
              )
            ],
          ),
        ),
      ),
    );
  }
}
