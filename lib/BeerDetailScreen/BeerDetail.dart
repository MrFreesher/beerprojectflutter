import 'package:beerproject/data/database/db_helper.dart';
import 'package:beerproject/data/model/Beer.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BeerDetail extends StatefulWidget {
  final Beer beer;
  BeerDetail({this.beer}) {}
  @override
  _BeerDetailState createState() => _BeerDetailState();
}

class _BeerDetailState extends State<BeerDetail> {
  DbHelper dbHelper;
  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
  }

  void addToFavorites(beer) {
    this.dbHelper.save(widget.beer);
    print("Dodano");

    Flushbar(
      message: "Dodano do ulubionych",
      duration: Duration(seconds: 3),
    )..show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.beer.name),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () {
                addToFavorites(widget.beer);
              },
            )
          ],
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
                        subtitle: Text(widget.beer.name),
                      ),
                      ListTile(
                        title: Text("Tagline"),
                        subtitle: Text(widget.beer.tagline),
                      ),
                      ListTile(
                        title: Text("Description"),
                        subtitle: Text(widget.beer.description),
                      ),
                      ListTile(
                        title: Text("ABV"),
                        subtitle: Text(widget.beer.abv.toString()),
                      ),
                      ListTile(
                        title: Text("IBU"),
                        subtitle: Text(widget.beer.ibu.toString()),
                      ),
                      ListTile(
                        title: Text("Food pairing"),
                        subtitle: Text("${widget.beer.foodParing}"),
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
