
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:virque/model/counters.dart';
import 'package:virque/model/request.dart';
import 'package:virque/model/users.dart';
import 'dart:async';
import 'dart:convert';
import 'file:///C:/Users/Asyraaf/AndroidStudioProjects/virque-master/lib/api/api.dart';
import 'package:virque/request/requirementRequest.dart';
import 'package:shared_preferences/shared_preferences.dart';


class displayVisitorStatPage extends StatefulWidget {
  @override
  displayVisitorStatPageState createState() => displayVisitorStatPageState();
}

// ignore: camel_case_types
class displayVisitorStatPageState extends State<displayVisitorStatPage> {
  Future<Request> futureRequestNo;

  var currentUser;
  var requestedUser;
  int requestno = 0;



  @override
  void initState() {
    super.initState();
    users();
    fetchhomeQueueRequestNo();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text(
            "Total Request Today",
            style: new TextStyle(
                color: Colors.white, fontSize: 30, fontFamily: ''),
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body: Container(
          decoration: new BoxDecoration(
            color: Colors.blue.withOpacity(0.25),

          ),
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Container(

              decoration: new BoxDecoration(
                  color: Colors.grey.withOpacity(0.25),
                  borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(20.0),
                    topRight: const Radius.circular(20.0),
                    bottomLeft: const Radius.circular(20.0),
                    bottomRight: const Radius.circular(20.0),
                  )
              ),
              child: Center(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          decoration: new BoxDecoration(
                              color: Colors.blue.withOpacity(0.25),
                              borderRadius: new BorderRadius.only(
                                topLeft: const Radius.circular(20.0),
                                topRight: const Radius.circular(20.0),
                                bottomLeft: const Radius.circular(20.0),
                                bottomRight: const Radius.circular(20.0),
                              )
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [

//                                    FutureBuilder<Request>(
//                                    future: futureRequestNo,
//                                    builder: (context, snapshot) {
//                                      if (snapshot.hasData) {
//                                        return Text(snapshot.data.user_id);
//                                      } else if (snapshot.hasError) {
//                                        return Text("${snapshot.error}");
//                                      }
//
//                                      // By default, show a loading spinner.
//                                      return CircularProgressIndicator();
//                                    },
//                                  ),

                                      Text("No of customer in Queue:", style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontFamily: '')),
                                      Text(
                                        "${requestno}",
                                        textAlign: TextAlign.center,
                                        style: new TextStyle(
                                            color: Colors.black,
                                            fontSize: 30,
                                            fontFamily: ''),
                                      ),
                                    ],
                                  ),
                                ),


                              ],
                            ),
                          ),
                        ),
                      ),

                      Container(
                        decoration: new BoxDecoration(
                            color: Colors.blueGrey.withOpacity(0.25),
                            borderRadius: new BorderRadius.only(
                              topLeft: const Radius.circular(10.0),
                              topRight: const Radius.circular(10.0),
                              bottomLeft: const Radius.circular(10.0),
                              bottomRight: const Radius.circular(10.0),
                            )
                        ),
                        child: FlatButton(
                          child: Text("Clear Request", style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: '')),
                          onPressed: () async {
                            futureRequestNo =
                                clearRequests();


                          },
                        ),
                      ),
                    ],
                  )
              ),
            ),
          ),
        )
      // By default, show a loading spinner.
    );
  }

  Future<Users> users() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var id = pref.getString("id");
    final response = await CallApi().getData("users/${id}");
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      Users user;
      var values = json.decode(response.body);
      print(values);

      setState(() {
        currentUser = Users.fromJson(values);

      });
      return user;
    }

    else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load server');
    }
  }

  Future<Request> fetchhomeQueueRequestNo() async {
    var response = await CallApi().getData("requests");
    print(response.statusCode);
    if (response.statusCode == 200) {

      Request request;
      var values = json.decode(response.body);
      print(values);
      print(values.length);
      int count = values.length;

      setState(() {
//        requestedUser = Request.fromJson(values);
        requestno = count;

      },
      );
      print(requestno);
      return request;

    }

    else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load server');
    }

  }

  Future<Request> clearRequests() async {
    var response = await CallApi().deleteData("requests");

    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text("Successfull"),
      content: Text("All request successfull cleared"),
      actions: [
        okButton,
      ],
    );


    AlertDialog alert2 = AlertDialog(
      title: Text("Not to Submit"),
      content: Text("Please fill the requirement and get distance first"),
      actions: [
        okButton,
      ],
    );
    if (response.statusCode == 200) {
      print("workingggg") ;

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );

    } else {
      // If the server did not return a "200 OK response",
      // then throw an exception.
      throw Exception('Failed to delete Request List.');
    }
  }
//
//  Future<Request> fetchwalkInRequestNo() async {
//    var response = await CallApi().getData("requests/walkinqueue");
//    if (response.statusCode == 200) {
//
//      Request request;
//      var values = json.decode(response.body);
//      print(values);
//      print(values.length);
//      int count = values.length;
//
//      setState(() {
//
////        requestedUser = Request.fromJson(values);
//        requestno = count;
//
//
//
//      },
//      );
//      print(requestno);
//      return request;
//
//    }
//
//    else {
//      // If the server did not return a 200 OK response,
//      // then throw an exception.
//      throw Exception('Failed to load server');
//    }
//
//  }
}