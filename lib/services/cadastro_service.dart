import 'dart:convert';
import 'package:app_gcm_sa/utils/configuracoes.dart';
import 'package:http/http.dart' as http;

class CadastroService {
  final String _baseUrl = Configuracoes.apiUrl;

  Future<Map<String, dynamic>> getCadastro(
    String codFuncionario,
    String token,
  ) async {
    final url = Uri.parse('$_baseUrl/cadastro/$codFuncionario');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer $token', // <-- Enviando o token para autorização
      },
    );

    if (response.statusCode == 200) {
      // Usamos utf8.decode para garantir o parse correto de caracteres especiais (acentos, etc.)
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      throw Exception(
        'Falha ao carregar os dados do cadastro. Status: ${response.statusCode}',
      );
    }
  }

  Future<void> salvarCadastro(
    Map<String, dynamic> payload,
    String token,
  ) async {
    final url = Uri.parse('$_baseUrl/cadastro');

    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(payload),
    );

    if (response.statusCode == 204) {
      // Sucesso, não precisa retornar nada
      return;
    } else {
      throw Exception(
        'Falha ao salvar os dados. Status: ${response.statusCode}',
      );
    }
  }
}
