import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virque/Customers/register1.dart';
import 'package:virque/Customers/userdashboard.dart';
import 'package:virque/model/users.dart';


import '../home.dart';
import '../loadingScreen.dart';





SharedPreferences localStorage;

class LoginCustomerPage extends StatefulWidget {

  @override
  _LoginCustomerPageState createState() => _LoginCustomerPageState();
}
class _LoginCustomerPageState extends State<LoginCustomerPage> {


  //Gettting the JwtToken object and making the instance of it

  Future<Users> futureJwt;
var pr;

  final TextEditingController emailController = new TextEditingController();

  //Getting the password from the textField
  final TextEditingController pwdController = new TextEditingController();
  final TextEditingController roleController = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    pr = ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: true, showLogs: true);
    pr.style(
        message: 'Loading....',
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

    final home = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Container(
            child: Text(
              'Customer Login',
              style: TextStyle(fontSize: 30.0, fontFamily: ''),
            ),
          ),

          Container(
              width: 70,
              child: FlatButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) {
                            return WelcomePage();
                          }
                      )
                  );
                },
                child: Row(
                  children: [
                    Icon(Icons.home_outlined,
                        color: Colors.black,
                        size: 30),

                  ],
                ),
              )
          ),


        ],
      ),
    );




    final logo = Padding(
      padding: EdgeInsets.all(20),
      child: Hero(
          tag: 'hero',
          child: CircleAvatar(
            radius: 56.0,
            child: Image.asset('assets/images/viqueLogo.png'),
          )
      ),
    );
    final inputEmail = Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: TextField(

        style: TextStyle(fontFamily: ''),


        keyboardType: TextInputType.emailAddress,
        controller: emailController,
        decoration: InputDecoration(
            hintText: 'Email',
            contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50.0)
            )
        ),
      ),
    );
    final inputPassword = Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: TextField(
        style: TextStyle(fontFamily: ''),


        keyboardType: TextInputType.visiblePassword,
        controller: pwdController,
        obscureText: true,
        decoration: InputDecoration(
            hintText: 'Password',
            contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50.0)
            )
        ),
      ),
    );
    final buttonLogin = Padding(
      padding: EdgeInsets.only(bottom: 5),
      child: ButtonTheme(
        height: 56,
        child: RaisedButton(
            child: Text('Login', style: TextStyle(

                color: Colors.white, fontSize: 20, fontFamily: '')),

            color: Colors.black87,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50)
            ),
            onPressed: () {
              setState(() {
                futureJwt = createLoginState(
                    emailController.text, pwdController.text);
              });
            }
        ),
      ),
    );
    final buttonRegister = Padding(
      padding: EdgeInsets.only(bottom: 5),
      child: ButtonTheme(
        height: 56,
        child: RaisedButton(
            child: Text('Register', style: TextStyle(

                color: Colors.white, fontSize: 20, fontFamily: '')),

            color: Colors.black87,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50)
            ),
            onPressed: () =>
            {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) {
                        return RegisterPage();
                      }
                  )
              )
            }
        ),
      ),
    );
    final buttonForgotPassword = FlatButton(
        child: Text('Forgot Password', style: TextStyle(

            color: Colors.grey, fontSize: 16, fontFamily: ''),),

        onPressed: null
    );

    return SafeArea(
        child: Scaffold(
          body: Center(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 20),
              children: <Widget>[
                home,
                logo,
                inputEmail,
                inputPassword,
                buttonLogin,
                buttonRegister,
                buttonForgotPassword
              ],
            ),
          ),
        )
    );
  }



  Future<Users> createLoginState(String email, password) async {
    final http.Response response = await http.post(
        'https://virqueue.herokuapp.com/api/login',

        headers: <String, String>{
          'Accept': 'application/json',
        },
        body: {
          'email': email,
          'password': password,

        }
    );
    SharedPreferences logindata;
    var data = json.decode(response.body);
    logindata = await SharedPreferences.getInstance();
    setState(() {
      logindata.setString("id",data["user"]["id"].toString());
      if (data["role"] == "Customer") {

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DashBoard()),
        );
      }
      else {
        throw Exception('Failed to login');
      }
    }

    );
  }
}

