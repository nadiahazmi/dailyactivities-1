// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations

import 'package:dailyactivities/activity_models/activity_api.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<Album> futureAlbum;
  String activity_list = "";
  List<String> activities = <String>[];

  void changeData() {
    setState(() {
      futureAlbum = fetchAlbum();
    });
  }

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          TextButton(onPressed: changeData, child: Text('New Activities')),
          FutureBuilder<Album>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                activity_list = snapshot.data.activity;
                return Text(snapshot.data.activity);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
          TextButton(
              onPressed: () {
                showAlertDialog(context);
              },
              child: Text('Add to the list')),
          Expanded(
            child: ListView.builder(
                itemCount: activities.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 50,
                    margin: EdgeInsets.all(2),
                    child: Center(
                      child: Text('${activities[index]}'),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("Save"),
      onPressed: () {
        Navigator.of(context).pop();
        setState(() {
          activities.insert(0, activity_list);
        });
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Daily Activities "),
      content: Text("$activity_list"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
