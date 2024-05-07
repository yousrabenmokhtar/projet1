import 'package:flutter/material.dart';
import 'package:flutter_application_3/custom_routes.dart'; 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

   routes:customRoutes,
   initialRoute: '/login',
);
        
  }
}