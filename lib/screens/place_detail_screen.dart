import '../widgets/site_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/places_provider.dart';
import './edit_site_screen.dart';
class PlaceDetailScreen extends StatefulWidget {
  static const routeName = '/place-detail-screen';

  @override
  State<PlaceDetailScreen> createState() => _PlaceDetailScreenState();
}

class _PlaceDetailScreenState extends State<PlaceDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final placeId = ModalRoute.of(context)!.settings.arguments as String;
    final loadedPlace =
        Provider.of<Places>(context, listen: false).findById(placeId);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    loadedPlace.title,
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 35,
                        fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(EditSiteScreen.routeName, arguments: placeId,);
                      },
                      icon: Icon(Icons.add))
                ],
              ),
              Text(
                loadedPlace.description,
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              Divider(
                color: Colors.black87,
              ),
              /*  Expanded(
                child: ListView.builder(
                  itemBuilder: (ctx, i) => SiteItem(),
                  itemCount: 5,
                ),
              ) */
            ],
          ),
        ));
  }
}
