// import 'package:ar_ttt5/earth_ar.dart';
// import 'package:ar_ttt5/my_earth.dart';
// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: 'Flutter Demo',
//         theme: ThemeData(
//           // This is the theme of your application.
//           //
//           // TRY THIS: Try running your application with "flutter run". You'll see
//           // the application has a purple toolbar. Then, without quitting the app,
//           // try changing the seedColor in the colorScheme below to Colors.green
//           // and then invoke "hot reload" (save your changes or press the "hot
//           // reload" button in a Flutter-supported IDE, or press "r" if you used
//           // the command line to start the app).
//           //
//           // Notice that the counter didn't reset back to zero; the application
//           // state is not lost during the reload. To reset the state, use hot
//           // restart instead.
//           //
//           // This works for code too, not just values: Most code changes can be
//           // tested with just a hot reload.
//           colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//           useMaterial3: true,
//         ),
//         home: MyEarth_AR());
//   }
// }

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
      appBar: AppBar(title: Text('Air Pollution Tracker')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Get.to(AirPollutionPage()),
          child: Text("Check Air Pollution"),
        ),
      ),
    );
  }
}
