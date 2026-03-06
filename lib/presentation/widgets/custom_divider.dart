import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(height: 0, indent: 68, color: Colors.white.withValues(alpha: 0.07));
  }
}
