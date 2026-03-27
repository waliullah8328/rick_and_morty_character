import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ErrorScreen extends ConsumerWidget {
  final String? errorMessage;
  final VoidCallback onRefresh;
  final bool isDarkMode;
  final String? title;

  const ErrorScreen({
    super.key,
    this.errorMessage,
    required this.onRefresh,
    required this.isDarkMode,
    this.title,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final displayMessage = errorMessage ?? "Something went wrong!";
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 80,
              color: isDarkMode ? Colors.redAccent : Colors.red,
            ),
            const SizedBox(height: 20),
            Text(
              title ?? "Oops!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              displayMessage,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: isDarkMode ? Colors.white70 : Colors.black54,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: onRefresh,
              icon: const Icon(Icons.refresh),
              label: const Text("Retry"),
              style: ElevatedButton.styleFrom(
                backgroundColor: isDarkMode ? Colors.tealAccent[700] : Colors.teal,
                foregroundColor: Colors.white,
                padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
