import 'package:location/location.dart';

class LocationHelper {
  double? latitude;
  double? longitude;

  Future<void> getCurrentLocation() async {
    Location location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranded;
    LocationData _locationData;

    // servis ayakta mı
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    // home izin kontrolü
    _permissionGranded = await location.hasPermission();
    if (_permissionGranded == PermissionStatus.denied) {
      _permissionGranded = await location.requestPermission();
      if (_permissionGranded == PermissionStatus.granted) {
        return;
      }
    }
    // izinler tamam ise
    _locationData = await location.getLocation();
    latitude = _locationData.latitude;
    longitude = _locationData.longitude;
  }
}
