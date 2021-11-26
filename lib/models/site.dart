import 'package:flutter/material.dart';
import 'dart:io';

class SiteLocation {
  final double lattitude;
  final double longitude;
  final String? address;
  SiteLocation(
      {required this.lattitude, required this.longitude, this.address});
}

class Site {
  final String id;
  final String title;
  final String description;
  final String history;
  final SiteLocation? location;
  final String image;

  final String placeId;

  Site(
      {required this.id,
      required this.title,
      required this.description,
      required this.history,
      required this.image,
      required this.placeId,
      this.location});
}
