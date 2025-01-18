import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vector_math/vector_math_64.dart' as vector64;
import 'dart:math' as math;

class MyEarth_AR extends StatefulWidget {
  const MyEarth_AR({super.key});

  @override
  State<MyEarth_AR> createState() => _MyEarth_ARState();
}

class _MyEarth_ARState extends State<MyEarth_AR> {
  ArCoreController? arCoreController;

  void onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    addSpheresAroundUser(arCoreController!);
  }

  Future<void> addSpheresAroundUser(ArCoreController coreController) async {
    final ByteData earthMap = await rootBundle.load("assets/earth_map.jpg");

    for (int i = 0; i < 50; i++) {
      // Generate a random radius for the sphere
      final double radius = _randomValue(0.05, 0.3);

      // Generate a random color
      final material = ArCoreMaterial(
        color: Color.fromARGB(
          255,
          _randomInt(0, 255), // Red
          _randomInt(0, 255), // Green
          _randomInt(0, 255), // Blue
        ),
        textureBytes:
            math.Random().nextBool() ? earthMap.buffer.asUint8List() : null,
      );

      // Create the sphere with random size and material
      final sphere = ArCoreSphere(
        materials: [material],
        radius: radius,
      );

      // Generate random positions for the sphere
      final double x = _randomValue(-3.0, 3.0);
      final double y = _randomValue(-1.5, 1.5);
      final double z = _randomValue(-4.0, -1.0);

      // Create and add the node to the AR scene
      final node = ArCoreNode(
        shape: sphere,
        position: vector64.Vector3(x, y, z),
      );

      coreController.addArCoreNode(node);
    }
  }

  // Helper method to generate a random double value in a range
  double _randomValue(double min, double max) {
    return min + (max - min) * math.Random().nextDouble();
  }

  // Helper method to generate a random integer value in a range
  int _randomInt(int min, int max) {
    return min + math.Random().nextInt(max - min + 1);
  }

  @override
  void dispose() {
    arCoreController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ArCoreView(onArCoreViewCreated: onArCoreViewCreated),
    );
  }
}
