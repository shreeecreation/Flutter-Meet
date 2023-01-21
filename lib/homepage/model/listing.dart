import 'dart:convert';

import 'package:flutter/services.dart' as rootBundle;

class ProductDetails {
  String? _productName;
  String? _image;
  String? _description;
  String? _price;
  String? _discount;
  String? _service;
  List<String>? _comment;
  String? _ratings;

  ProductDetails(
      {String? productName,
      String? image,
      String? description,
      String? price,
      String? discount,
      String? service,
      List<String>? comment,
      String? ratings}) {
    if (productName != null) {
      _productName = productName;
    }
    if (image != null) {
      _image = image;
    }
    if (description != null) {
      _description = description;
    }
    if (price != null) {
      _price = price;
    }
    if (discount != null) {
      _discount = discount;
    }
    if (service != null) {
      _service = service;
    }
    if (comment != null) {
      _comment = comment;
    }
    if (ratings != null) {
      _ratings = ratings;
    }
  }

  String? get productName => _productName;
  set productName(String? productName) => _productName = productName;
  String? get image => _image;
  set image(String? image) => _image = image;
  String? get description => _description;
  set description(String? description) => _description = description;
  String? get price => _price;
  set price(String? price) => _price = price;
  String? get discount => _discount;
  set discount(String? discount) => _discount = discount;
  String? get service => _service;
  set service(String? service) => _service = service;
  List<String>? get comment => _comment;
  set comment(List<String>? comment) => _comment = comment;
  String? get ratings => _ratings;
  set ratings(String? ratings) => _ratings = ratings;

  ProductDetails.fromJson(Map<String, dynamic> json) {
    _productName = json['product_name'];
    _image = json['image'];
    _description = json['description'];
    _price = json['price'];
    _discount = json['discount'];
    _service = json['service'];
    _comment = json['comment'].cast<String>();
    _ratings = json['ratings'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_name'] = _productName;
    data['image'] = _image;
    data['description'] = _description;
    data['price'] = _price;
    data['discount'] = _discount;
    data['service'] = _service;
    data['comment'] = _comment;
    data['ratings'] = _ratings;
    return data;
  }
}

Future<List<ProductDetails>> ReadJsonData() async {
  //read json file
  final jsondata = await rootBundle.rootBundle.loadString("lib/homepage/domain/listing.json");
  //decode json data as list
  final list = json.decode(jsondata) as List<dynamic>;

  //map json and initialize using DataModel
  return list.map((e) => ProductDetails.fromJson(e)).toList();
}
