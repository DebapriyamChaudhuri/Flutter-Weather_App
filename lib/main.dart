import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:core';

void main() => runApp(WeatherApp());


class WeatherApp extends StatefulWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {

  int temparature = 0;
  String location = 'San Francisco';
  int woeid = 2487956;
  String weather = 'clear';

  String searchApiUrl = 'https://www.metaweather.com/api/location/search/?query=';
  String locationApiUrl = 'https://www.metaweather.com/api/location/';



  void fetchSearch(String input) async {
    var searchResult = await http.get(Uri.parse(searchApiUrl) + input);
    var result = json.decode(searchResult.body)[0];

    setState(() {
      location = result["title"];
      woeid = result["woeid"];
    });
  }

  void fetchLocation() async{
    var locationResult = await http.get(Uri.parse(locationApiUrl) + woeid.toString());
    var result = json.decode(locationResult.body);
    var consolidated_weather = result["consolidated_weather"];
    var data = consolidated_weather[0];

    setState(() {
      temparature = data["the_temp"].round();
      weather = data["weather_state_name"].replaceAll(' ','').toLowerCase();
    });
  }

  void onTextFieldSubmitted(String input) {
    fetchSearch(input);
    fetchLocation();
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      home: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/$weather.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: [
                  Center(
                    child: Text(temparature.toString() + ' °C',
                    style: TextStyle(fontSize: 70, color: Colors.white),
                    ),
                  ),
                  Text(location, style: TextStyle(fontSize: 40, color: Colors.white),)
                ],
              ),
              Column(
                children: [
                  Container(
                    width: 300,
                    child: TextField(
                      onSubmitted: (String input){
                        onTextFieldSubmitted(input);
                      },
                      style: TextStyle(color: Colors.white, fontSize: 30),
                      decoration: InputDecoration(
                        hintText: "Search a location",
                        hintStyle: TextStyle(fontSize: 20, color: Colors.white70),
                        prefixIcon: Icon(Icons.search, color: Colors.white)
                      ),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),

      ),
    );
  }
}
