import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/provider/post_provider.dart';
import 'package:social_app/screens/splash_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => PostProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const babyPink = Color.fromARGB(255, 239, 93, 115);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Social App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: babyPink),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}

