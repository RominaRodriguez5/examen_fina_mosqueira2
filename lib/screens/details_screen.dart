import 'package:examen_fina_mosqueira2/models/result.dart';

import 'package:flutter/material.dart'; // Importa el paquete de widgets de Flutter

// Define un widget sin estado llamado DetailScreen
class DetailScreen extends StatelessWidget {
  final Result result; // Declara una variable final para almacenar el usuario

  // Constructor que recibe un usuario como parámetro requerido
  const DetailScreen({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    // Construye la interfaz de usuario
    return Scaffold(
      appBar: AppBar(
        title: Text(result.name),
      ), // Barra superior con el nombre del usuario
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20), // Padding alrededor del contenido
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Alinea los hijos al inicio
            children: [
              Center(),
              const SizedBox(height: 20), // Espacio vertical

              Text(
                'Nombre: ${result.name}', // Muestra el nombre
                style: const TextStyle(fontSize: 18), // Estilo de texto
              ),
              const SizedBox(height: 8), // Espacio vertical
              Text(
                'Tipo: ${result.launcher}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              Text(
                'Precio: ${result.net}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              Text(
                'Descripción: ${result.infographic}',
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
