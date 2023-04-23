import 'package:flutter/material.dart';
import 'package:weather_app/screens/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      //home: CityWeatherInfo(cityName: "New Delhi",),
    );
  }
}
