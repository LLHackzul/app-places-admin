import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/place.dart';
import '../providers/places_provider.dart';
import '../screens/place_detail_screen.dart';
class PlacesItem extends StatelessWidget {
  Place place;
  PlacesItem(this.place);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).pushNamed(PlaceDetailScreen.routeName, arguments: place.id);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Stack(
            children: [
              Container(
                width: 300,
                height: 300,
                child: FadeInImage(
                  placeholder: AssetImage('assets/img/placeholder.png'),
                  image: NetworkImage(place.img),
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      place.title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          backgroundColor: Colors.black54),
                    ),
                    Text(
                      place.description,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          decorationColor: Colors.black,
                          fontWeight: FontWeight.bold,
                          backgroundColor: Colors.black54),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
