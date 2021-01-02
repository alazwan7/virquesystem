import 'package:flutter/material.dart';
import 'Customers/loginCustomer.dart';
import 'Staffs/loginStaff.dart';


class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}
class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    final welcomeText = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              child: Text(
                'Welcome!!',
                style: TextStyle(fontSize: 30.0, fontFamily: ''),
              ),
          ),
        ],
      ),
    );
    final logo = Padding(
      padding: EdgeInsets.all(20),
      child: Hero(
          tag: 'hero',
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 56.0,
            child: Image.asset('assets/images/viqueLogo.png'),
          )
      ),
    );


    final buttonLogin = Padding(
      padding: EdgeInsets.only(bottom: 5),
      child: ButtonTheme(
        height: 56,
        child: RaisedButton(
            child: Text('Customer', style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: '')),
            color: Colors.black87,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50)
            ),
            onPressed: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context){
                        return LoginCustomerPage();
                      }
                  )
              )
            }
        ),
      ),
    );
    final buttonRegister = Padding(
      padding: EdgeInsets.only(bottom: 5),
      child: ButtonTheme(
        height: 56,
        child: RaisedButton(
            child: Text('Staff', style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: '')),
            color: Colors.black87,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50)
            ),
            onPressed: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context){
                        return LoginStaffPage();
                      }
                  )
              )
            }
        ),
      ),
    );

    return SafeArea(
        child: Scaffold(
          body: Center(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 20),
              children: <Widget>[
                welcomeText,
                logo,
                buttonLogin,
                buttonRegister
              ],
            ),
          ),
        )
    );
  }
}