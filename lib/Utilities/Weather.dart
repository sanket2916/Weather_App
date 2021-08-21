import 'package:flutter/cupertino.dart';

import 'Networking.dart';
import 'Location.dart';

const kApiKey = ''; //Enter your api key here
const kUrl = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel{

  Future getLocationWeather() async{
    Location location = new Location();
    await location.getLocation();
    
    NetworkHelper networkHelper = new NetworkHelper('$kUrl?lat=${location.getLatitude()}&lon=${location.getLongitude()}&units=metric&appid=$kApiKey');

    var weatherData = await networkHelper.getData();
    print(weatherData);

    return weatherData;
  }
  
  Future getCityWeather(String cityName) async{
    NetworkHelper networkHelper = new NetworkHelper('$kUrl?q=$cityName&units=metric&appid=$kApiKey');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }
}