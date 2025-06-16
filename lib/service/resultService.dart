import 'dart:convert';
import 'package:examen_fina_mosqueira2/models/result.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ResultService extends ChangeNotifier {
  // Pega aquí tu URL de crudcrud.com (sustituye <tu-token>):
  static const _baseUrl =
      'https://lldev.thespacedevs.com/2.2.0/launch/upcoming/?mode=list';
  final List<Result> usuarios = [];
  bool isLoading = true;

  // Obtiene el listado completo
  Future<List<Result>> fetchObjects() async {
    final resp = await http.get(Uri.parse(_baseUrl));
    if (resp.statusCode == 200) {
      final List list = json.decode(resp.body);
      return list.map((json) => Result.fromJson(json)).toList();
    } else {
      throw Exception('Error cargando objetos');
    }
  }

  // Crea un nuevo objeto
  Future<Result> createObject(Result obj) async {
    final resp = await http.post(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(obj.toJson()),
    );
    if (resp.statusCode == 201) {
      return Result.fromJson(json.decode(resp.body));
    } else {
      throw Exception('Error creando objeto');
    }
  }

  // Borra un objeto por ID
  Future<void> deleteObject(String id) async {
    final resp = await http.delete(Uri.parse('$_baseUrl/$id'));
    if (resp.statusCode != 200) {
      throw Exception('Error borrando objeto');
    }
  }
}
