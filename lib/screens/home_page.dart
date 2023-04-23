import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/constants/constants.dart';
import 'package:weather_app/screens/profile_page.dart';
import 'package:weather_app/screens/search_places.dart';

import '../widgets/rounded_input_field.dart';
import 'city_weather_info.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'current_location_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchedResult = TextEditingController();
  String? enteredPlaceName;
  List<Map<String, dynamic>>? searchedPlaces = [];

  Future<void> searchCity() async {
    if (enteredPlaceName == null || enteredPlaceName!.isEmpty) return;
    final response = await http.get(
        Uri.parse(
            'https://weatherapi-com.p.rapidapi.com/search.json?q=${enteredPlaceName}'),
        headers: {
          "X-RapidAPI-Key": "${constants.API_KEY}",
          "X-RapidAPI-Host": "weatherapi-com.p.rapidapi.com",
        });

    if (response.statusCode == 200) {
      searchedPlaces!.clear();
      var tp = jsonDecode(response.body);
      if (tp.isNotEmpty) {
        List tp = jsonDecode(response.body);
        //print(tp[0]['name']);
        print(tp.length);
        searchedPlaces = tp.map((data) {
          print(data);
          return {
            'name': data['name'],
            'region': data['region'],
            'country': data['country'],
            'lat': data['lat'],
            'lon': data['lon'],
          };
        }).toList();
        print(searchedPlaces);
        setState(() {});
      }
    } else {
      throw Exception('Failed to load');
    }
  }

  List<IconData> iconList = [Icons.add,Icons.access_time];
  int _bottomNavIndex=1;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          bottomNavigationBar: CurvedNavigationBar(
            color: Colors.black54,
            backgroundColor: Colors.black,
            buttonBackgroundColor: Colors.grey[850],
            items: const <Widget>[
              Icon(Icons.person, size: 30,color: Colors.white,),
              Icon(Icons.home, size: 30,color: Colors.white,),
              Icon(Icons.location_on, size: 30,color: Colors.white,),
            ],
            index: _bottomNavIndex,
            onTap: (index) {
              //Handle button tap
              setState(() {
                _bottomNavIndex=index;
              });
            },
          ),
          body: getSelectedPage()
      ),
    );
  }

  Widget getSelectedPage(){
    if(_bottomNavIndex==0){
      return ProfilePage();
    }
    else if(_bottomNavIndex==1){
      return SearchPlacesPage();
    }
    else{
      return CurrentLocationPage();
    }
  }

}
