import 'dart:convert';
import 'package:app_gcm_sa/models/login_response.dart';
import 'package:app_gcm_sa/utils/configuracoes.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final String _baseUrl = Configuracoes.apiUrl;

  Future<LoginResponse> login(String usuario, String senha) async {
    final url = Uri.parse('$_baseUrl/login');
    const int maxRetries = 5;

    for (int attempt = 1; attempt <= maxRetries; attempt++) {
      try {
        final response = await http
            .post(
              url,
              headers: {'Content-Type': 'application/json'},
              body: jsonEncode({'usuario': usuario, 'senha': senha}),
            )
            .timeout(const Duration(seconds: 15));

        if (response.statusCode == 200) {
          return LoginResponse.fromJson(jsonDecode(response.body));
        } else if (response.statusCode >= 400 && response.statusCode < 500) {
          throw Exception('Usuário ou senha incorretos.');
        } else {
          throw Exception('Erro no servidor: ${response.statusCode}');
        }
      } catch (e) {
        if (attempt < maxRetries) {
          final delay = Duration(seconds: attempt);
          await Future.delayed(delay);
        } else {
          throw Exception(
            'Não foi possível conectar ao servidor. Verifique sua conexão e tente mais tarde.',
          );
        }
      }
    }

    throw Exception('Falha inesperada no processo de login.');
  }
}
