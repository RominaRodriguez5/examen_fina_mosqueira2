// Importaciones principales
import 'package:examen_fina_mosqueira2/service/resultService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AppState(initialRoute: 'Home'));
}

class AppState extends StatelessWidget {
  final String initialRoute; // Ruta inicial al abrir la app
  const AppState({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ResultService())],
      child: MyApp(initialRoute: initialRoute),
    );
  }
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Api + SharedPrefs',
      debugShowCheckedModeBanner: false,

      // 🌙 Tema oscuro elegante para toda la app
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.grey[900], // fondo general
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(), // bordes en inputs
          labelStyle: TextStyle(color: Colors.white), // texto de etiquetas
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white), // texto general
        ),
        checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStatePropertyAll(
            Colors.tealAccent,
          ), // color del check
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(
              Colors.tealAccent,
            ), // fondo botón
            foregroundColor: MaterialStatePropertyAll(
              Colors.black,
            ), // texto botón
          ),
        ),
      ),

      // 🏁 Pantalla inicial al abrir la app
      initialRoute: 'Home',

      // 📍 Definición de rutas nombradas
      routes: {
        // 🔐 Login con validación y persistencia
        'Home': (_) => const HomeScreen(),

        // ➕ Formulario para crear o editar usuarios
        //'plato_form': (_) => const PlatoFormScreen(),
      },
    );
  }
}
