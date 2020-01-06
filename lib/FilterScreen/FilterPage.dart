import 'package:beerproject/BeerListScreen/BeerList.dart';
import 'package:flutter/material.dart';

class FilterPage extends StatefulWidget {
  FilterPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  RangeValues abuValues = RangeValues(1, 68);
  RangeValues ibuValues = RangeValues(0, 120);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Min ${abuValues.start.toStringAsFixed(2)}")),
                Padding(padding: EdgeInsets.all(8.0), child: Text("ABV")),
                Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Max ${abuValues.end.toStringAsFixed(2)}")),
              ],
            ),
            RangeSlider(
              min: 1,
              max: 100,
              values: abuValues,
              divisions: 100,
              onChanged: (value) {
                setState(() {
                  abuValues = value;
                });
              },
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Min ${ibuValues.start.toInt()}")),
                Padding(padding: EdgeInsets.all(8.0), child: Text("IBU")),
                Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Max ${ibuValues.end.toInt()}")),
              ],
            ),
            RangeSlider(
              min: 0,
              max: 120,
              values: ibuValues,
              divisions: 100,
              onChanged: (value) {
                setState(() {
                  ibuValues = value;
                });
              },
            ),
            FlatButton(
              color: Colors.blue,
              textColor: Colors.white,
              padding: EdgeInsets.all(8.0),
              splashColor: Colors.blueAccent,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BeerList(
                              title: "Beer list",
                              minAbv: double.parse(
                                  abuValues.start.toStringAsFixed(2)),
                              maxAbv: double.parse(
                                  this.abuValues.end.toStringAsFixed(2)),
                              minIbu: double.parse(
                                  this.ibuValues.start.toStringAsFixed(0)),
                              maxIbu: double.parse(
                                  this.ibuValues.end.toStringAsFixed(0)),
                            )));
              },
              child: Text(
                "Search",
                style: TextStyle(fontSize: 20.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}
