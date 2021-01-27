
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virque/Customers/userprofile.dart';
import 'package:virque/api/api.dart';
import 'package:virque/model/users.dart';

import 'package:http/http.dart' as http;

import 'StaffProfile.dart';








class EditStaffPage extends StatefulWidget {
  EditStaffPage({Key key}) : super(key: key);

  @override
  _EditStaffPageState createState() => _EditStaffPageState();


}

class _EditStaffPageState extends State<EditStaffPage> {

  var currentUser;

  var items = ['Customer'];

  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  TextEditingController nameController;
  TextEditingController emailController;
  TextEditingController pwdController;
  TextEditingController confirmPwdInputController;
  TextEditingController fullnameController;
  TextEditingController icnoController;
  TextEditingController phonenoController;
  TextEditingController roleController;


  Future<Users> futureUsers;

  bool _isLoading = false;

  @override
  initState() {
    super.initState();
    nameController = new TextEditingController();
    emailController = new TextEditingController();
    pwdController = new TextEditingController();
    confirmPwdInputController = new TextEditingController();
    fullnameController = new TextEditingController();
    icnoController = new TextEditingController();
    phonenoController = new TextEditingController();
    roleController = new TextEditingController();
    getUserData();

  }

  void getUserData() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      currentUser= pref.getString("id");
    });
  }
  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Email format is invalid';
    } else {
      return null;
    }
  }

  String pwdValidator(String value) {
    if (value.length < 8) {
      return 'Password must be longer than 8 characters';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Update Details", style: TextStyle(color: Colors.white, fontSize: 30, fontFamily: '')),
          backgroundColor: Colors.black,
          leading: GestureDetector(
            onTap: () async {
              Navigator.pop(context);
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => new StaffProfile())
              );
            },
            child: Icon(
              Icons.arrow_back,  // add custom icons also
            ),
          ),
        ),
        body: Container(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
                child:
                Form(
                  key: _registerFormKey,
                  child: Column(
                    children: <Widget> [
                      TextFormField(
                        style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: ''),
                        decoration: InputDecoration(
                          labelText: 'Username*', hintText: "Ali",),
                        controller: nameController,
                        // ignore: missing_return
                        validator: (value) {
                          if (value.length < 3) {
                            return "Please enter a valid username.";
                          }
                        },
                      ),

                      TextFormField(
                        style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: ''),
                        decoration: InputDecoration(
                            labelText: 'Email*', hintText: "Ali.97@gmail.com"),
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: emailValidator,
                      ),

                      TextFormField(
                        style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: ''),
                        decoration: InputDecoration(
                            labelText: 'Password*', hintText: "********"),
                        controller: pwdController,
                        obscureText: true,
                        validator: pwdValidator,
                      ),


                      TextFormField(
                          style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: ''),
                          decoration: InputDecoration(
                              labelText: 'Full Name.*', hintText: "Muhd Ali bin XXXX"),
                          controller: fullnameController,
                          // ignore: missing_return
                          validator: (value) {
                            if (value.length < 3) {
                              return "Please enter a valid fullname.";
                            }
                          }),



                      TextFormField(
                          style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: ''),
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
                          child: Text('Submit', style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: '')),
                          color: Colors.black,
                          textColor: Colors.white,
                          onPressed: () {
                            setState(() {
                              updateUsers(nameController.text,emailController.text, pwdController.text, fullnameController.text, phonenoController.text);
                            },
                            );
                          }
                      ),

                    ],
                  ),
                )
            )
        )
    );
  }




  Future<void> updateUsers(name, email, password, fullname, phoneno) async {
    var data = {

      "name": name,
      "email": email,
      "password": password,
      "fullname": fullname,
      "phoneno": phoneno
    };

    print("users/${currentUser}");
    final response = await CallApi().updateData(data,"users/${currentUser}");
    print(response.statusCode);
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Successfull"),
      content: Text("Your data have been updated."),
      actions: [
        okButton,
      ],
    );

    AlertDialog alert2 = AlertDialog(
      title: Text("Not Successfull"),
      content: Text("Please fill the form first"),
      actions: [
        okButton,
      ],
    );

    if (response.statusCode == 200) {
      print ("is working");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert2;
        },
      );
      throw Exception('Failed to load server');

    }
  }



}
