import 'package:geolocator/geolocator.dart'
    hide LocationServiceDisabledException;
import '../../data/exceptions/app_exceptions.dart';

abstract class ILocationService {
  Future<Position> getCurrentPosition();
}

class LocationService implements ILocationService {
  @override
  Future<Position> getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if localization is turned on
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Throws error if locations is turned off
      throw LocationServiceDisabledException();
    }

    //Test if localization is allowed
    permission = await Geolocator.checkPermission();
    //If it isn't, ask the user
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // If the user refuses again, throw error
        throw LocationPermissionDeniedException();
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // If the user denied permission permanently, can request again
      LocationPermissionPermanentlyDeniedException();
    }

    // If permissions are allowed, return current position
    return await Geolocator.getCurrentPosition();
  }
}
