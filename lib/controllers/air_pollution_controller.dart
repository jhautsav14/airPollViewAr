import 'package:get/get.dart';
import 'package:location/location.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AirPollutionController extends GetxController {
  final Location _location = Location();
  var isLoading = false.obs;
  var pollutionData = {}.obs;

  Future<void> fetchAirPollutionData() async {
    isLoading.value = true;

    try {
      // Get the user's location
      LocationData locationData = await _location.getLocation();
      double latitude = locationData.latitude!;
      double longitude = locationData.longitude!;
      print("Lat : $latitude   Long : $longitude");

      // Fetch air pollution data
      String apiKey = '3eb333e62036318ab373384da2a66c75';
      String url =
          'http://api.openweathermap.org/data/2.5/air_pollution?lat=$latitude&lon=$longitude&appid=$apiKey';

      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        pollutionData.value = jsonDecode(response.body);
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 3));
    } finally {
      isLoading.value = false;
    }
  }
}
