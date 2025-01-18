import 'package:ar_ttt5/controllers/air_pollution_controller.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vector_math/vector_math_64.dart' as vector64;
import 'dart:math' as math;

class AirPollutionARPage extends StatelessWidget {
  final AirPollutionController controller =
      Get.find<AirPollutionController>(); // Access the controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Air Pollution Visualization')),
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
          return Stack(
            children: [
              ArCoreView(onArCoreViewCreated: _onArCoreViewCreated),
              Positioned(
                top: 20,
                right: 20,
                child: _buildInfoContainer(),
              ),
            ],
          );
        }
      }),
    );
  }

  Widget _buildInfoContainer() {
    final pollutionData = controller.pollutionData;
    final coord = pollutionData['coord'];
    final components = pollutionData['list'][0]['components'];

    return Container(
      width: 200,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(blurRadius: 5, color: Colors.black26)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Location",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          Text("Lat: ${coord['lat']}"),
          Text("Lon: ${coord['lon']}"),
          SizedBox(height: 8),
          Text(
            "Pollution Details",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          ...components.entries.map((entry) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(entry.key.toUpperCase()),
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: _getColorForPollutant(entry.key),
                      shape: BoxShape.circle,
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }

  void _onArCoreViewCreated(ArCoreController arCoreController) {
    final pollutionData = controller.pollutionData['list'][0]['components'];

    // Render spheres for each pollutant, increasing frequency
    pollutionData.forEach((key, value) {
      for (int i = 0; i < 20; i++) {
        // Increased frequency to 20
        _createSphereForPollutant(arCoreController, key, value);
      }
    });
  }

  void _createSphereForPollutant(
      ArCoreController arCoreController, String key, dynamic value) {
    // Ensure value is a double
    final double doubleValue = (value is int) ? value.toDouble() : value;

    // Map pollutant to color and size
    final material = ArCoreMaterial(
      color: _getColorForPollutant(key),
    );

    final sphere = ArCoreSphere(
      materials: [material],
      radius: _getSmallerSize(doubleValue),
    );

    final node = ArCoreNode(
      shape: sphere,
      position: _getRandomPosition(),
    );

    arCoreController.addArCoreNode(node);
  }

  Color _getColorForPollutant(String pollutant) {
    // Map pollutants to specific colors
    switch (pollutant) {
      case 'co':
        return Colors.red;
      case 'no2':
        return Colors.orange;
      case 'o3':
        return Colors.green;
      case 'so2':
        return Colors.blue;
      case 'pm2_5':
        return Colors.purple;
      case 'pm10':
        return Colors.yellow;
      case 'nh3':
        return Colors.cyan;
      default:
        return Colors.white;
    }
  }

  double _getSmallerSize(dynamic value) {
    // Ensure value is a double
    final double doubleValue = (value is int) ? value.toDouble() : value;

    // Map value to smaller sphere size (example: size between 0.01 and 0.1)
    return doubleValue.clamp(0.01, 0.1);
  }

  vector64.Vector3 _getRandomPosition() {
    // Generate random positions around the user
    final random = math.Random();
    final double x = random.nextDouble() * 2 - 1; // Between -1 and 1
    final double y = random.nextDouble() * 2 - 1;
    final double z = random.nextDouble() * -2 - 1; // Between -1 and -3

    return vector64.Vector3(x, y, z);
  }
}
