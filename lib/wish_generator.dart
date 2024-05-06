import 'dart:convert';

import 'package:flutter_project/wish_model.dart';
import 'package:http/http.dart' as http;

class WishGenerator {
  static final WishGenerator _singleton = WishGenerator._internal();
  factory WishGenerator() {
    return _singleton;
  }
  WishGenerator._internal();

  Future<WishModel> generateWish(String topic) {
    Future<http.Response> value =
        http.get(Uri.parse("http://localhost:5000/generatewish?wish=$topic"));
    return value
        .then((response) => response.statusCode == 200
            ? jsonDecode(response.body)['goal']
            : 'none')
        .then((value) => WishModel(value));
  }
}
