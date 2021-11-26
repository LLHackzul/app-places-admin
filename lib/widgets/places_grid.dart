import 'package:flutter/material.dart';
import '../widgets/places_item.dart';
import 'package:provider/provider.dart';
import '../providers/places_provider.dart';

class PlacesGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Places>
      (child: Center(child: Text('No hay lugares, inténtalo más tarde')),
      builder: (ctx, greatPlaces, ch)=> greatPlaces.places.length <=0 ? ch as Widget : GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 4,
        mainAxisSpacing: 20,
      ),
      itemBuilder: (ctx, i) => PlacesItem(greatPlaces.places[i]),
      itemCount:  greatPlaces.places.length ,
      )
    );
  }
}
