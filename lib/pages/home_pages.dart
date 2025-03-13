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

  Widget _buildUI() {
    if (_weathers == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }return SizedBox(width: MediaQuery.sizeOf(context).width,
    height: MediaQuery.sizeOf(context).height,
    child: Column(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,  
    children: [
      _locationHeader(),
      SizedBox(
        height: 20
      ),
     
      _hari(),
      SizedBox(
        height: 20
      ),
      _temperature(),
      SizedBox(
        height: 20
      ),

      _weatherDetails(),
        SizedBox(height: 20),

      _forecastCard(),
      SizedBox(height: 20),

      _footer(),
    ],
    )
    );
  }

  Widget _locationHeader(){
    return Text(_weathers!.areaName?? "",
    style: TextStyle(
      fontSize: 50,
      fontWeight: FontWeight.bold,
    ),
    );
  }

  Widget _hari(){
    DateTime? now = _weathers!.date;
    return Text(DateFormat('EEEE').format(now!),
    style: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: Colors.grey,
    ),
    );
  }

  Widget _temperature() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Text(
            "${_weathers?.temperature?.celsius?.toStringAsFixed(0)}°C",
            style: TextStyle(
              fontSize: 80,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: Divider(thickness: 2),
        ),
        ],
      ),
    );
  }


  Widget _weatherDetails() {
    return Column(
      children: [
        Text(
          _weathers?.weatherDescription ?? "",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey),
        ),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.ac_unit, color: Colors.blue),
            SizedBox(width: 5),
            Text(
              "${_weathers?.windSpeed?.toStringAsFixed(1)} km/h",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
          ],
        ),
      ],
    );
  }

  Widget _forecastCard() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Next 7 days",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _forecastItem("Now", "28°C", "10 km/h", Icons.ac_unit, Icons.air),
                _forecastItem("17.00", "28°C", "10 km/h", Icons.ac_unit, Icons.air),
                _forecastItem("20.00", "28°C", "10 km/h", Icons.ac_unit, Icons.air),
                _forecastItem("23.00", "28°C", "10 km/h", Icons.ac_unit, Icons.air),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _forecastItem(String time, String temp, String wind, IconData weatherIcon, IconData windIcon) {
    return Column(
      children: [
        Text(time, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Icon(weatherIcon, color: Colors.blue),
        Text(temp, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue)),
        Icon(windIcon, color: Colors.red),
        Text(wind, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.red)),
        Icon(Icons.arrow_downward, color: Colors.black),
        Text("0%", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black)),
      ],
    );
  }

  Widget _footer() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text("Developed by : MuhDhafa.id")
        ],
      ),
    );
  }

}
