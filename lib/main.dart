import 'package:flutter/material.dart';
import 'widgets/weather_tile.dart';

void main() => runApp(
  MaterialApp(
    title: "Weather App",
    debugShowCheckedModeBanner: false,
    home: MyApp()
  )
);

class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return _MyApp();
  }
}


class _MyApp extends State<MyApp>{
  @override
  Widget build (BuildContext context){
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height/2,
            width: MediaQuery.of(context).size.width,
            color: Color(0xfff1f1f1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Location", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900)),
                Padding(padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  "85°", style: TextStyle(
                    fontSize: 40, fontWeight: FontWeight.w900, color: Colors.purple),),),
                Text(
                  "High of 89°, Low of 35°",
                  style: TextStyle(color: Color(0xff9e9e9e), fontSize: 14, fontWeight: FontWeight.w600),

                )
              ],
            ),
          ),
          Expanded(child: Padding(
            padding: EdgeInsets.all(20),
            child: ListView(
              children: [
                WeatherTile(icon: Icons.thermostat_outlined, title: "Temparature", subtitle: "85°"),
                WeatherTile(icon: Icons.filter_drama_outlined, title: "Weather", subtitle: "Cloudy"),
                WeatherTile(icon: Icons.wb_sunny, title: "Humidity", subtitle: "67%"),
                WeatherTile(icon: Icons.waves, title: "Wind Speed", subtitle: "2MPH"),

              ],
            ),
          ))
        ],
      ),
    );
  }
}