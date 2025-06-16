import 'package:examen_fina_mosqueira2/models/result.dart';
import 'package:flutter/material.dart';

// 🧾 Pantalla que sirve para crear o editar usuarios
class lanzamientoFormScreen extends StatefulWidget {
  const lanzamientoFormScreen({super.key});

  @override
  State<lanzamientoFormScreen> createState() => _lanzamientoFormScreenState();
}

class _lanzamientoFormScreenState extends State<lanzamientoFormScreen> {
  // 🔧 Clave del formulario y controladores para cada campo
  var _id = TextEditingController();
  final _descriptionController = TextEditingController();
  final _nameController = TextEditingController();
  final _precioController = TextEditingController();

  // 📦 Recupera los argumentos pasados por Navigator (si los hay)
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (args != null) {
      _id = args['id']; // se guarda el id para hacer update

      if (args.containsKey('lanzamiento') && args['lanzamiento'] != null) {
        final Result result = args[''];
        _descriptionController.text = result.lspName;
        _nameController.text = result.name;
        _precioController.text = result.net as String;
      }
    }
  }

  // ✅ Función que valida y guarda el usuario (nuevo o editado)
  Future<void> _submit() async {
    if (_id.value.isComposingRangeValid) {
      Navigator.pop(context); // 🔙 Volver a la pantalla anterior
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = _id != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Editar Heroe' : 'Nuevo Heroe')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          child: ListView(
            children: [
              _buildTextField(_nameController, 'Nombre', true),
              const SizedBox(height: 12),
              _buildTextField(_descriptionController, 'Descripción', false),
              const SizedBox(height: 12),
              _buildTextField(_precioController, 'Precio', true),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _submit,
                child: Text(isEditing ? 'Actualizar' : 'Crear'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🧱 Método que construye campos reutilizables con validación
  Widget _buildTextField(
    TextEditingController controller,
    String label,
    bool required, {
    bool fecha = false,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      validator: (value) {
        if (required && (value == null || value.trim().isEmpty)) {
          return 'Este campo es obligatorio';
        }
        if (fecha) {
          final emailRegex = RegExp(
            r'(\d{4}-?\d\d-?\d\d(\s|T)\d\d:?\d\d:?\d\d)',
          );
          ;
          if (!emailRegex.hasMatch(value!)) {
            return 'Correo no válido';
          }
        }
        return null;
      },
    );
  }
}
