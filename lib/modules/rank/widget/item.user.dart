import 'package:flutter/material.dart';
import 'package:quiz_multi_platform/common/widget/avatar.dart';

class ItemUser extends StatelessWidget {
  const ItemUser(
      {super.key,
      required this.imageUrl,
      required this.name,
      required this.score,
      required this.size});
  final String? name;
  final String? imageUrl;
  final String? score;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Avatar(
          imageUrl: imageUrl!,
          size: size!,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          name!,
          style: const TextStyle(color: Colors.blue),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          score!,
          style: const TextStyle(color: Colors.green),
        ),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }
}
