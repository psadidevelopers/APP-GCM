import 'dart:convert';
import 'package:app_gcm_sa/utils/configuracoes.dart';
import 'package:http/http.dart' as http;

class EventosService {
  final String _baseUrl = Configuracoes.apiUrl;

  Future<List<dynamic>> getEventos(String codFuncionario, String token) async {
    final url = Uri.parse('$_baseUrl/eventos-voluntario/$codFuncionario');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      throw Exception(
        'Falha ao carregar os eventos. Status: ${response.statusCode}',
      );
    }
  }
}
