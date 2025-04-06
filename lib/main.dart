import 'package:ar_ttt5/pages/air_pollution_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Air Pollution Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AR Air '),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () => Get.to(AqiInfoScreen()),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/image.png', // Add your own asset image
              height: 500,
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => Get.to(AirPollutionPage()),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 12.0),
                child:
                    Text("Check Air Pollution", style: TextStyle(fontSize: 18)),
              ),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () => Get.to(AqiInfoScreen()),
              child: Text("Learn about AQI Levels",
                  style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}

class AqiInfoScreen extends StatelessWidget {
  final List<Map<String, dynamic>> aqiLevels = [
    {
      'name': 'Good',
      'index': 1,
      'color': Colors.green,
      'ranges': {
        'SO₂': '[0; 20)',
        'NO₂': '[0; 40)',
        'PM₁₀': '[0; 20)',
        'PM₂.₅': '[0; 10)',
        'O₃': '[0; 60)',
        'CO': '[0; 4400)',
      }
    },
    {
      'name': 'Fair',
      'index': 2,
      'color': Colors.lightGreen,
      'ranges': {
        'SO₂': '[20; 80)',
        'NO₂': '[40; 70)',
        'PM₁₀': '[20; 50)',
        'PM₂.₅': '[10; 25)',
        'O₃': '[60; 100)',
        'CO': '[4400; 9400)',
      }
    },
    {
      'name': 'Moderate',
      'index': 3,
      'color': Colors.yellow,
      'ranges': {
        'SO₂': '[80; 250)',
        'NO₂': '[70; 150)',
        'PM₁₀': '[50; 100)',
        'PM₂.₅': '[25; 50)',
        'O₃': '[100; 140)',
        'CO': '[9400; 12400)',
      }
    },
    {
      'name': 'Poor',
      'index': 4,
      'color': Colors.orange,
      'ranges': {
        'SO₂': '[250; 350)',
        'NO₂': '[150; 200)',
        'PM₁₀': '[100; 200)',
        'PM₂.₅': '[50; 75)',
        'O₃': '[140; 180)',
        'CO': '[12400; 15400)',
      }
    },
    {
      'name': 'Very Poor',
      'index': 5,
      'color': Colors.red,
      'ranges': {
        'SO₂': '≥350',
        'NO₂': '≥200',
        'PM₁₀': '≥200',
        'PM₂.₅': '≥75',
        'O₃': '≥180',
        'CO': '≥15400',
      }
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AQI Information'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Air Quality Index (AQI) Scale',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'The AQI scale helps you understand air quality levels and associated health effects.',
              style: TextStyle(color: Colors.grey[600]),
            ),
            SizedBox(height: 20),

            // AQI Color Scale Bar
            Container(
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  )
                ],
              ),
              child: Row(
                children: aqiLevels.map((level) {
                  return Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: level['color'],
                        borderRadius: BorderRadius.horizontal(
                          left: level['index'] == 1
                              ? Radius.circular(8)
                              : Radius.zero,
                          right: level['index'] == 5
                              ? Radius.circular(8)
                              : Radius.zero,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '${level['index']}',
                          style: TextStyle(
                            color: level['index'] > 2
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: aqiLevels.map((level) {
                return Text(
                  level['name'],
                  style: TextStyle(
                    fontSize: 12,
                    color: level['color'],
                    fontWeight: FontWeight.bold,
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: 30),
            Text(
              'Pollutant Concentration Ranges (μg/m³)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15),

            // AQI Levels Table
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Table(
                border: TableBorder.symmetric(
                  inside: BorderSide(color: Colors.grey.shade300),
                ),
                columnWidths: const {
                  0: FlexColumnWidth(1.5),
                  1: FlexColumnWidth(1),
                  2: FlexColumnWidth(1),
                  3: FlexColumnWidth(1),
                  4: FlexColumnWidth(1),
                  5: FlexColumnWidth(1),
                  6: FlexColumnWidth(1),
                },
                children: [
                  // Table Header
                  TableRow(
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                    ),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text('Level',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text('SO₂',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text('NO₂',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text('PM₁₀',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text('PM₂.₅',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text('O₃',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text('CO',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  // Table Rows
                  ...aqiLevels.map((level) {
                    return TableRow(
                      decoration: BoxDecoration(
                        color: level['color'].withOpacity(0.1),
                      ),
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: level['color'],
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(level['name']),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(level['ranges']['SO₂']),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(level['ranges']['NO₂']),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(level['ranges']['PM₁₀']),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(level['ranges']['PM₂.₅']),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(level['ranges']['O₃']),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(level['ranges']['CO']),
                        ),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ),

            SizedBox(height: 20),
            Text(
              'Note: All values are in micrograms per cubic meter (μg/m³) except CO which is in micrograms per cubic meter (μg/m³)',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

// Your existing AirPollutionPage class would go here
