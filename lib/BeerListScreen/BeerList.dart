import 'package:beerproject/BeerDetailScreen/BeerDetail.dart';
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
      ),
      body: FutureBuilder(
        future: httpService.getBeers(),
        builder: (BuildContext context, AsyncSnapshot<List<Beer>> snapshot) {
          if (snapshot.hasData) {
            List<Beer> beers = snapshot.data;
            return ListView(
                children: beers
                    .map(
                      (Beer beer) => ListTile(
                        title: Text("${beer.name}"),
                        subtitle: Text("${beer.tagline}"),
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
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
