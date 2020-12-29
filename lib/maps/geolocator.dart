
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'dart:async';
import 'dart:convert';
import "package:virque/api.dart";
import 'package:virque/maps/map2.dart';
import 'package:virque/maps/maps.dart';
import 'package:virque/maps/secrets.dart';
import 'package:virque/users.dart';
import 'package:shared_preferences/shared_preferences.dart';

class requestPage3 extends StatefulWidget {
  @override
  _requestPageState createState() => _requestPageState();
}

// ignore: camel_case_types
class _requestPageState extends State<requestPage3> {


  GoogleMapController mapController;



  final startAddressController = TextEditingController();
  final destinationAddressController = TextEditingController();



  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  var currentUser;
  @override
  void initState() {
    super.initState();
    users();

  }


  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
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
            child: SingleChildScrollView(
                child: Container(
                  decoration: new BoxDecoration(
                    color: Colors.blue.withOpacity(0.25),

                  ),


                  //Container Yg Ada smua wiget
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: new Container(
                        decoration: new BoxDecoration(
                            color: Colors.grey.withOpacity(0.25),
                            borderRadius: new BorderRadius.only(
                              topLeft: const Radius.circular(20.0),
                              topRight: const Radius.circular(20.0),
                              bottomLeft: const Radius.circular(20.0),
                              bottomRight: const Radius.circular(20.0),
                            )
                        ),



                        child: new Center(
                            child: Column(

                              children: <Widget>[

                                //User Disability
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
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          children: [
                                            Text('Are you disable person?',
                                              style: TextStyle(fontSize: 15), textAlign: TextAlign.center,
                                            ),
                                            RadioButtonGroup(
                                                labels: <String>[
                                                  "Yes",
                                                  "No",
                                                ],
                                                onSelected: (String selected) => print(selected)
                                            ),
                                          ],
                                        )
                                    ),
                                  ),
                                ),

                                //Senior Citizen
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
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          children: [
                                            Text('Are you senior citizen? (60 years old and above)',
                                              style: TextStyle(fontSize: 15), textAlign: TextAlign.center,
                                            ),
                                            RadioButtonGroup(
                                                labels: <String>[
                                                  "Yes",
                                                  "No",
                                                ],
                                                onSelected: (String selected) => print(selected)
                                            ),
                                          ],
                                        )
                                    ),
                                  ),
                                ),


                                Center(
                                  child: Container(
                                    margin: const EdgeInsets.all(10.0),
                                    color: Colors.amber[600],
                                    width: 300.0,
                                    height: 350.0,

                                    child: Scaffold(
                                      body: Stack(
                                        children: <Widget>[
                                          // TODO: Add Map View
                                      GoogleMap(
                                      mapType: MapType.normal,
                                        initialCameraPosition: _kGooglePlex,
                                        onMapCreated: (GoogleMapController controller) {
                                          _controller.complete(controller);
                                        },
                                      ),
                                      FloatingActionButton.extended(
                                        onPressed: _goToTheLake,
                                        label: Text('To the Bank!'),
                                        icon: Icon(Icons.directions_boat),
                                      ),


                                        ],
                                      ),
                                    ),

                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
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
                                      child: Text("Submit", style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: '')),
                                      onPressed: () async {
//                    Navigator.pushReplacement(context,
//                        MaterialPageRoute(builder: (BuildContext ctx) => MapView2()));
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            )

                        )
                    ),
                  ),

                )
            )
          // By default, show a loading spinner.
        )
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

}

