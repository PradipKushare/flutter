import 'package:flutter/material.dart';

import '../home.dart';

class MyGridView extends StatelessWidget {
      List<dynamic> list = List();

  MyGridView({Key key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      padding: EdgeInsets.all(16.0),
       childAspectRatio: 8.0 / 9.0,
      children: _getGridViewItems(context),
    );
  }

  _getGridViewItems(BuildContext context) {
    List<Widget> allWidgets = new List<Widget>();
    for (int i = 0; i < list.length; i++) {
      var widget = _getGridItemUI(context, list[i]);
      allWidgets.add(widget);
    }
    return allWidgets;
  }

  // Create individual item
  _getGridItemUI(BuildContext context, HomeList item) {
    return new InkWell(
        child: new Card(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Image.asset(
                "assets/cities/" + item.image,
                fit: BoxFit.fill,
                //height:100.0,
              ),
              new Expanded(
                  child: new Center(
                      child: new Column(
                        children: <Widget>[
                          new SizedBox(height: 8.0),
                          new Text(
                            item.name,
                            style: new TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          new Text(item.country),
                          new Text('Population: ${item.population}')
                        ],
                      )))
            ],
          ),
          elevation: 2.0,
          margin: EdgeInsets.all(5.0),
        ));
  }
}
