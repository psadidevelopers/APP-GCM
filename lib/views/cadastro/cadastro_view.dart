import 'package:app_gcm_sa/components/snackbar_widget.dart';
import 'package:app_gcm_sa/utils/estilos.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:app_gcm_sa/components/card_nav_drawer_widget.dart';
import 'package:app_gcm_sa/utils/utils.dart';

class Disponibilidade {
  final String data;
  final String? evento;

  Disponibilidade({required this.data, this.evento = ''});

  factory Disponibilidade.fromJson(Map<String, dynamic> json) {
    return Disponibilidade(data: json['data'] ?? '', evento: json['evento']);
  }
}

class CadastroData {
  String identificacaoFuncional;
  String nomeCompleto;
  String nomeGuerra;
  String graduacao;
  String categoriaCnh;
  String email;
  String turnoTrabalho;
  String telefoneCelular;
  List<Disponibilidade> disponibilidades;

  CadastroData({
    required this.identificacaoFuncional,
    required this.nomeCompleto,
    required this.nomeGuerra,
    required this.graduacao,
    required this.categoriaCnh,
    required this.email,
    required this.turnoTrabalho,
    required this.telefoneCelular,
    required this.disponibilidades,
  });

  factory CadastroData.fromJson(Map<String, dynamic> json) {
    var disponibilidadesFromJson = json['disponibilidades'] as List? ?? [];
    List<Disponibilidade> disponibilidadeList =
        disponibilidadesFromJson
            .map((i) => Disponibilidade.fromJson(i))
            .toList();

    return CadastroData(
      identificacaoFuncional: json['identificacaoFuncional'] ?? '',
      nomeCompleto: json['nomeCompleto'] ?? '',
      nomeGuerra: json['nomeGuerra'] ?? '',
      graduacao: json['graduacao'] ?? '',
      categoriaCnh: json['categoriaCnh'] ?? '',
      email: json['email'] ?? '',
      turnoTrabalho: json['turnoTrabalho'] ?? '',
      telefoneCelular: json['telefoneCelular'] ?? '',
      disponibilidades: disponibilidadeList,
    );
  }
}

class CadastroView extends StatefulWidget {
  const CadastroView({super.key});

  @override
  State<CadastroView> createState() => _CadastroViewState();
}

class _CadastroViewState extends State<CadastroView> {
  final _formKey = GlobalKey<FormState>();

  CadastroData? _cadastroData;
  bool _isLoading = true;

  final _identificacaoFuncionalController = TextEditingController();
  final _nomeCompletoController = TextEditingController();
  final _nomeGuerraController = TextEditingController();
  final _graduacaoController = TextEditingController();
  final _categoriaCnhController = TextEditingController();
  final _emailController = TextEditingController();
  final _turnoTrabalhoController = TextEditingController();
  final _telefoneCelularController = TextEditingController();
  final _disponibilidadeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchCadastroData();
  }

  Future<void> _fetchCadastroData() async {
    await Future.delayed(const Duration(seconds: 2));

    final mockedData = {
      'identificacaoFuncional': '54321',
      'nomeCompleto': 'Maria Oliveira Souza',
      'nomeGuerra': 'GCM Oliveira',
      'graduacao': 'GCM 1ª Classe',
      'categoriaCnh': 'AD',
      'email': 'maria.oliveira@gcm.sa.gov.br',
      'turnoTrabalho': 'Noturno 12x36',
      'telefoneCelular': '(11) 91234-5678',
      'disponibilidades': [
        {'data': '20/06/2025', 'evento': 'COISARUN'},
        {'data': '29/06/2025', 'evento': null},
        {'data': '09/07/2025', 'evento': 'Feriado Estadual'},
      ],
    };

    final data = CadastroData.fromJson(mockedData);

    setState(() {
      _cadastroData = data;

      _identificacaoFuncionalController.text = data.identificacaoFuncional;
      _nomeCompletoController.text = data.nomeCompleto;
      _nomeGuerraController.text = data.nomeGuerra;
      _graduacaoController.text = data.graduacao;
      _categoriaCnhController.text = data.categoriaCnh;
      _emailController.text = data.email;
      _turnoTrabalhoController.text = data.turnoTrabalho;
      _telefoneCelularController.text = data.telefoneCelular;

      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _identificacaoFuncionalController.dispose();
    _nomeCompletoController.dispose();
    _nomeGuerraController.dispose();
    _graduacaoController.dispose();
    _categoriaCnhController.dispose();
    _emailController.dispose();
    _turnoTrabalhoController.dispose();
    _telefoneCelularController.dispose();
    _disponibilidadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Estilos.appbar(context, 'Cadastro'),
      drawer: const NavigationDrawerWidget(),
      backgroundColor: Estilos.branco,
      body:
          _isLoading
              ? const Center(
                child: CircularProgressIndicator(color: Estilos.azulClaro),
              )
              : SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(
                          color: Estilos.branco,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Dados Operacionais',
                              style: Utils.safeGoogleFont(
                                'Roboto',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Estilos.preto,
                              ),
                            ),
                            const SizedBox(height: 16),

                            TextFormField(
                              controller: _identificacaoFuncionalController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Estilos.cinzaClaro,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                labelText: 'Identificação Funcional',
                              ),
                              style: Utils.safeGoogleFont(
                                'Roboto',
                                fontWeight: FontWeight.w400,
                                color: Estilos.preto,
                              ),
                            ),
                            const SizedBox(height: 16),

                            TextFormField(
                              controller: _nomeCompletoController,
                              decoration: const InputDecoration(
                                labelText: 'Nome Completo',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Estilos.cinzaClaro,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                              style: Utils.safeGoogleFont(
                                'Roboto',
                                fontWeight: FontWeight.w400,
                                color: Estilos.preto,
                              ),
                            ),
                            const SizedBox(height: 16),

                            TextFormField(
                              controller: _nomeGuerraController,
                              decoration: const InputDecoration(
                                labelText: 'Nome de Guerra',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Estilos.cinzaClaro,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                              style: Utils.safeGoogleFont(
                                'Roboto',
                                fontWeight: FontWeight.w400,
                                color: Estilos.preto,
                              ),
                            ),
                            const SizedBox(height: 16),

                            TextFormField(
                              controller: _graduacaoController,
                              decoration: const InputDecoration(
                                labelText: 'Graduação',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Estilos.cinzaClaro,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                              style: Utils.safeGoogleFont(
                                'Roboto',
                                fontWeight: FontWeight.w400,
                                color: Estilos.preto,
                              ),
                            ),
                            const SizedBox(height: 16),

                            TextFormField(
                              controller: _categoriaCnhController,
                              decoration: const InputDecoration(
                                labelText: 'Categoria CNH',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Estilos.cinzaClaro,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                              style: Utils.safeGoogleFont(
                                'Roboto',
                                fontWeight: FontWeight.w400,
                                color: Estilos.preto,
                              ),
                            ),
                            const SizedBox(height: 16),

                            TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                labelText: 'E-mail',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Estilos.cinzaClaro,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                              style: Utils.safeGoogleFont(
                                'Roboto',
                                fontWeight: FontWeight.w400,
                                color: Estilos.preto,
                              ),
                            ),
                            const SizedBox(height: 16),

                            TextFormField(
                              controller: _turnoTrabalhoController,
                              decoration: const InputDecoration(
                                labelText: 'Turno atual de trabalho',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Estilos.cinzaClaro,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                              style: Utils.safeGoogleFont(
                                'Roboto',
                                fontWeight: FontWeight.w400,
                                color: Estilos.preto,
                              ),
                            ),
                            const SizedBox(height: 16),

                            TextFormField(
                              controller: _telefoneCelularController,
                              keyboardType: TextInputType.phone,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                TelefoneInputFormatter(),
                              ],
                              decoration: const InputDecoration(
                                labelText: 'Telefone Celular',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Estilos.cinzaClaro,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                              style: Utils.safeGoogleFont(
                                'Roboto',
                                fontWeight: FontWeight.w400,
                                color: Estilos.preto,
                              ),
                            ),

                            const Divider(height: 40, thickness: 1),

                            Text(
                              'Disponibilidade',
                              style: Utils.safeGoogleFont(
                                'Roboto',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Estilos.preto,
                              ),
                            ),
                            const SizedBox(height: 16),

                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: _disponibilidadeController,
                                    keyboardType: TextInputType.datetime,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      DataInputFormatter(),
                                    ],
                                    decoration: const InputDecoration(
                                      labelText: 'Data de disponibilidade',
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Estilos.cinzaClaro,
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                    ),
                                    style: Utils.safeGoogleFont(
                                      'Roboto',
                                      fontWeight: FontWeight.w400,
                                      color: Estilos.preto,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                ElevatedButton(
                                  onPressed: () {
                                    final novaData =
                                        _disponibilidadeController.text.trim();

                                    // 1. Basic format and length validation
                                    if (novaData.isEmpty ||
                                        novaData.length != 10) {
                                      showCustomSnackbar(
                                        context,
                                        message:
                                            'Formato de data inválido. Use DD/MM/AAAA.',
                                        backgroundColor: Estilos.danger,
                                        textColor: Estilos.textDanger,
                                      );
                                      return;
                                    }

                                    DateTime parsedDate;
                                    try {
                                      // 2. Validate if the date is real (e.g., not 99/99/9999 or 30/02/2025)
                                      final parts = novaData.split(
                                        '/',
                                      ); // [dd, MM, yyyy]
                                      if (parts.length != 3) {
                                        throw const FormatException(
                                          'Invalid format',
                                        );
                                      }

                                      final day = int.parse(parts[0]);
                                      final month = int.parse(parts[1]);
                                      final year = int.parse(parts[2]);

                                      parsedDate = DateTime(year, month, day);

                                      // DateTime can be lenient (e.g., 30/02 becomes 02/03). This check ensures it's exact.
                                      if (parsedDate.day != day ||
                                          parsedDate.month != month ||
                                          parsedDate.year != year) {
                                        throw const FormatException(
                                          'Date does not exist.',
                                        );
                                      }
                                    } catch (e) {
                                      showCustomSnackbar(
                                        context,
                                        message:
                                            'Data inválida. Verifique o dia, mês e ano.',
                                        backgroundColor: Estilos.danger,
                                        textColor: Estilos.textDanger,
                                      );
                                      return;
                                    }

                                    final now = DateTime.now();
                                    final today = DateTime(
                                      now.year,
                                      now.month,
                                      now.day,
                                    );

                                    if (parsedDate.isBefore(today)) {
                                      showCustomSnackbar(
                                        context,
                                        message:
                                            'Não é possível inserir uma data anterior a hoje.',
                                        backgroundColor: Estilos.danger,
                                        textColor: Estilos.textDanger,
                                      );
                                      return;
                                    }

                                    final existe = _cadastroData!
                                        .disponibilidades
                                        .any((d) => d.data == novaData);

                                    if (existe) {
                                      showCustomSnackbar(
                                        context,
                                        message: 'Data já inserida.',
                                        backgroundColor: Estilos.danger,
                                        textColor: Estilos.textDanger,
                                      );
                                      return;
                                    }

                                    setState(() {
                                      _cadastroData!.disponibilidades.add(
                                        Disponibilidade(data: novaData),
                                      );
                                      _disponibilidadeController.clear();
                                    });
                                  },
                                  child: const Icon(Icons.add),
                                ),
                              ],
                            ),

                            const SizedBox(height: 16),

                            SizedBox(
                              width: double.infinity,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: DataTable(
                                  columnSpacing: 24,
                                  horizontalMargin: 16,
                                  columns: const [
                                    DataColumn(
                                      label: SizedBox(
                                        width: 60,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Ações',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: SizedBox(
                                        width: 150,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Data Disponibilidade',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: SizedBox(
                                        width: 120,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Evento',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                  rows:
                                      _cadastroData!.disponibilidades.map((
                                        dispo,
                                      ) {
                                        return DataRow(
                                          cells: [
                                            DataCell(
                                              Align(
                                                alignment: Alignment.center,
                                                child: IconButton(
                                                  icon: const Icon(
                                                    Icons.delete,
                                                    color: Estilos.vermelho,
                                                  ),
                                                  onPressed: () {
                                                    if (dispo.evento != null &&
                                                        dispo
                                                            .evento!
                                                            .isNotEmpty) {
                                                      showCustomSnackbar(
                                                        context,
                                                        message:
                                                            'Não é possível remover data com evento associado.',
                                                        backgroundColor:
                                                            Estilos.warning,
                                                        textColor:
                                                            Estilos.textWarning,
                                                      );
                                                    } else {
                                                      setState(() {
                                                        _cadastroData!
                                                            .disponibilidades
                                                            .remove(dispo);
                                                      });
                                                    }
                                                  },
                                                ),
                                              ),
                                            ),
                                            DataCell(
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(dispo.data),
                                              ),
                                            ),
                                            DataCell(
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(dispo.evento ?? ''),
                                              ),
                                            ),
                                          ],
                                        );
                                      }).toList(),
                                ),
                              ),
                            ),

                            const SizedBox(height: 32),

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
                                  ),
                                  onPressed: () {
                                    showCustomSnackbar(
                                      context,
                                      message: 'Salvo com sucesso!',
                                    );
                                  },
                                  child: const Text(
                                    'Salvar',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
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
              ),
    );
  }
}
