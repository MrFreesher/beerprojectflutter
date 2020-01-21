import 'package:beerproject/BeerDetailScreen/BeerDetail.dart';
import 'package:beerproject/data/database/db_helper.dart';
import 'package:beerproject/data/model/Beer.dart';
import 'package:flutter/material.dart';

class FavoriteBeerList extends StatefulWidget {
  FavoriteBeerList({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _FavoriteBeerListState createState() => _FavoriteBeerListState();
}

class _FavoriteBeerListState extends State<FavoriteBeerList> {
  DbHelper dbHelper;
  @override
  void initState() {
    super.initState();
    dbHelper = new DbHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: dbHelper.getBeers(),
        builder: (BuildContext context, AsyncSnapshot<List<Beer>> snapshot) {
          if (null == snapshot.data || snapshot.data.length == 0) {
            return Text("Empty");
          }
          if (snapshot.hasData) {
            List<Beer> beers = snapshot.data;
            return ListView(
                children: beers
                    .map(
                      (Beer beer) => ListTile(
                        title: Text("${beer.name}" ?? "1"),
                        subtitle: Text("${beer.tagline}" ?? "2"),
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => BeerDetail(
                              beer: beer,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList());
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
