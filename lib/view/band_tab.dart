import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class BandTab extends StatelessWidget {
  const BandTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "band",
          style: Theme.of(context).textTheme.headline1,
        ),
        const Icon(
          IconlyLight.user_1,
          size: 40,
        ),
      ],
    );
  }
}