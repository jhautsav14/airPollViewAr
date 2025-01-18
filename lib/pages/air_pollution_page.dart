import 'package:ar_ttt5/controllers/air_pollution_controller.dart';
import 'package:ar_ttt5/pages/air_pollution_ar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AirPollutionPage extends StatelessWidget {
  final AirPollutionController controller =
      Get.put(AirPollutionController()); // Initialize controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Air Pollution Data')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (controller.pollutionData.isEmpty) {
          return Center(
            child: ElevatedButton(
              onPressed: controller.fetchAirPollutionData,
              child: Text("Fetch Air Pollution Data"),
            ),
          );
        } else {
          return _buildPollutionData(
              controller.pollutionData.cast<String, dynamic>());
        }
      }),
    );
  }

  Widget _buildPollutionData(Map<String, dynamic> data) {
    final airQualityIndex = data['list'][0]['main']['aqi'];
    final components = data['list'][0]['components'];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Air Quality Index (AQI): $airQualityIndex",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Text(
            "Components:",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text("CO: ${components['co']} µg/m³"),
          Text("NO: ${components['no']} µg/m³"),
          Text("NO2: ${components['no2']} µg/m³"),
          Text("O3: ${components['o3']} µg/m³"),
          Text("SO2: ${components['so2']} µg/m³"),
          Text("PM2.5: ${components['pm2_5']} µg/m³"),
          Text("PM10: ${components['pm10']} µg/m³"),
          Text("NH3: ${components['nh3']} µg/m³"),
          SizedBox(
            height: 25,
          ),
          ElevatedButton(
              onPressed: () => Get.to(() => AirPollutionARPage()),
              child: Text("Gen Ar"))
        ],
      ),
    );
  }
}
