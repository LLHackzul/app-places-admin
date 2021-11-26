import '../widgets/outstanding_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OutstandingGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(5),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 4/7,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemBuilder: (ctx, i) => OutstandingItem(),
      itemCount: 10,
    );
  }
}
