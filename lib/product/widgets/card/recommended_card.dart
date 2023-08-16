import 'package:flutter/material.dart';
import 'package:flutter_firebase/product/models/recommended.dart';
import 'package:kartal/kartal.dart';

class RecommendedCard extends StatelessWidget {
  const RecommendedCard({
    required this.recommended,
  });

  final Recommended recommended;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.padding.onlyTopLow,
      child: Row(
        children: [
          Image.network(
            recommended.image ?? '',
            errorBuilder: (context, error, stackTrace) => const Placeholder(),
            height: 96,
          ),
          Expanded(
            child: ListTile(
              title: Text(
                recommended.title ?? '',
              ),
              subtitle: Text(
                recommended.description ?? '',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
