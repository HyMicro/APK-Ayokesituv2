// To parse this JSON data, do
//
//     final tours = toursFromJson(jsonString);

import 'dart:convert';

Tours toursFromJson(String str) => Tours.fromJson(json.decode(str));

String toursToJson(Tours data) => json.encode(data.toJson());

class Tours {
  List<Tour> data;

  Tours({
    required this.data,
  });

  factory Tours.fromJson(Map<String, dynamic> json) => Tours(
        data: List<Tour>.from(json["data"].map((x) => Tour.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Tour {
  String title;
  String address;
  String location;
  String ratting;
  int review;
  String price;
  String days;
  String img;
  String vid;
  List<Amenity> amenities;

  Tour({
    required this.title,
    required this.address,
    required this.location,
    required this.ratting,
    required this.review,
    required this.price,
    required this.days,
    required this.img,
    required this.vid,
    required this.amenities,
  });

  factory Tour.fromJson(Map<String, dynamic> json) => Tour(
        title: json["title"],
        address: json["address"],
        location: json["location"],
        ratting: json["ratting"],
        review: json["review"],
        price: json["price"],
        days: json["days"],
        img: json["img"],
        vid: json["vid"],
        amenities: List<Amenity>.from(
            json["amenities"].map((x) => Amenity.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "address": address,
        "location": location,
        "ratting": ratting,
        "review": review,
        "price": price,
        "days": days,
        "img": img,
        "vid": vid,
        "amenities": List<dynamic>.from(amenities.map((x) => x.toJson())),
      };
}

class Amenity {
  String data;

  Amenity({
    required this.data,
  });

  factory Amenity.fromJson(Map<String, dynamic> json) => Amenity(
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "data": data,
      };
}
