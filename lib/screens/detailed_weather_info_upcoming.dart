import 'package:flutter/material.dart';
import 'package:weather_app/constants/constants.dart';

import '../models/city_info.dart';

class DetailedWeatherInfo extends StatefulWidget {
  const DetailedWeatherInfo({Key? key, this.location, this.forecastday})
      : super(key: key);

  final String? location;
  final Forecastday? forecastday;

  @override
  State<DetailedWeatherInfo> createState() => _DetailedWeatherInfoState();
}

class _DetailedWeatherInfoState extends State<DetailedWeatherInfo> {
  @override
  Widget build(BuildContext context) {
    Forecastday forecastday = widget.forecastday!;
    final DateTime date1 =
        DateTime.fromMillisecondsSinceEpoch(forecastday!.dateEpoch! * 1000);
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
                      widget.location!,
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Center(
                    child: Text(
                  "${constants.weekDay[date1.weekday - 1]}, ${date1.day} ${constants.months[date1.month - 1]}",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w400),
                )),
                Center(
                    child: Image.network(
                  'https:' + forecastday!.day!.condition!.icon!,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                )),
                Center(
                    child: Text(
                  forecastday!.day!.condition!.text!,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                )),
                SizedBox(
                  height: 10,
                ),
                getDetails(forecastday),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getDetails(Forecastday forecastday) {
    print(forecastday.hour!.length);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Text(
              "Max Temp : ",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    forecastday!.day!.maxtempC!.toString(),
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
                            style: TextStyle(fontSize: 10, color: Colors.white),
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
                    forecastday!.day!.maxtempF!.toString(),
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
                            style: TextStyle(fontSize: 10, color: Colors.white),
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
              "Min Temp : ",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    forecastday!.day!.mintempC!.toString(),
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
                            style: TextStyle(fontSize: 10, color: Colors.white),
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
                    forecastday!.day!.mintempF!.toString(),
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
                            style: TextStyle(fontSize: 10, color: Colors.white),
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
              "Avg Temp : ",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    forecastday!.day!.avgtempC!.toString(),
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
                            style: TextStyle(fontSize: 10, color: Colors.white),
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
                    forecastday!.day!.avgtempF!.toString(),
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
                            style: TextStyle(fontSize: 10, color: Colors.white),
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
        Text(
          "Max Wind : ${forecastday!.day!.maxwindKph!.toString()}kph / ${forecastday!.day!.maxwindMph!.toString()}mph",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Avg Humidity : ${forecastday!.day!.avghumidity!.toString()}%",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "Sunrise : ${forecastday!.astro!.sunrise.toString()}",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        Text(
          "Sunset : ${forecastday!.astro!.sunset.toString()}",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "Hourly Weather",
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 160,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: forecastday.hour!.length,
            itemBuilder: (ctx, index) {
              final DateTime date1 = DateTime.fromMillisecondsSinceEpoch(
                  forecastday.hour![index].timeEpoch! * 1000);
              var time = "";
              if (date1.hour > 12)
                time = "${date1.hour - 12}:${date1.minute}0 PM";
              else
                time = "${date1.hour}:${date1.minute}0 AM";
              return Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(right: 10),
                padding:
                    EdgeInsets.only(left: 12, right: 12, top: 5, bottom: 5),
                decoration: BoxDecoration(
                    //color: Colors.indigo,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(width: 0.5, color: Colors.grey)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  //crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "${time}",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w400),
                    ),
                    Image.network(
                        'https:' + forecastday.hour![index].condition!.icon!),
                    Text(
                      forecastday.hour![index].condition!.text!,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                    ),
                    //SizedBox(height: 5,),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            forecastday.hour![index].tempC!.toString(),
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
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
                                color: Colors.white,
                              ),
                              //SizedBox(width: 2,),
                            ],
                          )
                        ],
                      ),
                    ),
                    //Text("Feels like ${forecastday.hour![index].feelslikeC.toString()}",style: TextStyle(color: Colors.white,fontSize: 10,fontWeight: FontWeight.w400),),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Feels like ${forecastday.hour![index].feelslikeC!.toString()}",
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
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
                                color: Colors.white,
                              ),
                              //SizedBox(width: 2,),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
