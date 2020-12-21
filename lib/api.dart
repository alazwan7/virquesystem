import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class CallApi{

  final String _url = 'http://192.168.43.115:8000/api/';



  postData(data, apiUrl) async {
    var fullUrl = _url + apiUrl ;
    print(fullUrl);
    print(data);
    return await http.post(
        fullUrl,
        body: jsonEncode(data),
        headers: _setHeaders()
    );
  }
  getData(apiUrl) async {
    var fullUrl = _url + apiUrl ;
    print(fullUrl);

    return await http.get(
        fullUrl,
        headers: _setHeaders()
    );
  }



  updateData(data, apiUrl) async {
    var fullUrl = _url + apiUrl ;
    print(fullUrl);
    print(data);
    return await http.put(
        fullUrl,
        body: jsonEncode(data),
        headers: _setHeaders()
    );
  }




  _setHeaders() => {
    'Content-type' : 'application/json',
    'Accept' : 'application/json',
  };



}
