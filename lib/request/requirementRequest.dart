
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'dart:async';
import 'dart:convert';
import "package:virque/api.dart";
import 'package:virque/maps/geolocator1.dart';
import 'package:virque/maps/map2.dart';
import 'package:virque/maps/maps.dart';
import 'package:virque/maps/secrets.dart';
import 'package:virque/users.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geocoder/geocoder.dart';

class requirementPage extends StatefulWidget {
  @override
  _requirementPageState createState() => _requirementPageState();
}

// ignore: camel_case_types
class _requirementPageState extends State<requirementPage> {

  CameraPosition _initialLocation = CameraPosition(target: LatLng(0.0, 0.0));
  GoogleMapController mapController;

  final Geolocator _geolocator = Geolocator();

  TextEditingController disableController;
  TextEditingController seniorCitizenController;


  Position _currentPosition;
  Position _destinationPosition;
  String _currentAddress;
  String _thedestinationAddress;

  final startAddressController = TextEditingController();
  final destinationAddressController = TextEditingController();

  String _startAddress = '';
  String _destinationAddress = '';
  String _placeDistance;

  Set<Marker> markers = {};

  PolylinePoints polylinePoints;
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget _textField({
    TextEditingController controller,
    String label,
    String hint,
    String initialValue,
    double width,
    Icon prefixIcon,
    Widget suffixIcon,
    Function(String) locationCallback,
  }) {
    return Container(
      width: width * 0.8,
      child: TextFormField(
        onChanged: (value) {
          locationCallback(value);
        },
        controller: controller,
        // initialValue: initialValue,
        decoration: new InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: Colors.grey[400],
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: Colors.blue[300],
              width: 2,
            ),
          ),
          contentPadding: EdgeInsets.all(15),
          hintText: hint,
        ),
      ),
    );
  }



  // Method for retrieving the current location
  _getCurrentLocation() async {
    await _geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      setState(() {
        _currentPosition = position;
        print('CURRENT POS: $_currentPosition');
        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 18.0,
            ),
          ),
        );
      });
      await _getAddress();
    }).catchError((e) {
      print(e);
    });
  }

  _getDestinationLocation() async {
    await _geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      setState(() {

        _destinationPosition = position;
        print('DESTINATION POS: $_destinationPosition');
        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(36.114704, -115.201462),
              zoom: 18.0,
            ),
          ),
        );
      });
      await _getDestinationAddress();
    }).catchError((e) {
      print(e);
    });
  }


  // Method for retrieving the address
  _getAddress() async {
    try {
      List<Placemark> p = await _geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
        "${place.name}, ${place.locality}, ${place.postalCode}, ${place.country}";
        startAddressController.text = _currentAddress;
        _startAddress = _currentAddress;
      });
    } catch (e) {
      print(e);
    }
  }

  _getDestinationAddress() async {
    try {
      List<Placemark> p = await _geolocator.placemarkFromCoordinates(34.052235, -118.243683);

      Placemark place = p[0];

      setState(() {

        _thedestinationAddress =
        "${place.name}, ${place.locality}, ${place.postalCode}, ${place.country}";
        destinationAddressController.text = _thedestinationAddress;
        _destinationAddress = _thedestinationAddress;
      });
    } catch (e) {
      print(e);
    }
  }


  // Method for calculating the distance between two places
  Future<bool> _calculateDistance() async {
    try {
      // Retrieving placemarks from addresses
      List<Placemark> startPlacemark =
      await _geolocator.placemarkFromAddress(_startAddress);
      List<Placemark> destinationPlacemark =
      await _geolocator.placemarkFromAddress(_destinationAddress);

      if (startPlacemark != null && destinationPlacemark != null) {
        // Use the retrieved coordinates of the current position,
        // instead of the address if the start position is user's
        // current position, as it results in better accuracy.
        Position startCoordinates = _startAddress == _currentAddress
            ? Position(
            latitude: _currentPosition.latitude,
            longitude: _currentPosition.longitude)
            : startPlacemark[0].position;
        Position destinationCoordinates = _destinationAddress == _thedestinationAddress
            ? Position(
            latitude: 34.052235,
            longitude:  -118.243683)
            : destinationPlacemark[0].position;

        // Start Location Marker
        Marker startMarker = Marker(
          markerId: MarkerId('$startCoordinates'),
          position: LatLng(
            startCoordinates.latitude,
            startCoordinates.longitude,
          ),
          infoWindow: InfoWindow(
            title: 'Start',
            snippet: _startAddress,
          ),
          icon: BitmapDescriptor.defaultMarker,
        );

        // Destination Location Marker
        Marker destinationMarker = Marker(
          markerId: MarkerId('$destinationCoordinates'),
          position: LatLng(
              34.052235, -118.243683
          ),
          infoWindow: InfoWindow(
            title: 'Destination',
            snippet: _destinationAddress,
          ),
          icon: BitmapDescriptor.defaultMarker,
        );

        // Adding the markers to the list
        markers.add(startMarker);
        markers.add(destinationMarker);

        print('START COORDINATES: $startCoordinates');
        print('DESTINATION COORDINATES: $destinationCoordinates');

        Position _northeastCoordinates;
        Position _southwestCoordinates;

        // Calculating to check that
        // southwest coordinate <= northeast coordinate
        if (startCoordinates.latitude <= destinationCoordinates.latitude) {
          _southwestCoordinates = startCoordinates;
          _northeastCoordinates = destinationCoordinates;
        } else {
          _southwestCoordinates = destinationCoordinates;
          _northeastCoordinates = startCoordinates;
        }

        // Accomodate the two locations within the
        // camera view of the map
        mapController.animateCamera(
          CameraUpdate.newLatLngBounds(
            LatLngBounds(
              northeast: LatLng(
                _northeastCoordinates.latitude,
                _northeastCoordinates.longitude,
              ),
              southwest: LatLng(
                _southwestCoordinates.latitude,
                _southwestCoordinates.longitude,
              ),
            ),
            100.0,
          ),
        );

        // Calculating the distance between the start and the end positions
        // with a straight path, without considering any route
        // double distanceInMeters = await Geolocator().bearingBetween(
        //   startCoordinates.latitude,
        //   startCoordinates.longitude,
        //   destinationCoordinates.latitude,
        //   destinationCoordinates.longitude,
        // );

        await _createPolylines(startCoordinates, destinationCoordinates);

        double totalDistance = 0.0;

        // Calculating the total distance by adding the distance
        // between small segments

        var distanceInMeters = await
        _geolocator.distanceBetween(_currentPosition.latitude, _currentPosition.longitude, 34.052235, -118.243683);
        print(distanceInMeters);
        setState(() {

          _placeDistance = (distanceInMeters/1000).toStringAsFixed(2);
          print('DISTANCE: $_placeDistance km');
        });

        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  // Formula for calculating distance between two coordinates
  // https://stackoverflow.com/a/54138876/11910277

  // Create the polylines for showing the route between two places
  _createPolylines(Position start, Position destination) async {
    polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      API_KEY, // Google Maps API Key
      PointLatLng(start.latitude, start.longitude),
      PointLatLng(34.052235, -118.243683),
      travelMode: TravelMode.transit,
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    PolylineId id = PolylineId('poly');
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: polylineCoordinates,
      width: 3,
    );
    polylines[id] = polyline;
  }

  var currentUser;
  @override
  void initState() {
    disableController = new TextEditingController();
    seniorCitizenController = new TextEditingController();

    super.initState();
    users();
    _getCurrentLocation();
    _getDestinationLocation();
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
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
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
                                              onSelected: (String value) =>
                                              disableController.text = value
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
                                              onSelected: (String value) =>
                                              seniorCitizenController.text = value
                                          ),
                                        ],
                                      )
                                  ),
                                ),
                              ),


                              Center(
                                child: Container(
                                  margin: const EdgeInsets.all(10.0),

                                  height: 550.0,

                                  child: Scaffold(
                                    body: Stack(
                                      children: <Widget>[
                                        // TODO: Add Map View
                                        GoogleMap(
                                          markers: markers != null ? Set<Marker>.from(markers) : null,
                                          initialCameraPosition: _initialLocation,
                                          myLocationEnabled: true,
                                          myLocationButtonEnabled: false,
                                          mapType: MapType.normal,
                                          zoomGesturesEnabled: true,
                                          zoomControlsEnabled: false,
                                          polylines: Set<Polyline>.of(polylines.values),
                                          onMapCreated: (GoogleMapController controller) {
                                            mapController = controller;
                                          },
                                        ),

                                        // Show zoom buttons
                                        SafeArea(
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 10.0),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                ClipOval(
                                                  child: Material(
                                                    color: Colors.blue[100], // button color
                                                    child: InkWell(
                                                      splashColor: Colors.blue, // inkwell color
                                                      child: SizedBox(
                                                        width: 50,
                                                        height: 50,
                                                        child: Icon(Icons.add),
                                                      ),
                                                      onTap: () {
                                                        mapController.animateCamera(
                                                          CameraUpdate.zoomIn(),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 20),
                                                ClipOval(
                                                  child: Material(
                                                    color: Colors.blue[100], // button color
                                                    child: InkWell(
                                                      splashColor: Colors.blue, // inkwell color
                                                      child: SizedBox(
                                                        width: 50,
                                                        height: 50,
                                                        child: Icon(Icons.remove),
                                                      ),
                                                      onTap: () {
                                                        mapController.animateCamera(
                                                          CameraUpdate.zoomOut(),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),

                                        SafeArea(
                                          child: Align(
                                            alignment: Alignment.topCenter,
                                            child: Padding(
                                              padding: const EdgeInsets.only(top: 10.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white70,
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(20.0),
                                                  ),
                                                ),
                                                width: width * 0.6,


                                                child: Padding(
                                                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: <Widget>[
                                                      Text(
                                                        'Places',
                                                        style: TextStyle(fontSize: 15.0),
                                                      ),
                                                      SizedBox(height: 5),
                                                      _textField(
                                                          label: 'Start',
                                                          hint: 'Choose starting point',
                                                          initialValue: _currentAddress,
                                                          prefixIcon: Icon(Icons.looks_one),
                                                          suffixIcon: IconButton(
                                                            icon: Icon(Icons.my_location),
                                                            onPressed: () {
                                                              startAddressController.text = _currentAddress;
                                                              _startAddress = _currentAddress;
                                                            },
                                                          ),
                                                          controller: startAddressController,
                                                          width: width * 0.65,
                                                          locationCallback: (String value) {
                                                            setState(() {
                                                              _startAddress = value;
                                                            });
                                                          }),
                                                      SizedBox(height: 10),
                                                      _textField(
                                                          label: 'Destination',
                                                          hint: 'Choose destination',
                                                          initialValue: '',
                                                          prefixIcon: Icon(Icons.looks_two),
                                                          suffixIcon: IconButton(
                                                            icon: Icon(Icons.my_location),
                                                            onPressed: () {
                                                              destinationAddressController.text = _thedestinationAddress;
                                                              _destinationAddress = _thedestinationAddress;
                                                            },
                                                          ),
                                                          controller: destinationAddressController,
                                                          width: width * 0.65,
                                                          locationCallback: (String value) {
                                                            setState(() {
                                                              _destinationAddress = value;
                                                            });
                                                          }),
                                                      SizedBox(height: 2),
                                                      Visibility(
                                                        visible: _placeDistance == null ? false : true,
                                                        child: Text(
                                                          'DISTANCE: $_placeDistance km',
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(height: 5),
                                                      RaisedButton(
                                                        onPressed: (_startAddress != '' &&
                                                            _destinationAddress != '')
                                                            ? () async {
                                                          setState(() {
                                                            if (markers.isNotEmpty) markers.clear();
                                                            if (polylines.isNotEmpty)
                                                              polylines.clear();
                                                            if (polylineCoordinates.isNotEmpty)
                                                              polylineCoordinates.clear();
                                                            _placeDistance = null;
                                                          });

                                                          _calculateDistance().then((isCalculated) {
                                                            if (isCalculated) {
                                                              _scaffoldKey.currentState.showSnackBar(
                                                                SnackBar(
                                                                  content: Text(
                                                                      'Distance Calculated Sucessfully'),
                                                                ),
                                                              );
                                                            } else {
                                                              _scaffoldKey.currentState.showSnackBar(
                                                                SnackBar(
                                                                  content: Text(
                                                                      'Error Calculating Distance'),
                                                                ),
                                                              );
                                                            }
                                                          });
                                                        }
                                                            : null,
                                                        color: Colors.red,
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(20.0),
                                                        ),
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: Text(
                                                            'Show Route'.toUpperCase(),
                                                            style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 20.0,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),

                                        SafeArea(
                                          child: Align(
                                            alignment: Alignment.bottomRight,
                                            child: Padding(
                                              padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                mainAxisSize: MainAxisSize.max,
                                                children: <Widget>[
                                                  ClipOval(
                                                    child: Material(
                                                      color: Colors.orange[100], // button color
                                                      child: InkWell(
                                                        splashColor: Colors.orange, // inkwell color
                                                        child: SizedBox(
                                                          width: 56,
                                                          height: 56,
                                                          child: Icon(Icons.my_location),
                                                        ),
                                                        onTap: () {
                                                          mapController.animateCamera(
                                                            CameraUpdate.newCameraPosition(
                                                              CameraPosition(
                                                                target: LatLng(
                                                                  _currentPosition.latitude,
                                                                  _currentPosition.longitude,
                                                                ),
                                                                zoom: 18.0,
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
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
                                    child: Text("Next", style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: '')),
                                    onPressed: () async {
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (BuildContext ctx) => requestPage4()));
                                    },
                                  ),
                                ),
                              ),
                            ],
                          )

                      )
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

