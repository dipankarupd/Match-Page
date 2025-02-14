import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:match/match_page.dart';
import 'package:match/participant_controller.dart';

void main() {
// Initialize GetX Controller globally
  Get.put(ParticipantController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        textTheme: ThemeData.dark().textTheme.apply(
              fontFamily: 'Jost',
            ),
      ),
      home: const MatchPage(),
    );
  }
}
