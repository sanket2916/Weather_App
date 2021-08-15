import 'package:climate/Utilities/Weather.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'CitySearch_Screen.dart';
import 'package:climate/WidgetUsed/ReusableCard.dart';

class LocationScreen extends StatefulWidget {
  final weatherData;
  LocationScreen(this.weatherData);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final WeatherModel weatherModel = new WeatherModel();
  var temp;
  var weatherIcon;
  var cityName;
  var humidity;
  var windSpeed;
  var pressure;
  var visibility;
  var weatherType;
  var feelsLike;
  var weatherDescription;

  String image = 'images/default.png';

  void UIupdate(var weatherData) {
    setState(() {
      temp = weatherData['main']['temp'].toInt();
      cityName = weatherData['name'];
      //weatherIcon = weatherModel.weatherIcon(weatherData['weather'][0]['id']);
      weatherIcon = weatherData['weather'][0]['icon'];
      humidity = weatherData['main']['humidity'];
      windSpeed = weatherData['wind']['speed'];
      pressure = weatherData['main']['pressure'];
      visibility = weatherData['visibility'];
      weatherType = weatherData['weather'][0]['main'];
      //weatherType = 'Thunderstorm';
      feelsLike = weatherData['main']['feels_like'];
      _imageSelector();
    });
  }

  String _imageSelector(){
    if(weatherType == 'Rain' || weatherType == 'Drizzle')
      image = 'images/rain.jpg';
    else if(weatherType == 'Snow')
      image = 'images/snow.jpg';
    else if(weatherType == 'Clouds')
      image = 'images/clouds.jpg';
    else if(weatherType == 'Thunderstorm')
      image = 'images/thunderstorm.jpg';
    else
      image = 'images/clearSky.jpg';
    return image;
  }


  @override
  void initState() {
    UIupdate(widget.weatherData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.fill,
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.5),BlendMode.dstATop,
            )
          )
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () async {
                        var weatherData = await weatherModel.getLocationWeather();
                        UIupdate(weatherData);
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.locationArrow,
                      ),
                      iconSize: 30,
                    ),
                    IconButton(
                      onPressed: () async {
                        var cityName = await Navigator.push(context, MaterialPageRoute(
                          builder: (context){
                            return CitySearch();
                          }
                        ));

                        if(cityName != null){
                          var weatherData = await weatherModel.getCityWeather(cityName);
                          UIupdate(weatherData);
                        }
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.searchLocation,
                      ),
                      iconSize: 30,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                flex: 6,
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_pin,
                              size: 30,
                            ),
                            Text(
                              '$cityName',
                              style: TextStyle(
                                fontSize: 30.0,
                              ),
                            )
                          ],
                        )
                      ),
                      SizedBox(
                        height: 70,
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text(
                            //   weatherIcon,
                            //   style: TextStyle(
                            //     fontSize: 50.0,
                            //   ),
                            // ),
                            Image(
                              image: NetworkImage('http://openweathermap.org/img/wn/$weatherIcon@2x.png'),
                            ),
                            Row(
                              children: [
                                Text(
                                  '$temp',
                                  style: TextStyle(
                                    fontSize: 70,
                                    fontWeight: FontWeight.w300
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  // textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    Text(
                                      '°C',
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    SizedBox(height: 5,),
                                    Text(
                                      ' $weatherType',
                                      style: TextStyle(
                                        fontSize: 25.0,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: Container(
                  child: Column(
                    children: [
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ReusableCard(
                              parameterValue : '$feelsLike°C',
                              parameter: 'Feels like',
                              icon: FontAwesomeIcons.thermometerEmpty,
                              isLeft: true,
                            ),
                            ReusableCard(
                              parameterValue: weatherType,
                              parameter: 'Weather Type',
                              icon: FontAwesomeIcons.cloudSunRain,
                              isLeft: false,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ReusableCard(
                              parameterValue : '$pressure kPa',
                              parameter: 'Pressure',
                              icon: FontAwesomeIcons.arrowDown,
                              isLeft: true
                            ),
                            ReusableCard(
                              parameterValue:  '$windSpeed km/h',
                              parameter: 'Wind Speed',
                              icon: FontAwesomeIcons.wind,
                              isLeft: false,
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ReusableCard(
                              parameterValue: '$humidity%',
                              parameter: 'Humidity',
                              icon: FontAwesomeIcons.water,
                              isLeft: true,
                            ),
                            ReusableCard(
                              parameterValue: '${visibility/1000} km',
                              parameter: 'Visibility',
                              icon: FontAwesomeIcons.solidEye,
                              isLeft: false,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        ),
    );
  }
}

