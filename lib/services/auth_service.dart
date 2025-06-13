
import 'dart:convert';
import 'package:app_gcm_sa/models/login_response.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final String _baseUrl = 'https://apihomologacao.santoandre.sp.gov.br/bdgm/api/v1';

  Future<LoginResponse> login(String usuario, String senha) async {
    final url = Uri.parse('$_baseUrl/login');
    
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'usuario': usuario,
        'senha': senha,
      }),
    );

    if (response.statusCode == 200) {
      return LoginResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Falha no login');
    }
  }
}