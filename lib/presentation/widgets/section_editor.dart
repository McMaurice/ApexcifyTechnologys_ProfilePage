import 'package:flutter/material.dart';

class SectionEditor extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const SectionEditor({super.key, required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 10),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.4),
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1C1C1E),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
          ),
          child: Column(
            children: children
                .expand(
                  (w) => [
                    w,
                    if (w != children.last)
                      Divider(height: 0, indent: 16, color: Colors.white.withValues(alpha: 0.07)),
                  ],
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
