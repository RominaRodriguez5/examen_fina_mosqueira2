import 'package:examen_fina_mosqueira2/screens/details_screen.dart';
import 'package:examen_fina_mosqueira2/service/resultService.dart';
import 'package:flutter/material.dart'; // Importa el paquete principal de Flutter para UI
import 'package:provider/provider.dart'; // Importa Provider para gestión de estado
import 'package:shared_preferences/shared_preferences.dart'; // Importa para manejo de preferencias compartidas

class HomeScreen extends StatefulWidget {
  // Define un widget con estado llamado HomeScreen
  const HomeScreen({super.key}); // Constructor con clave opcional

  @override
  State<HomeScreen> createState() => _HomeScreenState(); // Crea el estado asociado
}

class _HomeScreenState extends State<HomeScreen> {
  // Clase de estado para HomeScreen
  Future<void> logout() async {
    // Método para cerrar sesión
    final prefs =
        await SharedPreferences.getInstance(); // Obtiene instancia de preferencias
    await prefs.setBool('isLoggedIn', false); // Marca como no logueado
    Navigator.pushReplacementNamed(
      context,
      '/login',
    ); // Navega a pantalla de login
  }

  @override
  Widget build(BuildContext context) {
    // Método build para construir la UI
    final userService = Provider.of<ResultService>(
      context,
    ); // Obtiene el UserService del Provider

    return Scaffold(
      // Estructura principal de la pantalla
      backgroundColor: Colors.indigo[50], // Color de fondo
      appBar: AppBar(
        // Barra superior de la app
        automaticallyImplyLeading: false, // No muestra botón de retroceso
        title: const Text('Usuarios registrados'), // Título de la appbar
        actions: [
          // Acciones en la appbar
          IconButton(
            icon: const Icon(Icons.logout), // Icono de logout
            tooltip: 'Cerrar sesión', // Tooltip
            onPressed: logout, // Acción al pulsar: cerrar sesión
          ),
          IconButton(
            icon: const Icon(Icons.person_add), // Icono de añadir usuario
            tooltip: 'Añadir usuario', // Tooltip
            onPressed: () {
              // Acción al pulsar
              Navigator.pushNamed(
                context,
                '/new-user',
              ); // Navega a pantalla de nuevo usuario
            },
          ),
        ],
      ),
      body:
          userService
              .isLoading // Si está cargando usuarios
          ? const Center(
              child: CircularProgressIndicator(),
            ) // Muestra indicador de carga
          : ListView.builder(
              // Si no, muestra la lista de usuarios
              padding: const EdgeInsets.all(16), // Padding de la lista
              itemBuilder: (_, i) {
                // Construye cada elemento de la lista
                final presicion = userService.usuarios[i]; // Usuario actual
                return Card(
                  // Tarjeta para cada usuario
                  elevation: 4, // Sombra de la tarjeta
                  margin: const EdgeInsets.symmetric(
                    vertical: 10,
                  ), // Margen vertical
                  shape: RoundedRectangleBorder(
                    // Bordes redondeados
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    // Elemento de lista
                    contentPadding: const EdgeInsets.all(16), // Padding interno
                    leading: CircleAvatar(
                      // Avatar circular
                      radius: 30, // Radio del avatar
                      backgroundImage: NetworkImage(
                        presicion.image ?? '',
                      ), // Imagen del usuario
                      backgroundColor:
                          Colors.grey[300], // Color de fondo si no hay imagen
                      onBackgroundImageError: (_, __) => const Icon(
                        Icons.person,
                      ), // Icono por defecto si falla la imagen
                    ),
                    title: Text(
                      presicion.name, // Nombre del usuario
                      style: const TextStyle(
                        fontWeight: FontWeight.bold, // Negrita
                        fontSize: 18, // Tamaño de fuente
                      ),
                    ),
                    subtitle: Text(presicion.lspName), // Email del usuario
                    onTap: () {
                      // Al pulsar el elemento
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailScreen(
                            precision: presicion,
                          ), // Navega a detalle del usuario
                        ),
                      );
                    },
                    trailing: IconButton(
                      // Botón de eliminar usuario
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ), // Icono de eliminar
                      onPressed: () async {
                        // Acción al pulsar eliminar
                        final confirm = await showDialog<bool>(
                          // Muestra diálogo de confirmación
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text(
                              '¿Eliminar usuario?',
                            ), // Título del diálogo
                            content: const Text(
                              'Esta acción no se puede deshacer', // Mensaje de advertencia
                            ),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, false), // Cancela
                                child: const Text('Cancelar'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(
                                  context,
                                  true,
                                ), // Confirma eliminación
                                child: const Text('Eliminar'),
                              ),
                            ],
                          ),
                        );

                        if (confirm == true) {
                          // Si confirma eliminación
                          try {
                            await userService.deleteObject(
                              presicion as String,
                            ); // Elimina usuario
                            if (context.mounted) {
                              // Si el contexto sigue montado
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Usuario ${presicion.name} eliminado', // Mensaje de éxito
                                  ),
                                ),
                              );
                            }
                          } catch (e) {
                            // Si hay error
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Error: $e'),
                              ), // Muestra error
                            );
                          }
                        }
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
