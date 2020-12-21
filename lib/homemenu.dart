import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virque/register1.dart';
import 'package:virque/requestpage.dart';
import 'package:virque/userdashboard.dart';




class HomeScreen extends StatefulWidget {

  @override
  homeScreenState createState() => homeScreenState();
}

// ignore: camel_case_types
class homeScreenState extends State<HomeScreen> {

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
              child: Text('Request Ticket No.', style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: '')),
              color: Colors.grey,

              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)
              ),
              onPressed: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context){
                          return requestPage();
                        }
                    )
                )
              }
          ),
        ),
      );

      final buttonDisplay = Padding(

        padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
        child: ButtonTheme(
          height: 56,
          child: RaisedButton(
              child: Text('Display Ticket No.', style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: '')),
              color: Colors.grey,

              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)
              ),
              onPressed: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context){
                          return RegisterPage();
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
              color: Colors.grey,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)
              ),
              onPressed: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context){
                          return RegisterPage();
                        }
                    )
                )
              }
          ),
        ),
      );

      final buttonNoti = Padding(
        padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
        child: ButtonTheme(
          height: 56,
          child: RaisedButton(
              child: Text('Notification', style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: '')),
              color: Colors.grey,

              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)
              ),
              onPressed: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context){
                          return RegisterPage();
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
              backgroundColor: Colors.grey,

              leading: GestureDetector(
                onTap: () async {
                  // SharedPreferences prefs = await SharedPreferences.getInstance();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (BuildContext ctx) => DashBoard()));
                },
                child: Icon(
                  Icons.menu,  // add custom icons also
                ),
              ),
            ),



          body: Center(
            child: ListView(

            shrinkWrap: false,
            // padding: EdgeInsets.symmetric(horizontal: 20),
            children: <Widget>[
              DrawerHeader(

                  decoration: BoxDecoration(
                    color: Colors.grey,

                  ),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Material(
                          borderRadius: BorderRadius.all(Radius.circular(70.0)),
                          elevation: 10,
                          child: Padding(padding: EdgeInsets.all(8.0),
                            child: Image.asset("assets/images/skull.png", height: 90, width: 90),
                          ),
                        ),
                        Text('Virque', style: TextStyle(color: Colors.white, fontSize: 25.0, fontFamily: ''),)
                      ],
                    ),
                  )

              ),



              buttonRequest,
              buttonDisplay,
              buttonStat,
              buttonNoti



            ],
          ),
          ),

          ),
      );
    }
  }


