import 'package:flutter/material.dart';
import 'package:legal/provider/category_provider.dart';
import 'package:provider/provider.dart';

import 'provider/legal_provider.dart';
import 'pages/legal/legal_main_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [

        ChangeNotifierProvider(
          create: (_) => LegalProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CategoryProvider(),
        ),
      ],

      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Legal ERP',

      theme: ThemeData(
        fontFamily: 'Poppins',
        useMaterial3: true,
      ),

      home: const LegalMainPage(),
      
    );
  }
}