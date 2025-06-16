// 🧩 Tarjeta visual que representa un usuario en la lista
// Muestra la foto, nombre, email, teléfono, y permite editar o eliminar
import 'package:flutter/material.dart';

class PlatoCardWidget extends StatelessWidget {
  final plato; // Objeto de datos del usuario
  final String id; // ID del nodo en Firebase
  final VoidCallback onRefresh; // 🔄 callback para refrescar
  final bool offlineMode; // Indica si estamos en modo online o offline

  const PlatoCardWidget.PlatoCardWidget({
    super.key,
    required this.plato,
    required this.id,
    required this.onRefresh,
    required this.offlineMode,
  });

  // ❌ Método para confirmar y eliminar el usuario
  void _confirmDelete(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar plato'),
        content: const Text('¿Estás seguro de que deseas eliminar este plato?'),
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
      final service = Provider.of<BeeceptorPlatoService>(
        context,
        listen: false,
      );
      print('Eliminando plato: $id');
      await service.deletePlato(id, plato, isOnline: offlineMode);

      // ✅ Llamamos al callback para refrescar la lista
      onRefresh();

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Plato eliminado')));
    }
  }

  // ✏️ Navega al formulario para editar este usuario
  void _editPlato(BuildContext context) {
    Navigator.pushNamed(
      context,
      'plato_form',
      arguments: {'id': id, 'plato': plato},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.grey[850],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 6,
      child: ListTile(
        // Foto circular del usuario
        leading: CircleAvatar(backgroundImage: NetworkImage(plato.foto)),

        // Nombre principal
        title: Text(plato.nombre, style: const TextStyle(color: Colors.white)),

        // Correo y teléfono en dos líneas
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              plato.descripcion,
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
              onPressed: () => _editPlato(context),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.redAccent),
              onPressed: () => _confirmDelete(context),
            ),
          ],
        ),
      ),
    );
  }
}
