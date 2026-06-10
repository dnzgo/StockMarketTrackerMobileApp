import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {

  static Future<String?> getCountry() async {
    // check permission for location
    LocationPermission permission =
    await Geolocator.checkPermission();

    // asking permission if denied
    if (permission == LocationPermission.denied) {
      permission =
      await Geolocator.requestPermission();
    }
    // if permanently denied stop
    if (permission ==
        LocationPermission.deniedForever) {
      return null;
    }
    // get user location
    final position =
    await Geolocator.getCurrentPosition();
    // convert coordinates to country
    final placemarks =
    await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    if (placemarks.isEmpty) {
      return null;
    }
    return placemarks.first.isoCountryCode;
  }
}