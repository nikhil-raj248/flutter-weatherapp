import 'package:flutter/material.dart';
import '../models/city_info.dart';
import '../constants//constants.dart';

class DetailedWeatherInfoToday extends StatefulWidget {
  const DetailedWeatherInfoToday({Key? key, this.location, this.current})
      : super(key: key);

  final Location? location;
  final Current? current;

  @override
  State<DetailedWeatherInfoToday> createState() =>
      _DetailedWeatherInfoTodayState();
}

class _DetailedWeatherInfoTodayState extends State<DetailedWeatherInfoToday> {
  @override
  Widget build(BuildContext context) {
    Location location = widget.location!;
    Current current = widget.current!;
    final DateTime date1 =
        DateTime.fromMillisecondsSinceEpoch(location.localtimeEpoch! * 1000);
    var time = "";
    if (date1.hour > 12)
      time = "${date1.hour - 12}:${date1.minute}PM";
    else
      time = "${date1.hour}:${date1.minute}AM";
    return SafeArea(
      child: Scaffold(
        body: Container(
          constraints: BoxConstraints.expand(),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    "https://images.unsplash.com/photo-1475274047050-1d0c0975c63e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8bmlnaHQlMjBza3l8ZW58MHx8MHx8&w=1000&q=80"),
                fit: BoxFit.cover),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      Icons.menu,
                      color: Colors.white,
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Colors.white,
                      size: 28,
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Text(
                      "${location.name}, ${location.country}",
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Center(
                    child: Text(
                  "${constants.weekDay[date1.weekday - 1]}, ${date1.day} ${constants.months[date1.month - 1]}",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w400),
                )),
                SizedBox(
                  height: 5,
                ),
                Center(
                    child: Text(
                  "${time}",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w400),
                )),
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        current!.tempC!.toString(),
                        style: TextStyle(fontSize: 45, color: Colors.white),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                      fontSize: 15, color: Colors.white),
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Center(
                    child: Image.network(
                  'https:' + current!.condition!.icon!,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                )),
                Center(
                    child: Text(
                  current!.condition!.text!,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                )),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      "Temp : ",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            current!.tempC!.toString(),
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                          //SizedBox(width: 2,),
                          Row(
                            children: [
                              Icon(
                                Icons.circle_outlined,
                                size: 6,
                                color: Colors.white,
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    "C",
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.white),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Text(
                      " / ",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            current!.tempF!.toString(),
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                          //SizedBox(width: 2,),
                          Row(
                            children: [
                              Icon(
                                Icons.circle_outlined,
                                size: 6,
                                color: Colors.white,
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    "F",
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.white),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      "Feels like : ",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            current!.feelslikeC!.toString(),
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                          //SizedBox(width: 2,),
                          Row(
                            children: [
                              Icon(
                                Icons.circle_outlined,
                                size: 6,
                                color: Colors.white,
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    "C",
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.white),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Text(
                      " / ",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            current!.feelslikeF!.toString(),
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                          //SizedBox(width: 2,),
                          Row(
                            children: [
                              Icon(
                                Icons.circle_outlined,
                                size: 6,
                                color: Colors.white,
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    "F",
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.white),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Wind : ${current!.windKph}kph / ${current!.windMph}mph",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Wind direction : ${current!.windDir.toString()}",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Humidity : ${current!.humidity.toString()}%",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Precipitation : ${current!.precipMm.toString()}mm / ${current!.precipIn.toString()}in",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Pressure : ${current!.pressureIn.toString()}in / ${current!.pressureMb.toString()}mb",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "TimeZone : ${location.tzId.toString()}",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Lat : ${location!.lat}",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "Lon : ${location!.lon}",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
