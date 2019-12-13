import 'dart:convert';
import 'package:flamedemo/shopping/titlepage.dart';
import 'package:flutter/material.dart';
import 'package:flamedemo/screens/login_screen.dart';
import 'package:flamedemo/Register/tmp_register.dart';
import 'package:flamedemo/Home/home.dart';
import 'package:flamedemo/TestPage/tests.dart';
import 'package:flamedemo/TestPage/camera_demo.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import 'package:flamedemo/constants.dart';

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class DrawerPage extends StatefulWidget {
  final drawerItems = [
    new DrawerItem("Dashboard", Icons.home),
    new DrawerItem("Tests", Icons.filter_vintage),

    new DrawerItem("Register", Icons.import_export),
    new DrawerItem("Login", Icons.autorenew),
    new DrawerItem("Camera", Icons.autorenew), 
    new DrawerItem("Shopping", Icons.shopping_basket),    

  ];


  @override
  State<StatefulWidget> createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<DrawerPage> {
  String profile_pic = 'assets/images/logo.png';
  String image_url = 'http://127.0.0.1:8887/';

    @override
    void initState() {
    super.initState();
    // _getProfile();

  }

  int _selectedDrawerIndex = 0;

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new HomeView();
      case 1:
        return new TestView();
      case 2:
        return new RegisterView();
      case 3:
        return new LoginScreen();
      case 4:
        return new CameraScreen();
       case 5:
        return new HomeScreen();
        
        
      default:
        return new Text("Error");
    }
  }
  
  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }

  @override
  void dipose(){
    super.dispose();
}

  @override
  Widget build(BuildContext context) {
    List<Widget> drawerOptions = [];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(
        new ListTile(
          leading: new Icon(d.icon),
          title: new Text(d.title),
          selected: i == _selectedDrawerIndex,
          onTap: () => _onSelectItem(i),
        )
      );
    }

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.drawerItems[_selectedDrawerIndex].title),
      ),
      drawer: new Drawer(
        
        child: new Column(
          children: <Widget>[
            // new FutureBuilder<Quote>(
            //     future: _getProfile(), //sets the getQuote method as the expected Future
            // builder: (context, snapshot) {
            //   if (snapshot.hasData) { 
            //       return UserAccountsDrawerHeader(
            //         decoration: BoxDecoration(color: Colors.amberAccent),
            //         margin: EdgeInsets.only(bottom: 40.0),   
                                                     
            //         currentAccountPicture: new CircleAvatar(
            //           radius: 50.0,
            //           backgroundColor: const Color(0xFF778899),
                      
            //           child: new GestureDetector(
            //             onTap: () {
            //               Navigator.push(
            //                   context,
            //                   MaterialPageRoute(builder: (context) => CameraScreen()),
            //                 ); 
            //             },
            //             child: new Image.asset(
            //                 'assets/images/'+snapshot.data.profilepic,
            //                     width: MediaQuery.of(context).size.width,
                               
            //                   ),
            //               ),
            //             ),
            //         accountName: new Container(
            //             child: Text(
            //           "${snapshot.data.mobileno}",
            //           style: TextStyle(color: Colors.black),
            //         )),
            //         accountEmail: new Container(
            //             child: Text(
            //           'contact@softflame.in',
            //             style: TextStyle(color: Colors.black),
            //           )),
            //         );
            //        }else if (snapshot.hasError) { //checks if the response throws an error
            //           return Text("${snapshot.error}");
            //         }
            //             return  new Image.asset(
            //                 'assets/images/logo.png',
            //                   );
            //         //return CircularProgressIndicator();
            //       },
            //     ),



                   UserAccountsDrawerHeader(
                    decoration: BoxDecoration(color: Colors.amberAccent),
                    margin: EdgeInsets.only(bottom: 40.0),   
                                                     
                    currentAccountPicture: new CircleAvatar(
                      radius: 50.0,
                      backgroundColor: const Color(0xFF778899),
                      
                      child: new GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => CameraScreen()),
                            ); 
                        },
                        child: new Image.asset(
                            'assets/images/logo.png',
                                width: MediaQuery.of(context).size.width,
                               
                              ),
                          ),
                        ),
                    accountName: new Container(
                        child: Text(
                      "8055576553",
                      style: TextStyle(color: Colors.black),
                    )),
                    accountEmail: new Container(
                        child: Text(
                      'contact@softflame.in',
                        style: TextStyle(color: Colors.black),
                      )),
                    ),
                  


            new Column(children: drawerOptions)
          ],
        ),
      ),
      body: _getDrawerItemWidget(_selectedDrawerIndex),
    );
  }

  Future<Quote>_getProfile() async {
  try {
    Dio dio = new Dio();
        Map postdata = {'user_id':Constants.UserId};
         print(postdata);
         var response = await dio.post(Constants.ApiURL+'get_profile_pics', data: postdata);
         var data = json.decode(response.toString());
       
       if(data["success"]){
          return Quote.fromJson(json.decode(response.toString()));

      }else{
        //throw Exception('Failed to load post');
        var dispmsg = data["msg"];
                Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(dispmsg,textAlign: TextAlign.center,style: TextStyle(fontSize: 14.0),),
                      duration: Duration(seconds:3),
                       backgroundColor: Colors.redAccent
              ));
         }    
      } catch (e) {
          print(e);
    }
  }
}

class Quote {
  final String profilepic;
  final String mobileno;

  Quote({this.profilepic, this.mobileno});

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
        profilepic: json['profile_pic'],
        mobileno: json['mobile_no']);
  }
}
