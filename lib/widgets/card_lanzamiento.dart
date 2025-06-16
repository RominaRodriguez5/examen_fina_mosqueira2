import 'package:examen_fina_mosqueira2/models/result.dart';
import 'package:examen_fina_mosqueira2/screens/details_screen.dart';
import 'package:examen_fina_mosqueira2/service/resultService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// 🧩 Tarjeta visual que representa un usuario en la lista
// Muestra la foto, nombre, email, teléfono, y permite editar o eliminar
class Card_lanzamiento extends StatelessWidget {
  final Result heroe; // Objeto de datos del usuario
  final String id; // ID del nodo en Firebase
  final VoidCallback onRefresh; // 🔄 callback para refrescar

  const Card_lanzamiento.Card_lanzamiento({
    super.key,
    required this.heroe,
    required this.id,
    required this.onRefresh,
    required Result result,
  });

  // ❌ Método para confirmar y eliminar el heroe
  void _confirmDelete(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar heroe'),
        content: const Text('¿Estás seguro de que deseas eliminar este heroe?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final service = Provider.of<ResultService>(context, listen: false);

      // ✅ Llamamos al callback para refrescar la lista
      onRefresh();

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Heroe eliminado')));
    }
  }

  // ✏️ Navega al formulario para editar este heroe
  void _editHeroe(BuildContext context) {
    Navigator.pushNamed(
      context,
      'heroe_form',
      arguments: {'id': id, 'heroe': heroe},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.grey[850],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 6,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailScreen(result: heroe),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        child: ListTile(
          // Foto circular del heroe
          leading: CircleAvatar(backgroundImage: NetworkImage(heroe.image)),

          // Nombre principal
          title: Text(heroe.name, style: const TextStyle(color: Colors.white)),

          // Correo y teléfono en dos líneas
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                heroe.missionType,
                style: const TextStyle(color: Colors.white70),
              ),
            ],
          ),

          isThreeLine: true, // permite espacio para 3 líneas de texto
          // Botones de editar y eliminar alineados a la derecha
          trailing: Wrap(
            spacing: 12,
            children: [
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.amber),
                onPressed: () => _editHeroe(context),
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.redAccent),
                onPressed: () => _confirmDelete(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
