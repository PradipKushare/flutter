import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:flamedemo/constants.dart';

import '../drawerList.dart';

class PreviewImageScreen extends StatefulWidget {
  final String imagePath;

  PreviewImageScreen({this.imagePath});

  @override
  _PreviewImageScreenState createState() => _PreviewImageScreenState();
}

class _PreviewImageScreenState extends State<PreviewImageScreen> {
  GlobalKey<ScaffoldState> _cameraKey = new GlobalObjectKey<ScaffoldState>('');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preview'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
                flex: 2,
                child: Image.file(File(widget.imagePath), fit: BoxFit.cover)),
            SizedBox(height: 10.0),
            Flexible(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(60.0),
                child: RaisedButton(
                  onPressed: () {
                    getBytesFromFile(context);
                  },
                  child: Text('Upload Picture'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<FormData> _postPics() async {
  return  FormData.fromMap({
            "user_id": Constants.UserId,
            "profile_pic":widget.imagePath,
          });
}

   getBytesFromFile(BuildContext context) async {
       try {
       //Dialogs.showLoadingDialog(context, _cameraKey);//invoking login
        Dio dio = new Dio();
      var response = await dio.post(Constants.ApiURL+'update_profile_pics',
                           data: await _postPics());
      var data = json.decode(response.toString());
       if(data["success"]){
        Navigator.of(_cameraKey.currentContext,rootNavigator: true).pop();
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DrawerPage()),
            ); 
      }else{
        Navigator.of(_cameraKey.currentContext,rootNavigator: true).pop();
        var dispmsg = data["msg"];
                Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(dispmsg,textAlign: TextAlign.center,style: TextStyle(fontSize: 14.0),),
                      duration: Duration(seconds:3),
                       backgroundColor: Colors.redAccent
              ));
         }    
       } catch (error) {
          print(error);
      } 
  }

}
