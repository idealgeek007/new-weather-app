import 'package:location/location.dart';

/*
class Location {
  double? latitude;
  double? longitude;

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print(e);
    }
  }
}
*/

class LocationService {
  double? latitude;
  double? longitude;
  Location location = Location();

  Future<void> getCurrentLocation() async {
    try {
      final locationData = await location.getLocation();
      latitude = locationData.latitude;
      longitude = locationData.longitude;
    } catch (e) {
      print(e);
    }
  }
}
