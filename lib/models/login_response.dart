class LoginResponse {
  final String token;
  final String expiration;
  final String codFuncionario;

  LoginResponse({
    required this.token,
    required this.expiration,
    required this.codFuncionario,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      token: json['token'],
      expiration: json['expiration'],
      codFuncionario: json['cod_funcionario'],
    );
  }
}
