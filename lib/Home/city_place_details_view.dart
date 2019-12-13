import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:url_launcher/url_launcher.dart';

import 'city_map.dart'; 

class CityPlaceDetails extends StatefulWidget {
  CityPlaceDetails({Key key, this.placeData,this.cityname}) : super(key: key);

  final placeData;
  final String cityname;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<CityPlaceDetails> {
  final _scaffoldKey = GlobalKey<ScaffoldState>(); 

  bool _favFlag = false;

  @override
    void initState() {
    }

_likeUnlike(){
 setState(() { _favFlag = !_favFlag; });
  var placeliked = 'Removed from favourite!';
    if(_favFlag){
      placeliked = 'Added to favourite!';
    }
    final snackBar = SnackBar(content: Text(placeliked,textAlign: TextAlign.center,style: TextStyle(fontSize: 14.0),),
     duration: Duration(seconds:1),
     backgroundColor: Colors.black,
     );
    _scaffoldKey.currentState.showSnackBar(snackBar);  
}

  @override
  
  Widget build(BuildContext context) {

 Widget titleSection = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    widget.placeData.palcename,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  widget.cityname,
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

        Color color = Theme.of(context).primaryColor;

    Widget buttonSection = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButtonColumn(color, Icons.call, 'CALL'),
          _buildButtonColumn(color, Icons.near_me, 'ROUTE'),
          _buildButtonColumn(color, Icons.share, 'SHARE'),
        ],
      ),
    );


   Widget showrating =  SmoothStarRating(
            allowHalfRating: true,
              starCount: widget.placeData.rating,
            size: 30.0,
            color: Colors.green,
            borderColor: Colors.redAccent,
            spacing:0.0
    );
    
    Widget textSection = Container(
      padding: const EdgeInsets.all(32),
       child: ExpandablePanel(
      collapsed: Text(widget.placeData.description, softWrap: true, maxLines: 5,textAlign: TextAlign.justify,
      style: TextStyle(height: 1.5, color: Color(0xFF6F8398)),),
      expanded: Text(widget.placeData.description, softWrap: true, textAlign: TextAlign.justify,
      style: TextStyle(height: 1.5, color: Color(0xFF6F8398)),),
      tapHeaderToExpand: true,
      hasIcon: true,
    ),
    );

    return Scaffold(
       key: _scaffoldKey,     
       appBar: AppBar(
          title: Text(widget.placeData.palcename),
          backgroundColor: Colors.blue[300],
        ),
      //The whole application area
      body:SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
                hero(),
                 titleSection,
                buttonSection,
                spaceVertical(20),
                 showrating,
                textSection,
          ],
          ),
        ),
      ),
    );
  }

  Widget hero(){
    return Container(
      margin: EdgeInsets.all(10.0),
      constraints: new BoxConstraints.expand(
        height: 200.0,
      ),
      alignment: Alignment.topRight,
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage('assets/places/'+widget.placeData.image),
  
          fit: BoxFit.cover,
        ),
      ),

     child: Column(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.favorite),
            iconSize: 30,
            color:(_favFlag) ? Colors.pink : Colors.white,
            tooltip: 'Add to favourite',
             onPressed:(){
               _likeUnlike();
            },
          ),
        ],
      )

    );
  }

  Widget spaceVerticl(double size){
    return SizedBox(height: size,);
  }
  
Widget spaceVertical(double size){
    return SizedBox(height: size,);
  }
    Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        new FlatButton(
                    onPressed: () {
                      if(label == 'ROUTE'){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CityDetailsMap(lat:double.parse(widget.placeData.latitude),lng:double.parse(widget.placeData.longitude),name:widget.placeData.palcename),),
                        );
                      }else if(label == 'CALL'){
                        launch("tel://21213123123");
                      }
            },
                  child: Icon(icon, color: color),
                ),

       
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }

}

