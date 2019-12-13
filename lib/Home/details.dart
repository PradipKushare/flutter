import 'package:flutter/material.dart';
class DetailsPage extends StatefulWidget {

   final cityData;
  
  DetailsPage({Key key, @required this.cityData}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: Text(widget.cityData.name),
        
      ),
      
      //The whole application area
      body:SafeArea(
          child: Column(
            children: <Widget>[
            spaceVertical(20),
              appBar(),
              hero(),
              spaceVertical(20),
            //Center Items
            Expanded (
              child: sections(),
            ),

              //Bottom Button
              purchase()
          ],
          ),
      ),
    );
  }

  Widget hero(){
    return Container(
      child: Stack(
        children: <Widget>[
          Image.asset("assets/images/${widget.cityData.image}",), //This

          
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
               Text('Population: ${widget.cityData.population}',style: TextStyle(
                 fontWeight: FontWeight.w100,
                 fontSize: 14
               ),),
               Text(widget.cityData.country, style: TextStyle(
                 fontSize: 24,
                 fontWeight: FontWeight.bold,
                 color: Color(0xFF2F2F3E)
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
          description(),
          spaceVertical(50),
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

  Widget purchase(){
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FlatButton(child: Text("ADD TO BAG +",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2F2F3E)
            ),
          ), color: Colors.transparent,
            onPressed: (){},),
          Text(r"$95",
            style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w100,
                color: Color(0xFF2F2F3E)
            ),
          )
        ],
      ),
    );
  }


  Widget spaceVertical(double size){
    return SizedBox(height: size,);
  }
}
