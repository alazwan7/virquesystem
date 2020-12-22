
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'dart:convert';
import "package:virque/api.dart";
import 'package:virque/maps/maps.dart';
import 'package:virque/users.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'editProfile.dart';
import 'maps/map2.dart';

class requestPage extends StatefulWidget {
  @override
  _requestPageState createState() => _requestPageState();
}

// ignore: camel_case_types
class _requestPageState extends State<requestPage> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
//    target: LatLng(37.42796133580664, -122.085749655962),
    target: LatLng(2.144460, 102.427090),
    zoom: 14.4746,
  );


  static final CameraPosition _kBank = CameraPosition(
      bearing: 192.8334901395799,
//      target: LatLng(37.43296265331129, -122.08832357078792),
      target: LatLng(2.144460, 102.427090),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);


  var currentUser;
  @override
  void initState() {
    super.initState();
    users();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: new AppBar(
            title: new Text(
              "Request Now",
              style: new TextStyle(color: Colors.white, fontSize: 30, fontFamily: ''),
            ),
            centerTitle: true,
            backgroundColor: Colors.black,
          ),
          body: Center(
              child: Column(
                children: <Widget>[
                  Text(currentUser!=null ? currentUser.name : ""),
                  Text(currentUser!=null ? currentUser.email  : ""),
                  Text(currentUser!=null ? currentUser.fullname  : ""),
                  Text(currentUser!=null ? currentUser.phoneno  : ""),


                  FlatButton(
                    child: Text("Request Turn no.", style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: '')),
                    onPressed: () async {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (BuildContext ctx) => MapView2()));
                    },
                  ),
                  Center(
                    child: Container(
                      margin: const EdgeInsets.all(10.0),
                      color: Colors.amber[600],
                      width: 300.0,
                      height: 400.0,

                      child: Scaffold(
                        body: Stack(
                          children: <Widget>[
                            // TODO: Add Map View
                            GoogleMap(
                              mapType: MapType.hybrid,
                              initialCameraPosition: _kGooglePlex,
                              onMapCreated: (GoogleMapController controller) {
                                _controller.complete(controller);
                              },
                            ),

                            FloatingActionButton.extended(
                              onPressed: _goToTheBank,
                              label: Text('To the Bank!'),
                              icon: Icon(Icons.apartment_rounded),
                            ),
                          ],
                        ),
                      ),

                    ),
                  )
                ],
              )
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
        currentUser= Users.fromJson(values);
      });
      return user;
    }

    else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load server');
    }
  }

  Future<void> _goToTheBank() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kBank));
  }
}

