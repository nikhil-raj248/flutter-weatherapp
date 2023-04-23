import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weather_app/constants/constants.dart';

import '../models/city_info.dart';
import 'package:http/http.dart' as http;

import 'detailed_weather_info_today.dart';
import 'detailed_weather_info_upcoming.dart';


class CityWeatherInfo extends StatefulWidget {
  const CityWeatherInfo({Key? key, this.cityName}) : super(key: key);

  final String? cityName;

  @override
  State<CityWeatherInfo> createState() => _CityWeatherInfoState();
}

class _CityWeatherInfoState extends State<CityWeatherInfo> {
  bool isDataLoading = true;
  CityInfo? cityInfo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  void loadData() async {
    String cityName = widget.cityName!;
    if (cityName == null || cityName.isEmpty) {
      Navigator.pop(context);
    }
    ;
    final response = await http.get(
        Uri.parse(
            'https://weatherapi-com.p.rapidapi.com/forecast.json?q=${cityName}&days=3'),
        headers: {
          "X-RapidAPI-Key": "${constants.API_KEY}",
          "X-RapidAPI-Host": "weatherapi-com.p.rapidapi.com",
        });

    if (response.statusCode == 200) {
      var tp = jsonDecode(response.body);
      if (tp.isNotEmpty) {
        Map<String, dynamic> tp = jsonDecode(response.body);
        cityInfo = CityInfo.fromJson(tp);
        isDataLoading = false;
        setState(() {});
      }
    } else {
      throw Exception('Failed to load');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black,
        body: isDataLoading
            ? const Center(
                child: CircularProgressIndicator(color: Colors.white,),
              )
            : LayoutBuilder(
                builder: (ctx, constraint) {
                  final height = constraint.maxHeight;
                  final width = constraint.maxWidth;
                  final DateTime date1 = DateTime.fromMillisecondsSinceEpoch(
                      cityInfo!.location!.localtimeEpoch! * 1000);
                  var time = "";
                  if (date1.hour > 12)
                    time = "${date1.hour - 12}:${date1.minute}PM";
                  else
                    time = "${date1.hour}:${date1.minute}AM";
                  return Container(
                    constraints: BoxConstraints.expand(),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://images.unsplash.com/photo-1475274047050-1d0c0975c63e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8bmlnaHQlMjBza3l8ZW58MHx8MHx8&w=1000&q=80"),
                          fit: BoxFit.cover),
                    ),
                    child: Column(
                      children: [
                        Container(
                          //https://i.pinimg.com/originals/10/5f/06/105f06e9f91f2a8ba172e80fcbab7d7d.jpg
                          padding: EdgeInsets.only(
                              top: 20, left: 20, right: 20, bottom: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                            //bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(40),
                          )),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Icon(
                                        Icons.arrow_back,
                                        color: Colors.white,
                                      )),
                                  // Icon(Icons.more_vert,color: Colors.white,),
                                  Icon(
                                    Icons.refresh,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    "${cityInfo!.location!.name}, ${cityInfo!.location!.country}",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      cityInfo!.current!.tempC!.toString(),
                                      style: TextStyle(
                                          fontSize: 45, color: Colors.white),
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Container(
                                      //color: Colors.blue,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Icons.circle_outlined,
                                                size: 8,
                                                color: Colors.white,
                                              ),
                                              SizedBox(
                                                width: 2,
                                              ),
                                              Text(
                                                "C",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Image.network('https:' +
                                  cityInfo!.current!.condition!.icon!),
                              Text(
                                cityInfo!.current!.condition!.text!,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "${constants.weekDay[date1.weekday - 1]}, ${date1.day} ${constants.months[date1.month - 1]}",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                time,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DetailedWeatherInfoToday(
                                                current: cityInfo!.current!,
                                                location: cityInfo!.location!,
                                              )));
                                },
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: 26, right: 26, top: 5, bottom: 5),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      border: Border.all(color: Colors.white)),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "See Details",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        size: 15,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Upcoming Days",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 16),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          height: 155,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: cityInfo!.forecast!.forecastday!.length,
                            itemBuilder: (ctx, index) {
                              Forecastday forecastday =
                                  cityInfo!.forecast!.forecastday![index];
                              final DateTime date1 =
                                  DateTime.fromMillisecondsSinceEpoch(
                                      forecastday!.dateEpoch! * 1000);
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DetailedWeatherInfo(
                                                location:
                                                    "${cityInfo!.location!.name}, ${cityInfo!.location!.country}",
                                                forecastday: forecastday,
                                              )));
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(left: 5, right: 5),
                                  padding: EdgeInsets.only(
                                      left: 12, right: 12, top: 5, bottom: 5),
                                  decoration: BoxDecoration(
                                      //color: Colors.indigo,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      border: Border.all(
                                          width: 0.8, color: Colors.grey)),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    //crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        "${date1.day}, ${constants.weekDay[date1.weekday - 1].substring(0, 3)}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Image.network('https:' +
                                          forecastday!.day!.condition!.icon!),
                                      Text(
                                        forecastday!.day!.condition!.text!,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  forecastday!.day!.mintempC!
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.red),
                                                ),
                                                //SizedBox(width: 2,),
                                                Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 2,
                                                    ),
                                                    Icon(
                                                      Icons.circle_outlined,
                                                      size: 5,
                                                      color: Colors.red,
                                                    ),
                                                    //SizedBox(width: 2,),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 12,
                                          ),
                                          Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  forecastday!.day!.mintempC!
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.blue),
                                                ),
                                                //SizedBox(width: 2,),
                                                Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 2,
                                                    ),
                                                    Icon(
                                                      Icons.circle_outlined,
                                                      size: 5,
                                                      color: Colors.blue,
                                                    ),
                                                    //SizedBox(width: 2,),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
