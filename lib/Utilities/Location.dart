import 'package:geolocator/geolocator.dart';

class Location{
  double _latitude = 0;
  double _longitude = 0;

  Future getLocation() async{
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.medium);
    _longitude = position.longitude;
    _latitude = position.latitude;
  }

  getLatitude(){
    return _latitude;
  }

  getLongitude(){
    return _longitude;
  }
}