import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class GlobalController extends GetxController{
  RxBool _isloading = true.obs;
  final RxDouble latitude = 0.0.obs;
  final RxDouble longitude = 0.0.obs;

  RxBool isloading() => _isloading;
  RxDouble getlatitude() => latitude;
  RxDouble getlongitude() => longitude;

  @override
  void onInit() {
    if(_isloading.isTrue){
      getlocation();
    }
    super.onInit();
  }

  getlocation() async {

    bool isServiceEnabled;
    LocationPermission locationPermission;
    isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    
    if(!isServiceEnabled){
      return Future.error("Location Not Enabled");
    }

    locationPermission = await Geolocator.checkPermission();

    if(locationPermission == LocationPermission.deniedForever) {
      return Future.error("Location Not Enabled");
    }
    else if(locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        return Future.error("Location Not Enabled");
      }
    }

    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((value){
      latitude.value = value.latitude;
      longitude.value = value.longitude;
      _isloading.value = false;
    });
  }
}
