import 'package:beerproject/data/model/Beer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BeerDetail extends StatelessWidget {
  final Beer beer;
  BeerDetail({this.beer});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(beer.name),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: <Widget>[
                Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ListTile(
                        title: Text("Name"),
                        subtitle: Text(beer.name),
                      ),
                      ListTile(
                        title: Text("Tagline"),
                        subtitle: Text(beer.tagline),
                      ),
                      ListTile(
                        title: Text("Description"),
                        subtitle: Text(beer.description),
                      ),
                      ListTile(
                        title: Text("ABV"),
                        subtitle: Text(beer.abv.toString()),
                      ),
                      ListTile(
                        title: Text("IBU"),
                        subtitle: Text(beer.ibu.toString()),
                      ),
                      ListTile(
                        title: Text("Food pairing"),
                        subtitle: Text("${beer.foodParing}"),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
