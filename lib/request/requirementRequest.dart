
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'finalRequest.dart';

class requirementPage extends StatefulWidget {
  @override
  _requirementPageState createState() => _requirementPageState();
}

// ignore: camel_case_types
class _requirementPageState extends State<requirementPage> {

  GoogleMapController mapController;

  TextEditingController seniorCitizenController;
  TextEditingController disableController;

  void _sendDataToRequestPage(BuildContext context) {
    String textToSend1 = seniorCitizenController.text;
    String textToSend2 = disableController.text;

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => finalRequestPage(text1: textToSend1, text2: textToSend2),
        ));
  }

  final startAddressController = TextEditingController();
  final destinationAddressController = TextEditingController();


  Set<Marker> markers = {};

  PolylinePoints polylinePoints;
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  var currentUser;
  @override
  void initState() {
    disableController = new TextEditingController();
    seniorCitizenController = new TextEditingController();

    super.initState();
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
                                  _sendDataToRequestPage(context);
                                },
                              ),
                            ),
                          ),
                        ],
                      )

                  )
              ),
            )
          // By default, show a loading spinner.
        )
    );

  }

}


