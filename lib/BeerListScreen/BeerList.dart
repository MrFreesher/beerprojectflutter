import 'package:beerproject/BeerDetailScreen/BeerDetail.dart';
import 'package:beerproject/FavoriteBeerListScreen/FavoriteBeerList.dart';
import 'package:beerproject/data/model/Beer.dart';
import 'package:beerproject/data/network/HttpService.dart';
import 'package:flutter/material.dart';

class BeerList extends StatefulWidget {
  BeerList(
      {Key key, this.title, this.minAbv, this.maxAbv, this.minIbu, this.maxIbu})
      : super(key: key);
  final String title;
  final double minAbv;
  final double maxAbv;
  final double minIbu;
  final double maxIbu;

  @override
  _BeerListState createState() => _BeerListState();
}

class _BeerListState extends State<BeerList> {
  HttpService httpService;
  @override
  void initState() {
    super.initState();
    httpService = new HttpService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => FavoriteBeerList(
                        title: "Favorites beer",
                      )));
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: httpService.getBeers(
            widget.minAbv, widget.maxAbv, widget.minIbu, widget.maxIbu),
        builder: (BuildContext context, AsyncSnapshot<List<Beer>> snapshot) {
          if (null == snapshot.data || snapshot.data.length == 0) {
            return Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.cyan,
              strokeWidth: 5,
            ));
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
