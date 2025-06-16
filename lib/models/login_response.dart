class LoginResponse {
  final String token;
  final String expiration;
  final String codFuncionario;
  final String dscNomeFuncionario;

  LoginResponse({
    required this.token,
    required this.expiration,
    required this.codFuncionario,
    required this.dscNomeFuncionario,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      token: json['token'],
      expiration: json['expiration'],
      codFuncionario: json['cod_funcionario'],
      dscNomeFuncionario: json['dsc_nome_funcionario'],
    );
  }
}
