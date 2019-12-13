import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:smooth_star_rating/smooth_star_rating.dart'; 

import '../constants.dart';
import 'city_place_details_view.dart';

class CityPlacesPage extends StatefulWidget {
   final cityData;
  CityPlacesPage({Key key, @required this.cityData}) : super(key: key);

    @override
  _MainFetchDataState createState() => _MainFetchDataState();
}
class _MainFetchDataState extends State<CityPlacesPage> {
     List<dynamic> list = List();

 var isLoading = false;

    Future _getSliderImages() async {
       setState(() { isLoading = true;});
      try {
        Dio dio = new Dio();
        Map postdata = {'city_id': widget.cityData.id};
         var response = await dio.post(Constants.CityURL+'get_city_places', data: postdata);
          var data = json.decode(response.toString());
          if(data["success"]){
            setState(() {isLoading = false; });
            list = data["data"].map((result) => new PlacesList.fromJson(result)).toList();
             setState(() { list = list; });
        }else{
          setState(() {isLoading = false; list = []; });
        }
      } catch (e) {
          print(e);
    }
}

  @override
    void initState() {
      _getSliderImages();
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
     return ListView.builder(
        itemCount: list.length,
        itemBuilder: _getListItemUI,
        padding: EdgeInsets.all(0.0),
      );
     }

  Widget _getListItemUI(BuildContext context, int index,
      {double imgwidth: 100.0}) {
    return new Card(
        child: new Column(
      children: <Widget>[
        new ListTile(
          leading: new Image.asset(
            "assets/places/"+ list[index].image,
            fit: BoxFit.fitHeight,
            width: imgwidth,
          ),
          title: new Text(
            list[index].palcename,
            style: new TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
          ),
          subtitle: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

          
                SmoothStarRating(
                    allowHalfRating: true,
                     starCount: list[index].rating,
                    size: 20.0,
                    color: Colors.green,
                    borderColor: Colors.green,
                    spacing:0.0
                  )
              ]),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CityPlaceDetails(placeData:list[index],cityname:widget.cityData.name)),
              );
          },   
        )
      ],
    ));
  }
}

class PlacesList {
  final String palcename;
  final String description;
  final String image;
  final int rating;
  final String latitude;
  final String longitude;
  final String id;


PlacesList({this.palcename, this.description, this.image, this.rating,this.latitude,this.longitude,this.id});

factory PlacesList.fromJson(Map<String, dynamic> json) {

    return new PlacesList(
      id: json['_id'].toString(),
      palcename: json['palce_name'].toString(),
      description: json['description'].toString(),
      image: json['image'].toString(),
      rating: json['rating'].round(),
      latitude: json['latitude'].toString(),
      longitude: json['longitude'].toString(),
    );
  }
}
