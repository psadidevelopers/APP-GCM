import 'dart:convert';
import 'package:http/http.dart' as http;

class EventosService {
  final String _baseUrl =
      'https://apihomologacao.santoandre.sp.gov.br/bdgm/api/v1';

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
