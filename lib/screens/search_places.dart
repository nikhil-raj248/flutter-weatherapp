import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/constants/constants.dart';

import '../widgets/rounded_input_field.dart';
import 'city_weather_info.dart';

class SearchPlacesPage extends StatefulWidget {
  const SearchPlacesPage({Key? key}) : super(key: key);

  @override
  State<SearchPlacesPage> createState() => _SearchPlacesPageState();
}

class _SearchPlacesPageState extends State<SearchPlacesPage> {


  TextEditingController searchedResult = TextEditingController();
  String? enteredPlaceName;
  List<Map<String, dynamic>>? searchedPlaces = [];
  bool isSearchCityLoading = false;

  Future<void> searchCity() async {
    if (enteredPlaceName == null || enteredPlaceName!.isEmpty) return;
    setState(() {
      isSearchCityLoading=true;
    });
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
        setState(() {
          isSearchCityLoading=false;
        });
      }
    } else {
      throw Exception('Failed to load');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
          color: Colors.black
        // image: DecorationImage(
        //     image: NetworkImage(
        //         "https://images.unsplash.com/photo-1475274047050-1d0c0975c63e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8bmlnaHQlMjBza3l8ZW58MHx8MHx8&w=1000&q=80"),
        //     fit: BoxFit.cover),
      ),
      child: Column(
        children: [
          Container(
            padding:
            EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.menu,
                      color: Colors.white,
                      size: 26,
                    ),
                    Text(
                      "WeatherShala",
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                    Icon(
                      Icons.notifications_none_outlined,
                      color: Colors.white,
                      size: 26,
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  "Hi Rudra,",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(
                      "Welcome Back",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.waving_hand,
                      color: Colors.yellow,
                    )
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                RoundedInputField(
                  textEditingController: searchedResult,
                  hintText: "Search City",
                  hintStyle: TextStyle(color: Colors.white, fontSize: 18),
                  textStyle: TextStyle(color: Colors.white, fontSize: 18),
                  icon: Icons.search_rounded,
                  iconSize: 26,
                  cursorColor: Colors.black,
                  editTextBackgroundColor:
                  Colors.blue[300]!.withOpacity(0.15),
                  iconColor: Colors.white,
                  onChanged: (value) {
                    enteredPlaceName = value;
                    searchCity();
                    setState(() {});
                  },
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(
                  top: 30, left: 15, right: 15, bottom: 20),
              //color: Colors.yellow,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Search Results for ${enteredPlaceName ?? ''}",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    isSearchCityLoading?const Center(
                      child: CircularProgressIndicator(color: Colors.white,),
                    ):ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: searchedPlaces!.length,
                      itemBuilder: (ctx, index) {
                        return Container(
                          padding: EdgeInsets.only(
                              top: 10, bottom: 10, left: 20, right: 24),
                          margin: EdgeInsets.only(top: 10, bottom: 10),
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                  color: Colors.grey, width: 0.6)),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${searchedPlaces![index]['name']}, ${searchedPlaces![index]['region']}, ${searchedPlaces![index]['country']}",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CityWeatherInfo(
                                                  cityName:
                                                  searchedPlaces![
                                                  index]['name'],
                                                )));
                                  },
                                  child: Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                  )),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
