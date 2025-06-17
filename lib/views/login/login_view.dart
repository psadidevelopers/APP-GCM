import 'package:app_gcm_sa/components/snackbar_widget.dart';
import 'package:app_gcm_sa/services/auth_service.dart';
import 'package:app_gcm_sa/services/session_manager.dart';
import 'package:app_gcm_sa/utils/configuracoes.dart';
import 'package:app_gcm_sa/utils/estilos.dart';
import 'package:app_gcm_sa/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool _obscureText = true;
  bool _isLoading = false;
  String environment = Configuracoes.environment;

  final _formKey = GlobalKey<FormState>();
  final _cpfController = TextEditingController();
  final _senhaController = TextEditingController();

  final AuthService _authService = AuthService();
  final SessionManager _sessionManager = SessionManager();

  String? _validaLogin(String? texto) {
    if (texto!.isEmpty) {
      return "Digite o CPF";
    }
    return null;
  }

  String? _validaSenha(String? texto) {
    if (texto!.isEmpty) {
      return "Digite a Senha";
    }
    return null;
  }

  Future<void> _performLogin() async {
    // Valida o formulário
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      final response = await _authService.login(
        _cpfController.text,
        _senhaController.text,
      );

      // Salva a sessão se o login for bem-sucedido
      await _sessionManager.saveSession(response);

      // Navega para a home (usando 'mounted' para segurança)
      if (mounted) {
        context.go("/home");
      }
    } catch (e) {
      // Se a API falhar (qualquer status != 200), mostra o snackbar
      if (mounted) {
        showCustomSnackbar(
          context,
          message: 'CPF ou senha incorretas.',
          backgroundColor: Estilos.danger,
          textColor: Estilos.textDanger,
        );
      }
    } finally {
      // Garante que o loading seja desativado, mesmo se houver erro
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _cpfController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Image.asset(
                            'assets/imagens/marca_psa_horizontal.png',
                            width: 150,
                            height: 38,
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.fromLTRB(16, 60, 8, 30),
                        child: Text(
                          'Acessar',
                          style: Utils.safeGoogleFont(
                            'Comfortaa',
                            fontSize: 22,
                            fontWeight: FontWeight.w400,
                            color: Estilos.preto,
                          ),
                        ),
                      ),

                      Container(
                        height: 75,
                        padding: const EdgeInsets.only(
                          left: 15.0,
                          right: 15.0,
                          top: 0,
                          bottom: 0,
                        ),
                        child: TextFormField(
                          autofocus: true,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          controller: _cpfController,
                          validator: _validaLogin,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Estilos.cinzaClaro),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            labelText: 'CPF:',
                            hintText: 'Digite seu CPF',
                          ),
                          onChanged: (value) {
                            if (value.length == 14) {
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          style: Utils.safeGoogleFont(
                            'Roboto',
                            fontWeight: FontWeight.w400,
                            color: Estilos.preto,
                          ),
                        ),
                      ),

                      Container(
                        margin: const EdgeInsets.only(top: 25),
                        height: 75,
                        padding: const EdgeInsets.only(
                          left: 15.0,
                          right: 15.0,
                          top: 0,
                          bottom: 0,
                        ),
                        child: TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: _obscureText,
                          controller: _senhaController,
                          validator: _validaSenha,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Estilos.cinzaClaro),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            labelText: 'Senha:',
                            hintText: 'Digite a Senha',
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              icon:
                                  _obscureText
                                      ? const Icon(Icons.visibility_off)
                                      : const Icon(Icons.visibility),
                            ),
                          ),
                          style: Utils.safeGoogleFont(
                            'Roboto',
                            fontWeight: FontWeight.w400,
                            color: Estilos.preto,
                          ),
                        ),
                      ),
                      Text(
                        environment,
                        style: Utils.safeGoogleFont(
                          color: Estilos.vermelho,
                          fontSize: 14,
                          'Roboto',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Center(
                    child: Container(
                      width: double.infinity,
                      height: 52,
                      decoration: BoxDecoration(
                        border: Border.all(color: Estilos.cinzaClaro),
                        color: Estilos.preto,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Estilos.preto,
                          textStyle: const TextStyle(
                            color: Estilos.branco,
                            fontSize: 16,
                          ),
                        ),
                        onPressed:
                            _isLoading
                                ? null
                                : _performLogin, // <-- AQUI ESTÁ A MUDANÇA

                        child:
                            _isLoading
                                ? const Center(
                                  child: CircularProgressIndicator(
                                    color: Estilos.branco,
                                  ),
                                )
                                : const Text(
                                  'Entrar',
                                  style: TextStyle(color: Estilos.branco),
                                ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
