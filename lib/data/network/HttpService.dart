import 'dart:convert';

import 'package:beerproject/data/model/Beer.dart';
import 'package:http/http.dart' as http;

class HttpService {
  Future<List<Beer>> getBeers(minAbv, maxAbv, minIbu, maxIbu) async {
    http.Response res = await http.get(
        "https://api.punkapi.com/v2/beers?page=2&per_page=80&abv_gt=${minAbv}&abv_lt=${maxAbv}&ibu_gt=${minIbu}&ibu_lt=${maxIbu}");

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Beer> beers = body
          .map(
            (dynamic item) => Beer.fromJson(item),
          )
          .toList();

      return beers;
    } else {
      throw "Can't get posts.";
    }
  }
}
