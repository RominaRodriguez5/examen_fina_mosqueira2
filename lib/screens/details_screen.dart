import 'package:examen_fina_mosqueira2/models/result.dart';
import 'package:flutter/material.dart'; // Importa el paquete de widgets de Flutter

class DetailScreen extends StatelessWidget {
  final Result precision;

  const DetailScreen({super.key, required this.precision});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[50],
      appBar: AppBar(
        title: const Text('Detalle de un lanzamiento'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.grey[300],
                backgroundImage: (precision.image?.isNotEmpty ?? false)
                    ? NetworkImage(precision.image!)
                    : null,
                child: (precision.image?.isEmpty ?? true)
                    ? const Icon(Icons.person, size: 60, color: Colors.white70)
                    : null,
              ),
            ),
            const SizedBox(height: 30),
            _buildDetailRow(
              Icons.verified_user,
              'Nombre del lanzamiento',
              precision.name,
            ),
            const SizedBox(height: 12),
            _buildDetailRow(Icons.email, 'descripcion', precision.lspName),
            const SizedBox(height: 12),
            _buildDetailRow(
              Icons.location_on,
              'Agencia responsable',
              precision.mission,
            ),
            const SizedBox(height: 12),
            _buildDetailRow(
              Icons.phone,
              'Fecha de lanzamiento',
              precision.net as String,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.indigo),
          const SizedBox(width: 12),
          Expanded(
            child: Text('$label: $value', style: const TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }
}
