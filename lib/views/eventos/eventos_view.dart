import 'package:app_gcm_sa/components/card_nav_drawer_widget.dart';
import 'package:app_gcm_sa/services/eventos_service.dart';
import 'package:app_gcm_sa/services/session_manager.dart';
import 'package:app_gcm_sa/utils/estilos.dart';
import 'package:flutter/material.dart';

class Event {
  final int idEventovoluntario;
  final int idEvento;
  final String title;
  final DateTime date;
  final bool isRead;

  Event({
    required this.idEventovoluntario,
    required this.idEvento,
    required this.title,
    required this.date,
    required this.isRead,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      idEventovoluntario: json['id_eventovoluntario'] ?? 0,
      idEvento: json['id_evento'] ?? 0,
      title: json['dsc_titulo'] ?? 'Evento sem título',
      date: DateTime.parse(json['data'] ?? DateTime.now().toIso8601String()),
      isRead: true,
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
  void initState() {
    super.initState();
    _fetchEventos();
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

  String formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
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
                                event.isRead
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
                                event.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(formatDate(event.date)),
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
