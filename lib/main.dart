// import 'package:flutter/material.dart';
// import 'package:recipe_project/homepage.dart';
// import 'Presentation/Routes/routes_generator.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: 'Flutter Demo',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         home: RouteGenerator());
//   }
// }

import 'package:flutter/material.dart';
import 'package:recipe_project/homepage.dart';
import 'Presentation/Routes/routes_generator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe Apps',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      // home: const MyHomePage(title: 'teststt'),
      initialRoute: "/",
      onGenerateRoute: RouteGenerator().generateRoute,
      routes: {'/homepage': (context) => const Homepage()},
    );
  }
}
