import 'package:app_gcm_sa/models/login_response.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SessionManager {
  final _storage = const FlutterSecureStorage();

  // Chaves para o armazenamento
  static const _keyToken = 'auth_token';
  static const _keyExpiration = 'auth_expiration';
  static const _keyCodFuncionario = 'auth_cod_funcionario';

  Future<void> saveSession(LoginResponse response) async {
    await _storage.write(key: _keyToken, value: response.token);
    await _storage.write(key: _keyExpiration, value: response.expiration);
    await _storage.write(
      key: _keyCodFuncionario,
      value: response.codFuncionario,
    );
  }

  Future<String?> getToken() async {
    return await _storage.read(key: _keyToken);
  }

  Future<void> clearSession() async {
    await _storage.deleteAll();
  }

  Future<String?> getCodFuncionario() async {
    return await _storage.read(key: _keyCodFuncionario);
  }

  Future<bool> isSessionValid() async {
    final token = await _storage.read(key: _keyToken);
    final expirationString = await _storage.read(key: _keyExpiration);

    // Se não houver token ou data de expiração, a sessão não é válida.
    if (token == null || expirationString == null) {
      return false;
    }

    try {
      // Converte a data de expiração para DateTime
      final expirationDate = DateTime.parse(expirationString);

      // Compara com a data e hora atuais
      if (expirationDate.isBefore(DateTime.now())) {
        // O token expirou. Limpa a sessão antiga e retorna inválido.
        await clearSession();
        return false;
      }

      // Se o token existe e não expirou, a sessão é válida.
      return true;
    } catch (e) {
      // Se houver erro ao parsear a data, a sessão é considerada inválida.
      await clearSession();
      return false;
    }
  }
}
