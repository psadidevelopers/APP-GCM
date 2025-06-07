import 'package:app_gcm_sa/components/snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:app_gcm_sa/components/card_nav_drawer_widget.dart';
import 'package:app_gcm_sa/utils/estilos.dart';
import 'package:app_gcm_sa/utils/utils.dart';

class Disponibilidade {
  final String data;
  final String evento;

  Disponibilidade({required this.data, this.evento = ''});
}

class CadastroView extends StatefulWidget {
  const CadastroView({super.key});

  @override
  State<CadastroView> createState() => _CadastroViewState();
}

class _CadastroViewState extends State<CadastroView> {
  final _formKey = GlobalKey<FormState>();
  final List<Disponibilidade> _disponibilidades = [];

  final _identificacaoFuncionalController =
      TextEditingController();
  final _nomeCompletoController = TextEditingController();
  final _nomeGuerraController = TextEditingController();
  final _graduacaoController = TextEditingController();
  final _categoriaCnhController = TextEditingController();
  final _emailController = TextEditingController();
  final _turnoTrabalhoController = TextEditingController();
  final _telefoneCelularController =
      TextEditingController();
  final _disponibilidadeController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Estilos.appbar(context, 'Cadastro'),
      drawer: const NavigationDrawerWidget(),
      backgroundColor: Estilos.branco,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(color: Estilos.azulGradient4, height: 10),
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
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Estilos.cinzaClaro),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
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
                          borderSide: BorderSide(color: Estilos.cinzaClaro),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
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
                          borderSide: BorderSide(color: Estilos.cinzaClaro),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
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
                          borderSide: BorderSide(color: Estilos.cinzaClaro),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
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
                          borderSide: BorderSide(color: Estilos.cinzaClaro),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
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
                          borderSide: BorderSide(color: Estilos.cinzaClaro),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
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
                          borderSide: BorderSide(color: Estilos.cinzaClaro),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
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
                          borderSide: BorderSide(color: Estilos.cinzaClaro),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
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

                            if (novaData.isEmpty) return;

                            if (novaData.length != 10) return;

                            final existe = _disponibilidades.any(
                              (d) => d.data == novaData,
                            );

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
                              _disponibilidades.add(
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
                              _disponibilidades.map((dispo) {
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
                                            if (dispo.evento.isNotEmpty) {
                                              showCustomSnackbar(
                                                context,
                                                message:
                                                    'Evento já cadastrado nesta data.',
                                                backgroundColor:
                                                    Estilos.warning,
                                                textColor: Estilos.textWarning,
                                              );
                                            } else {
                                              setState(() {
                                                _disponibilidades.remove(dispo);
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
                                        child: Text(dispo.evento),
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
                          onPressed: () {},
                          child: const Text(
                            'Salvar',
                            style: TextStyle(color: Colors.white, fontSize: 16),
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
