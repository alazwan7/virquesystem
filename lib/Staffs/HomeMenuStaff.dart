import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virque/Customers/register1.dart';
import 'package:virque/Customers/userdashboard.dart';
import 'package:virque/Staffs/staffdashboard.dart';
import 'package:virque/request/requestpage.dart';

import 'displayStat.dart';
import 'manageCounter.dart';




class HomeScreenStaff extends StatefulWidget {

  @override
  homeScreenStaffState createState() => homeScreenStaffState();
}

// ignore: camel_case_types
class homeScreenStaffState extends State<HomeScreenStaff> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    final buttonRequest = Padding(

      padding: EdgeInsets.only(bottom: 20, top: 50, left: 20, right: 20),
      child: ButtonTheme(
        height: 56,
        child: RaisedButton(
            child: Text('Manage Counter', style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: '')),
            color: Colors.black,

            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50)
            ),
            onPressed: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context){
                        return manageCounter();
                      }
                  )
              )
            }
        ),
      ),
    );

    final buttonStat = Padding(

      padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
      child: ButtonTheme(
        height: 56,
        child: RaisedButton(
            child: Text('Visitor Stat Today', style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: '')),
            color: Colors.black,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50)
            ),
            onPressed: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context){
                        return displayVisitorStatPage();
                      }
                  )
              )
            }
        ),
      ),
    );


    return SafeArea(
      child: Scaffold(

        appBar: AppBar(
          centerTitle: true,

          title: Text("Home Menu", style: TextStyle(color: Colors.white, fontSize: 30, fontFamily: '')),
          backgroundColor: Colors.black,

          leading: GestureDetector(
            onTap: () async {
              // SharedPreferences prefs = await SharedPreferences.getInstance();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (BuildContext ctx) => StaffDashBoard()));
            },
            child: Icon(
              Icons.menu,  // add custom icons also
            ),
          ),
        ),



        body: Container(
          decoration: new BoxDecoration(
              color: Colors.greenAccent.withOpacity(0.25),
              borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(20.0),
                topRight: const Radius.circular(20.0),
                bottomLeft: const Radius.circular(20.0),
                bottomRight: const Radius.circular(20.0),
              )
          ),
          child: Center(
            child: ListView(

              shrinkWrap: false,
              // padding: EdgeInsets.symmetric(horizontal: 20),
              children: <Widget>[
                DrawerHeader(

                    decoration: BoxDecoration(
                      color: Colors.black,

                    ),
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Material(
                            borderRadius: BorderRadius.all(Radius.circular(100.0)),
                            elevation: 10,
                            child: Padding(padding: EdgeInsets.all(8.0),
                              child: Image.asset("assets/images/viqueLogo.png", height: 90, width: 90),
                            ),
                          ),
                          Text('Virque', style: TextStyle(color: Colors.white, fontSize: 25.0, fontFamily: ''),)
                        ],
                      ),
                    )

                ),



                buttonRequest,
                buttonStat,




              ],
            ),
          ),
        ),

      ),
    );
  }
}


