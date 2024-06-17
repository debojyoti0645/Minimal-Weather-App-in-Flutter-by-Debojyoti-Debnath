// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/models/weather_model.dart';
import 'package:weather/services/weather_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //api key
  final _weatherService = WeatherServices('34f9eef837d70335c49a901586a1f2fc');
  Weather? _weather;

  //fetch weather
  _fetchweather() async {
    //get current city
    String cityName = await _weatherService.getCurrentCity();

    //get weather for city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  //weather animatiopns
  String getWeatherCondition(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json';

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rain.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

  //init stste
  @override
  void initState() {
    super.initState();
    _fetchweather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: const Color.fromARGB(29, 158, 158, 158),
        child: ListView(children: [
          DrawerHeader(
              decoration: BoxDecoration(
                  color: Color.fromARGB(131, 46, 46, 46),
                  borderRadius: BorderRadius.circular(10.0)),
              child: Center(
                child: Text(
                  "Minimal Weather Application by Debojyoti Debnath",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              )),
          ListTile(
              title: Text(
                'About Us',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              onTap: () {}),
          ListTile(
              title: Text(
                'More Apps',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              onTap: () {}),
        ]),
      ),
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
              splashRadius: 0.1,
              onPressed: () {},
              icon: Icon(
                Icons.location_city_outlined,
                color: Colors.grey,
              )),
        ],
        leading: Builder(
            builder: (context) => IconButton(
                splashRadius: 0.1,
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: Icon(
                  Icons.menu,
                  color: Colors.grey,
                ))),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //city name
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: Colors.grey,
                ),
                Text(
                  _weather?.cityName ?? "Loading City..",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
              ],
            ),

            SizedBox(
              height: 50,
            ),

            //animation
            Lottie.asset(getWeatherCondition(_weather?.mainCondition)),
            SizedBox(
              height: 50,
            ),

            //tempereature
            Text(
              '${_weather?.temp.round()}°C' ?? "Loading Temp..",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey),
            ),

            //weather condition
            Text(
              _weather?.mainCondition ?? "",
              style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey),
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
