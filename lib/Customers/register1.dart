
import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:virque/api/api.dart';
import 'package:virque/model/users.dart';
import '../loadingScreen.dart';
import 'loginCustomer.dart';









class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();

}

class _RegisterPageState extends State<RegisterPage> {

  bool dataFilled= false;

  String role = 'Customer';


  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  TextEditingController nameController;

  TextEditingController emailController;
  TextEditingController pwdController;
  TextEditingController confirmPwdInputController;
  TextEditingController fullnameController;
  TextEditingController icnoController;
  TextEditingController phonenoController;



  Future<Users> futureUsers;

  bool _isLoading = false;
  var pr;
  @override
  initState() {
    nameController = new TextEditingController();
    emailController = new TextEditingController();
    pwdController = new TextEditingController();
    confirmPwdInputController = new TextEditingController();
    fullnameController = new TextEditingController();
    icnoController = new TextEditingController();
    phonenoController = new TextEditingController();

    super.initState();
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

  String confirmpwdValidator(String value) {
    if (value.length < 8) {
      return 'Password must be longer than 8 characters';
    }  else if(value != pwdController.text)
      return 'Not Match';
          else{
    return null;
          }
  }


  @override
  Widget build(BuildContext context) {
    pr = ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: true, showLogs: true);
    pr.style(
        message: 'Successfull created!!',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: LoadingScreen(),
        elevation: 20.0,
        insetAnimCurve: Curves.elasticOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400,fontFamily: "Muli"),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600, fontFamily: "Muli")
    );
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Register", style: TextStyle(color: Colors.white, fontSize: 30, fontFamily: '')),

          backgroundColor: Colors.black,
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
                            labelText: 'Username*', hintText: "Ali"),

                        controller: nameController,
                        // ignore: missing_return

                        onChanged: (value){
                          setState(() {
                            if(nameController.text!="" &&
                                emailController.text!="" &&
                                pwdController.text!="" &&
                                fullnameController.text!="" &&
                                icnoController.text!="" &&
                                phonenoController.text!="" &&
                            role!="" ){
                              dataFilled = true;
                            }
                            else{
                              dataFilled = false;
                            }
                          });
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please fill the form.";
                          }
                        },
                      ),

                      TextFormField(
                          style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: ''),

                        decoration: InputDecoration(
                            labelText: 'Email*', hintText: "Ali.97@gmail.com"),
                        controller: emailController,
                        onChanged: (value){
                          setState(() {
                            if(nameController.text!="" &&
                                emailController.text!="" &&
                                pwdController.text!="" &&
                                fullnameController.text!="" &&
                                icnoController.text!="" &&
                                phonenoController.text!="" &&
                                role!="" ){
                              dataFilled = true;
                            }
                            else{
                              dataFilled = false;
                            }
                          });
                        },

                        keyboardType: TextInputType.emailAddress,
                        validator: emailValidator,
                      ),

                      TextFormField(
                          style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: ''),
                        decoration: InputDecoration(
                            labelText: 'Password*', hintText: "********"),
                        controller: pwdController,
                        onChanged: (value){
                          setState(() {
                            if(nameController.text!="" &&
                                emailController.text!="" &&
                                pwdController.text!="" &&
                                fullnameController.text!="" &&
                                icnoController.text!="" &&
                                phonenoController.text!="" &&
                                role!="" ){
                              dataFilled = true;
                            }
                            else{
                              dataFilled = false;
                            }
                          });
                        },

                        obscureText: true,
                        validator: pwdValidator,
                      ),
//
                      TextFormField(
                          style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: ''),

                        decoration: InputDecoration(
                            labelText: 'Confirm Password*', hintText: "********"),
                        controller: confirmPwdInputController,
                        obscureText: true,
                        validator: confirmpwdValidator,
                      ),

                      TextFormField(
                          style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: ''),
                          decoration: InputDecoration(
                              labelText: 'Full Name.*', hintText: "Muhd Ali bin XXXX"),
                          controller: fullnameController,

                          onChanged: (value){
                            setState(() {
                              if(nameController.text!="" &&
                                  emailController.text!="" &&
                                  pwdController.text!="" &&
                                  fullnameController.text!="" &&
                                  icnoController.text!="" &&
                                  phonenoController.text!="" &&
                                  role!="" ){
                                dataFilled = true;
                              }
                              else{
                                dataFilled = false;
                              }
                            });
                          },
                          // ignore: missing_return
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please fill the form.";
                            }
                          }),

                      TextFormField(
                          style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: ''),
                          decoration: InputDecoration(
                              labelText: 'NRIC No.*', hintText: "97060503XXXX"),
                          controller: icnoController,
                          onChanged: (value){
                            setState(() {
                              if(nameController.text!="" &&
                                  emailController.text!="" &&
                                  pwdController.text!="" &&
                                  fullnameController.text!="" &&
                                  icnoController.text!="" &&
                                  phonenoController.text!="" &&
                                  role!="" ){
                                dataFilled = true;
                              }
                              else{
                                dataFilled = false;
                              }
                            });
                          },
                          // ignore: missing_return
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please fill the form.";
                            }
                          }),

                      TextFormField(
                          style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: ''),
                          decoration: InputDecoration(
                              labelText: 'Phoneno*', hintText: "0129507041"),
                          controller: phonenoController,
                          onChanged: (value){
                            setState(() {
                              if(nameController.text!="" &&
                                  emailController.text!="" &&
                                  pwdController.text!="" &&
                                  fullnameController.text!="" &&
                                  icnoController.text!="" &&
                                  phonenoController.text!="" &&
                                  role!="" ){
                                dataFilled = true;
                              }
                              else{
                                dataFilled = false;
                              }
                            });
                          },
                          // ignore: missing_return
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please enter a valid phoneno.";
                            }
                          }),


                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text("Role", style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: '')),
                            DropdownButton<String>(
                              value: role,
                              iconSize: 24,
                              elevation: 16,
                              style: TextStyle(color: Colors.deepPurple),
                              underline: Container(
                                height: 2,
                                color: Colors.deepPurpleAccent,
                              ),
                              onChanged: (String Value) {
                                setState(() {
                                  role = Value;
                                });
                              },
                              items: <String>['Customer']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),

                          ],
                        ),
                      ),


                      RaisedButton(
                        child: Text('Create account', style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: '')),
                        color: Colors.black,
                        textColor: Colors.white,
                          onPressed: dataFilled==true ? () async{
                            setState(() {
                              _isLoading = true;
                              if (_registerFormKey.currentState.validate()) {

                                  pr.show();

                                  futureUsers = createUsers(
                                      nameController.text,
                                      emailController.text,
                                      pwdController.text,
                                      fullnameController.text,
                                      icnoController.text,
                                      phonenoController.text,
                                      role
                                  );
                                }


                            }
                            );
                          } : null,
                      ),
                      Text("Already have an account?", style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: '')),
                      FlatButton(
                        child: Text("Login here!", style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: '')),
                        onPressed: () {
                          Navigator.pop(
                              context,
                              MaterialPageRoute(
                                  builder: (context){
                                    return LoginCustomerPage();
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

  Future<Users> createUsers(String name, email, password, fullname, icno, phoneno, role) async {



    var data={
      'name': name,
      'email' : email,
      'password' : password,
      'fullname': fullname,
      'icno' : icno,
      'phoneno' : phoneno,
      'role' : role,
    };
    var response  = await CallApi().postData(data,"users");
    print(response.statusCode);


    if (response.statusCode == 201) {

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LoginCustomerPage()),
      );
      print("workingggg") ; } else {
      throw Exception('Failed to create User');
    }
  }
}



