
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:virque/api.dart';
import 'package:virque/userdashboard.dart';

import 'package:virque/users.dart';
import 'package:http/http.dart' as http;
import 'loginCustomer.dart';





Future<Users> createInfo(String fullname, icno, phoneno) async {

  var data={
    'fullname': fullname,
    'icno' : icno,
    'phoneno' : phoneno,
  };
  var response  = await CallApi().postData(data,"users");
  print(response.statusCode);

  if (response.statusCode == 201) {
    print("workingggg") ; } else {
    throw Exception('Failed to create User');
  }
}


class AddInfoPage extends StatefulWidget {
  AddInfoPage({Key key}) : super(key: key);

  @override
  _AddInfoPageState createState() => _AddInfoPageState();

}

class _AddInfoPageState extends State<AddInfoPage> {


  var items = ['Customer'];

  final GlobalKey<FormState> _infoFormKey = GlobalKey<FormState>();
  TextEditingController fullnameController;
  TextEditingController icnoController;
  TextEditingController phonenoController;


  Future<Users> futureUsers;

  bool _isLoading = false;

  @override
  initState() {
    fullnameController = new TextEditingController();
    icnoController = new TextEditingController();
    phonenoController = new TextEditingController();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Additional Information", style: TextStyle(color: Colors.white, fontSize: 30, fontFamily: '')),
          backgroundColor: Colors.black,
        ),
        body: Container(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
                child:
                Form(
                  key: _infoFormKey,
                  child: Column(
                    children: <Widget> [
                      TextFormField(
                        style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'Nuevo'),
                        decoration: InputDecoration(
                          labelText: 'Full Name*', hintText: "Muhammad Ali bin XXX",),
                        controller: fullnameController,
                        // ignore: missing_return
                        validator: (value) {
                          if (value.length < 3) {
                            return "Please enter a valid first name.";
                          }
                        },
                      ),
                     TextFormField(
                         style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'Nuevo'),
                         decoration: InputDecoration(
                             labelText: 'NRIC No.*', hintText: "97060503XXXX"),
                         controller: icnoController,
                         // ignore: missing_return
                         validator: (value) {
                           if (value.length < 3) {
                             return "Please enter a valid last name.";
                           }
                         }),


                     TextFormField(
                         style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'Nuevo'),
                         decoration: InputDecoration(
                             labelText: 'Phoneno*', hintText: "0129507041"),
                         controller: phonenoController,
                         // ignore: missing_return
                         validator: (value) {
                           if (value.length < 3) {
                             return "Please enter a valid phoneno.";
                           }
                         }),


                      RaisedButton(
                          child: Text(_isLoading ? 'Creating...' : 'Create account', style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'Nuevo')),
                          color: Colors.black,
                          textColor: Colors.white,
                          onPressed:_isLoading ? null: () {
                            setState(() { _isLoading = true;
                            _isLoading = false;
                            futureUsers = createInfo(fullnameController.text,icnoController.text,phonenoController.text);


                            }
                            );
                          }
                      ),

                      FlatButton(
                        child: Text("Skip", style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'Nuevo')),
                        onPressed: () {
                          Navigator.pop(
                              context,
                              MaterialPageRoute(
                                  builder: (context){
                                    return DashBoard();
                                  }
                              )
                          );
                        },
                      )
                    ],
                  ),
                )
            )
        )
    );
  }
}
