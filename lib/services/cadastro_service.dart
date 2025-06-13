import 'dart:convert';
import 'package:http/http.dart' as http;

class CadastroService {
  final String _baseUrl =
      'https://apihomologacao.santoandre.sp.gov.br/bdgm/api/v1';

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
}
