import 'package:flamedemo/Home/tabs_details.dart';
import 'package:flutter/material.dart';
import 'package:flamedemo/Home/widget/mygridview.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../constants.dart';

class HomeView extends StatefulWidget {
    @override
  _MainFetchDataState createState() => _MainFetchDataState();
}
class _MainFetchDataState extends State<HomeView> {
     List<dynamic> list = List();

 var isLoading = false;

  _fetchData() async {
    setState(() {
      isLoading = true;
    });
    final response =
       await http.get(Constants.CityURL+'get_cities');
          if (response.statusCode == 200) {

           setState(() {isLoading = false; });

            Map data = jsonDecode(response.body);
            
            list = data["data"].map((result) => new HomeList.fromJson(result)).toList();


        // list = (json.decode(response.body) as List)
        //   .map((data) => new HomeList.fromJson(data))
        //   .toList();
        
    } else {
      throw Exception('Failed to load photos');
    }
  }


  @override
    void initState() {
      _fetchData();
    }

  final GlobalKey scaffoldKey = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: scaffoldKey,
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
              : new Padding(
            padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
            child: getHomePageBody(context)),
      );
  }

  getHomePageBody(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.portrait)
      return ListView.builder(
        itemCount: list.length,
        itemBuilder: _getListItemUI,
        padding: EdgeInsets.all(0.0),
      );
    else
      return new MyGridView(list: list);
  }

  Widget _getListItemUI(BuildContext context, int index,
      {double imgwidth: 100.0}) {
    return new Card(
        child: new Column(
      children: <Widget>[
        new ListTile(
          leading: new Image.asset(
            "assets/cities/"+ list[index].image,
            fit: BoxFit.fitHeight,
            width: imgwidth,
          ),
          title: new Text(
            list[index].name,
            style: new TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
          ),
          subtitle: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(list[index].country,
                    style: new TextStyle(
                        fontSize: 13.0, fontWeight: FontWeight.bold)),
                new Text('Population: ${list[index].population}',
                    style: new TextStyle(
                        fontSize: 11.0, fontWeight: FontWeight.normal)),
              ]),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TabDetailsView(cityData:list[index]),),
                );
          },

          //  onTap: () {
          //   Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => CityDetailsPage(),),
          //       );
          // },
          
        )
      ],
    ));
  }
}

class HomeList {
  final String name;
  final String id;
  final String country;
  final String population;
  final String area;
  final String state;
  final String image;
  final String description;
  final String latitude;
  final String longitude;


HomeList({this.name, this.country, this.population, this.area,this.state,this.image,this.description,this.latitude,this.longitude,this.id});

factory HomeList.fromJson(Map<String, dynamic> json) {
    return new HomeList(
      id: json['_id'].toString(),
      name: json['name'].toString(),
      country: json['country'].toString(),
      population: json['population'].toString(),
      area: json['area'].toString(),
      state: json['state'].toString(),
      image: json['image'].toString(),
      description: json['description'].toString(),
      latitude: json['latitude'].toString(),
      longitude: json['longitude'].toString(),
    );
  }
}
