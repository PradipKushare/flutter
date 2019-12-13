
import 'package:flutter/material.dart';
import 'city_details_view.dart';
import 'city_map.dart';
import 'city_places_view.dart';

class TabDetailsView extends StatefulWidget {
  final cityData;
   TabDetailsView({Key key, @required this.cityData}) : super(key: key);
  @override
  _MyHomePageState1 createState() => _MyHomePageState1();
}

class _MyHomePageState1 extends State<TabDetailsView> {

  @override
  Widget build(BuildContext context) {
        return DefaultTabController(
          length: 4,
           child: Scaffold(
           appBar: AppBar(
           actions: <Widget>[
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CityDetailsMap(lat:double.parse(widget.cityData.latitude),lng:double.parse(widget.cityData.longitude),name:widget.cityData.name),),
                );
            },
          ),
        ], 
      title: Text(widget.cityData.name),
      automaticallyImplyLeading: true,
              bottom: TabBar(
                 tabs: [
                Tab(text: "Details"),
                Tab(text: "Places"),
                Tab(text: "Museums"),
                Tab(text: "Parks"),
                 ],

            ),
 
      ),

          body: TabBarView(
            children: [
              CityDetailsPage(cityData: widget.cityData),
              CityPlacesPage(cityData: widget.cityData),
              Icon(Icons.directions_transit),
              Icon(Icons.folder),
            ],
          ),
        ),
    );
  }
}

