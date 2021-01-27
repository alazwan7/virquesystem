import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virque/Customers/userprofile.dart';
import '../home.dart';
import 'HomeMenuStaff.dart';
import 'StaffProfile.dart';
import 'loginStaff.dart';




class StaffDashBoard extends StatefulWidget {

  StaffDashBoard({Key key , this.title}) : super(key : key);
  final String title;

  @override
  StaffDashBoardState createState() => StaffDashBoardState();
}

class StaffDashBoardState extends State<StaffDashBoard> {



  Widget build (BuildContext ctxt) {
    return SafeArea(
      child: new Drawer(
        child: Container(
          decoration: new BoxDecoration(
            color: Colors.greenAccent.withOpacity(0.25),

          ),
          child: ListView(
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

                        Text('Virque Staff', style: TextStyle(color: Colors.white, fontSize: 25.0, fontFamily: ''),)

                      ],
                    ),
                  )),
              CustomListTile(Icons.menu_book, 'Menu', ()=>{
                Navigator.pop(ctxt),
                Navigator.push(ctxt,
                    new MaterialPageRoute(builder: (ctxt) => new HomeScreenStaff())
                )
              }),
              CustomListTile(Icons.person, 'Profile', ()=>{
                Navigator.pop(ctxt),
                Navigator.push(ctxt,

                    new MaterialPageRoute(builder: (ctxt) => new StaffProfile())
                )
              }),


              CustomListTile(Icons.logout, 'Log Out', () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs?.clear();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(
                        builder: (BuildContext ctx) => LoginStaffPage()));
              }
              )


            ],

          ),
        ),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget{

  final IconData icon;
  final  String text;
  final Function onTap;

  CustomListTile(this.icon, this.text, this.onTap);
  @override
  Widget build(BuildContext context){
    //ToDO
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child:Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey.shade400))
        ),
        child: InkWell(
            splashColor: Colors.orangeAccent,
            onTap: onTap,
            child: Container(
                height: 40,
                child: Row(
                  mainAxisAlignment : MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(children: <Widget>[
                      Icon(icon),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                      ),

                      Text(text, style: TextStyle(fontFamily: '',
                          fontSize: 16
                      ),),
                    ],),
                    // Icon(Icons.arrow_right)

                    Icon(Icons.arrow_right)

                  ],)
            )
        ),
      ),
    );
  }
}