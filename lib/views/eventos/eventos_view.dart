import 'package:app_gcm_sa/components/card_nav_drawer_widget.dart';
import 'package:app_gcm_sa/utils/estilos.dart';
import 'package:flutter/material.dart';

class Event {
  final String title;
  final DateTime date;
  final bool isRead;

  Event({required this.title, required this.date, required this.isRead});

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      title: json['title']!, 
      date: DateTime.parse(json['date'] ?? DateTime.now().toIso8601String()),
      isRead: json['isRead'] ?? false,
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

  @override
  void initState() {
    super.initState();
    simulateFetch();
  }

  Future<void> simulateFetch() async {
    await Future.delayed(const Duration(seconds: 2));

    final List<Map<String, dynamic>> mockedApiData = [
      {
        'title': 'ESSE VC N LEU',
        'date': DateTime.now().toIso8601String(),
        'isRead': false,
      },
      {
        'title': 'ESSE VC LEU',
        'date': DateTime.now().subtract(const Duration(days: 1)).toIso8601String(),
        'isRead': true,
      },
      {
        'title': 'COISA RUN',
        'date': DateTime.now().subtract(const Duration(days: 2)).toIso8601String(),
        'isRead': false,
      },
      {
        'title': 'COISA BOA',
        'date': DateTime.now().subtract(const Duration(days: 3)).toIso8601String(),
        'isRead': true,
      },
    ];

    setState(() {
      events = mockedApiData.map((json) => Event.fromJson(json)).toList();
      _isLoading = false;
    });
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
                      ? const Center(child: CircularProgressIndicator(color: Estilos.azulClaro))
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