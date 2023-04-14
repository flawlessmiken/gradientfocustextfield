import 'package:flutter/material.dart';

import 'image_birthday.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       debugShowCheckedModeBanner: false,
//       // showPerformanceOverlay: true,
//       theme: ThemeData(
       
//         primarySwatch: Colors.blue,
//       ),
//       home: BirthdayImage(),
//     );
//   }
// }


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Birthday Image',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Birthday Image'),
        ),
        body: Center(
          child: BirthdayImage(),
        ),
      ),
    );
  }
}