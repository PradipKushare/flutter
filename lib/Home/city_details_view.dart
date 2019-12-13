import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../constants.dart';

class CityDetailsPage extends StatefulWidget {
   final cityData;
   
  CityDetailsPage({Key key, @required this.cityData}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<CityDetailsPage> {
   List<dynamic> cityimages = List();
      int index = 0;
  var isLoading = false;

   @override 
    void initState() {
    super.initState();
      _getSliderImages();
  }

   Future _getSliderImages() async {
       setState(() { isLoading = true;});
      try {
        Dio dio = new Dio();
        Map postdata = {'city_id': widget.cityData.id};
         var response = await dio.post(Constants.CityURL+'get_city_images', data: postdata);
          var data = json.decode(response.toString());
          if(data["success"]){
            setState(() {isLoading = false; });
            cityimages = data["data"].map((result) => new CityImages.fromJson(result)).toList();
             setState(() { cityimages = cityimages; });
        }else{
          setState(() {isLoading = false; cityimages = []; });
        }
      } catch (e) {
          print(e);
    }
}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              appBar(),
              hero(),
              spaceVertical(20),
              sections(),
             imagegallery(context),
            ],
          ),
      ),
    );
  
  }

  Widget hero(){
    
    return Container(
       margin: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Stack(
        children: <Widget>[
          Image.asset("assets/cities/${widget.cityData.image}",), //This
        ],
      ),
    );
  }

  Widget appBar(){
    return Container(
      padding: EdgeInsets.all(16),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Column(
             children: <Widget>[
              
               Text(widget.cityData.country, style: TextStyle(
                 fontSize: 24,
                 fontWeight: FontWeight.bold,
                 color: Color(0xFF2F2F3E)
                ),
               ),
                Text('Population: ${widget.cityData.population}',style: TextStyle(
                 fontWeight: FontWeight.w100,
                 fontSize: 14
               ),
              ),
             ],
            ),
          ),
        ],
      ),
    );
  }

  Widget sections(){
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
              Align(  
                alignment: Alignment.topLeft,
                child: Text("Description",
                   style: new TextStyle(
                  fontSize: 16.0,
                  fontFamily: 'Roboto',
                  color: new Color(0xFF26C6DA),
                  fontWeight: FontWeight.bold,
                ),)
              ),
        
          description(),
          spaceVertical(5),
        ],
      ),
    );
  }

  Widget description(){
    return Text(widget.cityData.description,
             textAlign: TextAlign.justify,
            style: TextStyle(height: 1.5, color: Color(0xFF6F8398)),);
  }

  Widget size(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Size", textAlign: TextAlign.left,
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2F2F3E)
          ),
        ),
        spaceVertical(10),
        Container(
          width: 70,
          padding: EdgeInsets.all(10),
          color: Color(0xFFF5F8FB),
          child: Text("10.1",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2F2F3E)
            ),
          ),
        )

      ],
    );
  }

  Widget imagegallery(BuildContext context){
    if(isLoading) {
      return CircularProgressIndicator();
    }else{
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
        CarouselSlider(
          items: cityimages.map((it) {
            return new Builder(
              builder: (BuildContext context) {
                return new Container(
                  width: MediaQuery.of(context).size.width,
                
                  child: FittedBox(
                      child: Image.asset("assets/city_images/"+it.cityimage),
                      fit: BoxFit.fill,
                    )

                );
              },
            );
          }).toList(),

                height: 100,
                aspectRatio: 16/9,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 2),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                pauseAutoPlayOnTouch: Duration(seconds: 2),
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
         
        )
      ],
      ),
    );
   }
  }

  Widget spaceVertical(double size){
    return SizedBox(height: size,);
  }
}

class CityImages {
  final String cityimage;  
CityImages({this.cityimage});
factory CityImages.fromJson(Map<String, dynamic> json) {
    return new CityImages(
       cityimage: json['city_image'].toString()
    );
  }
}