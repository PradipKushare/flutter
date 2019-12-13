import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:dio/dio.dart';

import '../constants.dart';
import 'item_details.dart';
import 'cart_screen.dart';

class ItemScreen extends StatefulWidget {
   final prodData;
  ItemScreen({Key key,@required this.prodData}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ProductLists();
}

class ProductLists extends State<ItemScreen> {

   List<dynamic> prodLists = List();
  var isLoading = false;
    bool _favFlag = false;

     @override 
    void initState() {
    super.initState();
      _getProdLists();
  }
    Future _getProdLists() async {
       setState(() { isLoading = true;});
      try {
        Dio dio = new Dio();
        Map postdata = {'cat_id': widget.prodData.id};
         var response = await dio.post(Constants.CatURL+'get_cat_products', data: postdata);
          var data = json.decode(response.toString());
          if(data["success"]){
            setState(() {isLoading = false; });
            
            prodLists = data["data"].map((result) => new ProductShow.fromJson(result)).toList();
             setState(() { prodLists = prodLists; });
        }else{
          setState(() {isLoading = false; prodLists = []; });
        }
      } catch (e) {
          print(e);
    }
}

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    return new Scaffold(
      key: _scaffoldKey,
       appBar: AppBar(
      actions: <Widget>[
         IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> CartScreen()));
            },
          ),
        ],

          title: Text(widget.prodData.catname),
          backgroundColor: Colors.blue[300],
       ),
      body: Column(
        children: <Widget>[
          Container(
            child: Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: (itemWidth / itemHeight),
                controller: new ScrollController(keepScrollOffset: false),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                // padding: const EdgeInsets.all(4.0),
                children: prodLists.map((photo) { 
                  return TravelDestinationItem(
                    prodData: photo,

                  );
                }).toList(),
              ),
            ),
          )
        ],
      ),  
    );
  }
}


class TravelDestinationItem extends StatefulWidget {
  
  TravelDestinationItem({Key key, @required this.prodData}): assert(prodData != null),super(key: key);

  final prodData;

      @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<TravelDestinationItem> {
  static const double height = 200.0;
    bool _favFlag = false;
    
  _likeUnlike(){
 setState(() { _favFlag = !_favFlag; });
  var placeliked = 'Removed from favourite!';
    if(_favFlag){
      placeliked = 'Added to favourite!';
    }

     Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(placeliked,textAlign: TextAlign.center,style: TextStyle(fontSize: 14.0),),
          duration: Duration(seconds:1),
            backgroundColor: Colors.black
            
    ));
}


  @override
  Widget build(BuildContext context) {

    final ThemeData theme = Theme.of(context);
    final TextStyle descriptionStyle = theme.textTheme.subhead;

       Widget hero(image,originalprice,discountedprice){

         var totaldiscount = double.parse(originalprice) - double.parse(discountedprice);
         var discountpercent = (totaldiscount/double.parse(originalprice)*100).round();


           return new Container(
        constraints: new BoxConstraints.expand(
          height: 200.0,
        ),
        padding: new EdgeInsets.only(left: 16.0, bottom: 8.0, right: 16.0),
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new NetworkImage(image),
            fit: BoxFit.cover,
          ),
        ),
        child: new Stack(
          children: <Widget>[
               discountpercent > 0 ? new InkResponse(  
                 autofocus: true,
                child: new Container(
                  width: 30,
                  height: 30,
                  decoration: new BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                  child: new Text("$discountpercent%",
                  textAlign: TextAlign.center,
                  ),
                 )
                ),
              ) : new InkResponse( ),
          
            new Positioned(
              right: 0.0,
              top: 0.0,
              child: Column(children: <Widget>[
                IconButton(
                  icon: Icon(Icons.favorite),
                  iconSize: 30,
                  color:(_favFlag) ? Colors.pink : Colors.cyanAccent,
                  tooltip: 'Add to favourite',
                  onPressed:(){
                     _likeUnlike();
                    },
                ),
              ],
            ),
            ),
          ],
        )
    );
  }

    return SafeArea(
        top: false,
        bottom: false,
        child: Container(
          padding: const EdgeInsets.all(4.0),
          //height: height,
          child: GestureDetector(
            onTap: (){
             // Navigator.push(context, MaterialPageRoute(builder: (context)=> Item_Details()));
            },


          child: Card(
            color: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
              
                // photo and title
                SizedBox(
                  height: 200.0,
                  child: Stack(
                    children: <Widget>[
                        Positioned.fill(
                         child: hero(widget.prodData.image,widget.prodData.originalprice,widget.prodData.discountedprice),
                        ),
                    ],
                  ),

                ),

          Column(
              children: [

              Padding(
                    padding: const EdgeInsets.only(bottom: 8.0,top: 8.0),
                    child: Text(
                      widget.prodData.productname.length > 15 ? widget.prodData.productname.substring(0,15)+'...' : widget.prodData.productname,
                      style: descriptionStyle.copyWith(
                          color: Colors.black87),
                    ),
                  ),


                 Container(               
                    padding: const EdgeInsets.all(2.0),
                    child: widget.prodData.originalprice != widget.prodData.discountedprice ?  DefaultTextStyle(
                      style: descriptionStyle,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:<Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 2.0),
                            child: Text('Rs.'+
                              widget.prodData.originalprice,
                              style: descriptionStyle.copyWith(
                                  color: Colors.red,
                                  decoration: TextDecoration.lineThrough,),
                            ),
                            
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 3.0),
                            child: Text('Rs.'+
                              widget.prodData.discountedprice,
                                style: descriptionStyle.copyWith(
                                  color: Colors.green),
                            ),
                          ), 
                        ] 
                      ),
                    ) : 

                      Padding(
                            padding: const EdgeInsets.only(bottom: 3.0),
                            child: Text('Rs.'+
                              widget.prodData.discountedprice,
                                style: descriptionStyle.copyWith(
                                  color: Colors.green),
                            ),
                          ),
                  ),
                ],
              ),

                Container(
                  alignment: Alignment.center,

                  child:  RaisedButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.red)),
                   onPressed: () {
                        Navigator.push(context, MaterialPageRoute(                          
                          builder: (context)=> ItemDetails(itemData:widget.prodData),),);
                      },
                    color: Colors.red,
                    textColor: Colors.white,
                    child: Text("View",
                        style: TextStyle(fontSize: 14)),
                  ),
                ),
              ],
            ),
          ),
        )
        )
    );

  }
}

class ProductShow {
  final String catid;  
  final String productname;  
  final String discountedprice;  
  final String image;  
  final String originalprice;  
  final String quantityavail;  

ProductShow({this.catid,this.productname,this.discountedprice,this.image,this.originalprice,this.quantityavail});
factory ProductShow.fromJson(Map<String, dynamic> json) {
    return new ProductShow(
          catid: json['cat_id'].toString(),
          productname: json['product_name'].toString(),
          discountedprice: json['discounted_price'].toString(),
          image: json['image'].toString(),
          originalprice: json['original_price'].toString(),
          quantityavail: json['quantity_avail'].toString()
    );
  }
}