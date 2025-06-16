import 'package:examen_fina_mosqueira2/models/result.dart';
import 'package:examen_fina_mosqueira2/service/resultService.dart';
import 'package:examen_fina_mosqueira2/widgets/card_lanzamiento.dart';
import 'package:flutter/material.dart';

// Pantalla principal tras login. Muestra la lista de usuarios.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  Future<List<Result>> _loadPlatos() async {
    final service = ResultService(); // o Provider.of(...) si lo inyectas
    return await service.usuarios;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cohetes')),
      // 📦 Carga de usuarios desde Firebase usando FutureBuilder
      body: FutureBuilder<List<Result>>(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay platos disponibles'));
          }

          final platos = snapshot.data!;

          return ListView.builder(
            itemCount: platos.length,
            itemBuilder: (context, index) {
              return PlatoCardWidget.PlatoCardWidget(
                result: platos[index].netPrecision,
                id: platos[index].id,
                onRefresh: () => setState(() {
                  // 🔄 refresca la lista
                }),
              );
            },
          );
        },
        future: null,
      ),
      backgroundColor: Colors.tealAccent,
    );
  }
}
