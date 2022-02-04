import 'package:dailyactivities/activity_models/activity_api.dart';
import 'package:flutter/material.dart';
import 'package:dailyactivities/main.dart';
import 'package:flutter/cupertino.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Album> futureAlbum;
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
          SizedBox(
            height: 30,
          ),
          Text(
            'what should i do today?',
            style: TextStyle(
                color: Colors.lightBlue.shade700,
                fontFamily: 'Jua-Regular',
                fontSize: 40),
          ),
          SizedBox(
            height: 20,
          ),
          RaisedButton(
              onPressed: changeData,
              child: Text(
                'New Activities',
                style: TextStyle(fontSize: 15),
              ),
              color: Colors.yellow),
          SizedBox(
            height: 20,
          ),
          FutureBuilder<Album>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                activity_list = snapshot.data!.activity;
                return Text(snapshot.data!.activity,
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Jua-Regular',
                        fontSize: 20));
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
          SizedBox(
            height: 30,
          ),
          RaisedButton(
              onPressed: () {
                showAlertDialog(context);
              },
              child: Text(
                'Add to the list',
                style: TextStyle(fontSize: 15),
              ),
              color: Colors.yellow),
          Expanded(
            child: ListView.builder(
                itemCount: activities.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 50,
                    margin: EdgeInsets.all(2),
                    child: Center(
                      child: Text('${activities[index]}',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Jua-Regular',
                              fontSize: 20)),
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
