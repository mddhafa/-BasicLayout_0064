import 'package:basiclayout/const.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 
  final WeatherFactory _wf = WeatherFactory(OPENWEATHER_API_KEY);
  
  Weather? _weathers;

  @override
  void initState() {
    super.initState();
    _wf.currentWeatherByCityName("Yogyakarta").then((w){
      setState(() {
        _weathers = w;
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: _buildUI(),
      appBar: AppBar(
        title: const Text("Weather App"), 
        centerTitle: true,
        leading: Icon(Icons.menu),
        actions: [
          Icon(Icons.add_box)
        ]
        ), 
    );
    
  }

}
