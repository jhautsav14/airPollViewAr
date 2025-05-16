

import 'package:ar_ttt5/controllers/air_pollution_controller.dart';
import 'package:ar_ttt5/pages/air_pollution_ar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';

class AirPollutionPage extends StatelessWidget {
  final AirPollutionController controller = Get.put(AirPollutionController());

  // Colors for the chart
  final List<Color> gradientColors = [
    Colors.cyan,
    Colors.blue,
  ];

  // AQI Scale information
  final Map<int, Map<String, dynamic>> aqiScale = {
    1: {'name': 'Good', 'color': Colors.green},
    2: {'name': 'Fair', 'color': Colors.lightGreen},
    3: {'name': 'Moderate', 'color': Colors.yellow},
    4: {'name': 'Poor', 'color': Colors.orange},
    5: {'name': 'Very Poor', 'color': Colors.red},
  };

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
    final airQualityIndex = data['list'][0]['main']['aqi']?.toInt() ?? 1;
    final components = data['list'][0]['components'];
    final currentAqiInfo = aqiScale[airQualityIndex] ?? aqiScale[1]!;

    // Prepare data for the chart
    final componentValues = [
      components['co']?.toDouble() ?? 0,
      components['no']?.toDouble() ?? 0,
      components['no2']?.toDouble() ?? 0,
      components['o3']?.toDouble() ?? 0,
      components['so2']?.toDouble() ?? 0,
      components['pm2_5']?.toDouble() ?? 0,
      components['pm10']?.toDouble() ?? 0,
      components['nh3']?.toDouble() ?? 0,
    ];

    final componentNames = [
      'CO',
      'NO',
      'NO2',
      'O3',
      'SO2',
      'PM2.5',
      'PM10',
      'NH3'
    ];
    final maxValue = componentValues.reduce((a, b) => a > b ? a : b) * 1.2;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // AQI Status Indicator
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: currentAqiInfo['color'].withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: currentAqiInfo['color'],
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Current AQI: ${currentAqiInfo['name']} ($airQualityIndex)",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  // AQI Scale Indicator
                  PopupMenuButton<int>(
                    itemBuilder: (context) => aqiScale.entries.map((entry) {
                      return PopupMenuItem<int>(
                        value: entry.key,
                        child: Row(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              color: entry.value['color'],
                              margin: EdgeInsets.only(right: 8),
                            ),
                            Text("${entry.value['name']} (${entry.key})"),
                          ],
                        ),
                      );
                    }).toList(),
                    child: Icon(Icons.info_outline, color: Colors.grey),
                    onSelected: (value) {},
                  ),
                ],
              ),
            ),

            SizedBox(height: 16),

            // AQI Scale Color Bar
            Container(
              height: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: aqiScale.entries.map((entry) {
                  return Expanded(
                    child: Container(
                      color: entry.value['color'],
                      child: Center(
                        child: Text(
                          entry.key.toString(),
                          style: TextStyle(
                            color: entry.key > 3 ? Colors.white : Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
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

            SizedBox(height: 25),

            // Line Chart
            Container(
              height: 500,
              width: 500,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: true,
                    horizontalInterval: maxValue / 5,
                    verticalInterval: 1,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: Colors.grey.withOpacity(0.3),
                        strokeWidth: 1,
                      );
                    },
                    getDrawingVerticalLine: (value) {
                      return FlLine(
                        color: Colors.grey.withOpacity(0.3),
                        strokeWidth: 1,
                      );
                    },
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        interval: 1,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          if (index >= 0 && index < componentNames.length) {
                            return Text(
                              componentNames[index],
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.black,
                              ),
                            );
                          }
                          return const Text('');
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: maxValue / 5,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toInt().toString(),
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.black,
                            ),
                          );
                        },
                        reservedSize: 42,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(color: Colors.grey),
                  ),
                  minX: 0,
                  maxX: componentNames.length - 1,
                  minY: 0,
                  maxY: maxValue,
                  lineBarsData: [
                    LineChartBarData(
                      spots: List.generate(componentValues.length, (index) {
                        return FlSpot(index.toDouble(), componentValues[index]);
                      }),
                      isCurved: true,
                      gradient: LinearGradient(
                        colors: gradientColors,
                      ),
                      barWidth: 3,
                      isStrokeCapRound: true,
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) {
                          return FlDotCirclePainter(
                            radius: 4,
                            color: gradientColors[0],
                            strokeWidth: 2,
                            strokeColor: gradientColors[1],
                          );
                        },
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          colors: gradientColors
                              .map((color) => color.withOpacity(0.3))
                              .toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 25),

            Center(
              child: ElevatedButton(
                onPressed: () => Get.to(() => AirPollutionARPage()),
                child: Text("Gen Ar"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
