import 'package:app_gcm_sa/components/card_nav_drawer_widget.dart';
import 'package:app_gcm_sa/services/eventos_service.dart';
import 'package:app_gcm_sa/services/session_manager.dart';
import 'package:app_gcm_sa/utils/estilos.dart';
import 'package:flutter/material.dart';

class Event {
  final int idEventovoluntario;
  final int idEvento;
  final String titulo;
  final String data;
  final String nomeGuerra;
  final String categoriaCnh;
  final String viaturaPermitida;
  final String armaHabilitada;
  String leuNotificacaoEvento;

  Event({
    required this.idEventovoluntario,
    required this.idEvento,
    required this.titulo,
    required this.data,
    required this.nomeGuerra,
    required this.categoriaCnh,
    required this.viaturaPermitida,
    required this.armaHabilitada,
    required this.leuNotificacaoEvento,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      idEventovoluntario: json['id_eventovoluntario'] ?? 0,
      idEvento: json['id_evento'] ?? 0,
      titulo: json['dsc_titulo'] ?? 'Nenhum evento cadastrado aqui ainda!',
      data: json['data'],
      nomeGuerra: json['dsc_nome_guerra'] ?? 'N/A',
      categoriaCnh: json['dsc_categoria_cnh'] ?? 'N/A',
      viaturaPermitida: json['ind_viatura_permitida'] ?? 'N',
      armaHabilitada: json['ind_arma_habilitada'] ?? 'N',
      leuNotificacaoEvento: json['ind_leu_notificacao'] ?? 'N',
    );
  }
}

class EventosView extends StatefulWidget {
  const EventosView({super.key});

  @override
  State<EventosView> createState() => _EventosViewState();
}

class _EventosViewState extends State<EventosView> {
  List<Event> events = [];
  bool _isLoading = true;

  final EventosService _eventosService = EventosService();
  final SessionManager _sessionManager = SessionManager();

  @override
  void dispose() {
    // Chama a função de sincronização sem esperar (fire-and-forget)
    _sincronizarNotificacoesLidas();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _fetchEventos();
  }

  Future<void> _sincronizarNotificacoesLidas() async {
    List<Event> eventosRecemLidos =
        events
            .where(
              (event) =>
                  event.leuNotificacaoEvento == 'S' && event.idEvento > 0,
            )
            .toList();

    if (eventosRecemLidos.isEmpty) {
      return;
    }

    try {
      final token = await _sessionManager.getToken();
      if (token == null) return; // Não pode sincronizar sem token

      await _eventosService.marcarNotificacoesComoLidas(
        eventosRecemLidos,
        token,
      );
    } catch (e) {
      debugPrint(
        'Erro ao sincronizar notificações lidas: ${e.toString()}',
      );
    }
  }

  Future<void> _fetchEventos() async {
    try {
      final codFuncionario = await _sessionManager.getCodFuncionario();
      final token = await _sessionManager.getToken();

      if (codFuncionario == null || token == null) {
        throw Exception("Sessão inválida. Faça o login novamente.");
      }

      final List<dynamic> apiData = await _eventosService.getEventos(
        codFuncionario,
        token,
      );

      setState(() {
        events = apiData.map((json) => Event.fromJson(json)).toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao carregar os eventos: ${e.toString()}'),
          ),
        );
      }
    }
  }

  void _exibirDetalhesDoEvento(Event event) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: Text(
            event.titulo,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                _buildDetailRow(Icons.calendar_today, 'Data', event.data),
                _buildDetailRow(
                  Icons.person,
                  'Nome de Guerra',
                  event.nomeGuerra,
                ),
                _buildDetailRow(Icons.credit_card, 'CNH', event.categoriaCnh),
                _buildDetailRow(
                  Icons.directions_car,
                  'Viatura Permitida',
                  event.viaturaPermitida == 'S' ? 'Sim' : 'Não',
                ),
                _buildDetailRow(
                  Icons.shield,
                  'Arma Habilitada',
                  event.armaHabilitada == 'S' ? 'Sim' : 'Não',
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Fechar',
                style: TextStyle(
                  color: Estilos.azulClaro,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Widget auxiliar para criar as linhas de detalhe do modal
  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Estilos.azulClaro, size: 20),
          const SizedBox(width: 12),
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: Estilos.appbar(context, 'Eventos'),
          drawer: const NavigationDrawerWidget(),
          backgroundColor: Estilos.branco,
          body: Container(
            color: Estilos.azulGradient4,
            child: Container(
              height: double.infinity,
              decoration: const BoxDecoration(
                color: Estilos.branco,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child:
                  _isLoading
                      ? const Center(
                        child: CircularProgressIndicator(
                          color: Estilos.azulClaro,
                        ),
                      )
                      : ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        itemCount: events.length,
                        itemBuilder: (context, index) {
                          final event = events[index];
                          return Card(
                            color:
                                event.leuNotificacaoEvento == 'S' && event.idEvento > 0
                                    ? Colors.white
                                    : Colors.red.shade100,
                            elevation: 3,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(
                              title: Text(
                                event.titulo,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(event.data),
                              onTap: () {
                                // Marca o evento como lido e exibe o modal
                                if (event.leuNotificacaoEvento == 'N' &&
                                    event.idEvento > 0) {
                                  setState(() {
                                    event.leuNotificacaoEvento = 'S';
                                  });
                                }
                                if (event.idEvento > 0) {
                                  _exibirDetalhesDoEvento(event);
                                }
                              },
                            ),
                          );
                        },
                      ),
            ),
          ),
        ),
      ],
    );
  }
}
