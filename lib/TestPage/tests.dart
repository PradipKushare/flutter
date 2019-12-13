import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flamedemo/TestPage/photo.dart';

import 'package:http/http.dart' as http;

class TestView extends StatefulWidget {
  @override
  _MainFetchDataState createState() => _MainFetchDataState();
}

class _MainFetchDataState extends State<TestView> {
  List<Photo> list = List();
  var isLoading = false;

  _fetchData() async {
    setState(() {
      isLoading = true;
    });
    final response =
        await http.get("https://jsonplaceholder.typicode.com/users");
    if (response.statusCode == 200) {
      list = (json.decode(response.body) as List)
          .map((data) => new Photo.fromJson(data))
          .toList();
      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load photos');
    }
  }

  @override
    void initState() {
      _fetchData();
    }

  Widget build(BuildContext context) {
    return Scaffold(

        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  
                      return
                        new Card(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                leading: Text('${list[index].id}.'),
                                title: Text(list[index].email),
                                subtitle: Text(list[index].name),
                              ),
                              ]));

                })
                );
  }
}