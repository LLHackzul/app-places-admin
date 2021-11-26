import 'package:flutter/material.dart';
import '../models/site.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Sites with ChangeNotifier {
  List<Site> _items = [

  ];

  List<Site> get items {
    return [..._items];
  }

  Site findById(String id) {
    return _items.firstWhere((item) => item.id == id);
  }

  /* Future<void> fetchAndSetPlaces() async {
    final url = Uri.parse(
        'https://example-89004-default-rtdb.firebaseio.com/sites.json');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      final List<Site> loadedSites = [];
      extractedData.forEach((siteId, siteData) {
        loadedSites.add(Site(
          id: siteId,
          title: siteData['title'],
          description: siteData['description'],
          history: siteData['history'],
          location: siteData['location'],
          image: siteData['image'],
          placeId: siteData['placeId'],
        ));
      });
      _items = loadedSites;
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  } */

  Future<void> addSite(Site site) async {
    final url = Uri.parse(
        'https://example-89004-default-rtdb.firebaseio.com/sites.json');
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': site.title,
          'description': site.description,
          'history': site.history,
          'location': null,
          'image': site.image,
          'placeId': site.placeId,
        }),
      );
      print(json.decode(response.body));
      final newSite = Site(
        id: json.decode(response.body)['name'],
        title: site.title,
        description: site.description,
        history: site.history,
        image: site.image,
        placeId: site.placeId,
      );
      _items.add(newSite);
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
