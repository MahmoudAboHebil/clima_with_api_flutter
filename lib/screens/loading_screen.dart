import 'dart:convert';

import 'package:clima_with_api_flutter/services/location.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const apiKey = "3e186f0092055e392c60e2dd6a2c987d";

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double? latitude;
  double? longitude;
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    setState(() {
      latitude = location.latitude;
      longitude = location.longitude;
    });
    getData();
  }

  void getData() async {
    http.Response response = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey"));
    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);
      int condition = decodedData["weather"][0]["id"];
      double temp = decodedData['main']['temp'];
      String cityName = decodedData['name'];

      print(temp);
      print(cityName);
      print(condition);
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
