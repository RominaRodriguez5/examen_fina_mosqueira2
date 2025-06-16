import 'package:examen_fina_mosqueira2/screens/home_screen.dart';
import 'package:examen_fina_mosqueira2/service/resultService.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:provider/provider.dart';

// PONER RUTAS AQUI

void main() {
  final prefs =
      await SharedPreferences.getInstance(); // Obtiene instancia de SharedPreferences
  final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  // Inicia la app con la ruta inicial
  runApp(AppState(initialRoute: '/home'));
}

// Widget que maneja el estado global de la app
class AppState extends StatelessWidget {
  final String initialRoute;

  const AppState({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ResultService()),
      ], // Proveedor para UserService
      child: MyApp(
        initialRoute: initialRoute,
      ), // Pasa la ruta inicial al widget principal
    );
  }
}

// Widget principal de la app
class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Examen Login JSON',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo), // Tema principal
      initialRoute: initialRoute, // Ruta inicial según login
      routes: {
        '/home': (_) => const HomeScreen(), // Pantalla principal
      },
    );
  }
}
