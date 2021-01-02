import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'file:///C:/Users/Asyraaf/AndroidStudioProjects/virque-master/lib/api/api.dart';

import 'package:virque/userdashboard.dart';

import 'model/users.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  var futureUsers;
  @override
  void initState() {
    super.initState();
    futureUsers = users();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(

        appBar: new AppBar(
          title: new Text(
            "EDIT PROFILE",
            style: new TextStyle(color: Colors.white, fontSize: 30, fontFamily: 'Nuevo'),
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
          leading: GestureDetector(
            onTap: () {             Navigator.push(context,
                new MaterialPageRoute(builder: (context) => new DashBoard())
            );/* Write listener code here */ },
            child: Icon(
              Icons.menu,  // add custom icons also
            ),
          ),
        ),
        body: Center(
          child: FutureBuilder(
            future: users(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index){
                    return Column(
                      children: <Widget>[
                        Text(snapshot.data[index].name),
                        Text(snapshot.data[index].email),
                        Text(snapshot.data[index].password)


                      ],
                    );
                    });
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

Future<List<Users>> users() async {


  final response = await CallApi().getData("users/1");

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.

    var data =jsonDecode(response.body);
print(data);

    List<Users> users = [];
//    if(response.body.length<2){
//      users.add(Users.fromJson(data));

//    }
//    for(var u in data){

      users.add(Users.fromJson(data));
//    }
    return users;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load server');
  }
}
