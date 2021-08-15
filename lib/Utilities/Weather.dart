import 'package:flutter/cupertino.dart';

import 'Networking.dart';
import 'Location.dart';

const kApiKey = '8cca58715316174805561a675ad21898';
const kUrl = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel{
  String weatherIcon(int condition){
    if(condition < 300)
      return '🌩';
    else if(condition < 400)
      return '🌧';
    else if(condition <600)
      return '⛈';
    else if(condition < 700)
      return '🌨';
    else if(condition < 800)
      return '🌫';
    else if(condition == 800)
      return '☀';
    else if(condition <= 804)
      return '☁';
    else
      return '🤷‍';
  }

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