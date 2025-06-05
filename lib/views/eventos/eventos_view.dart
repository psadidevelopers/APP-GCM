import 'package:app_gcm_sa/components/card_nav_drawer_widget.dart';
import 'package:app_gcm_sa/utils/estilos.dart';
import 'package:flutter/material.dart';

class Event {
  final String title;
  final DateTime date;
  final bool isRead;

  Event({required this.title, required this.date, required this.isRead});
}

class EventosView extends StatefulWidget {
  const EventosView({super.key});

  @override
  State<EventosView> createState() => _EventosViewState();
}

class _EventosViewState extends State<EventosView> {
  List<Event> events = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    simulateFetch();
  }

  Future<void> simulateFetch() async {
    await Future.delayed(const Duration(seconds: 2)); // Simulated API delay
    setState(() {
      events = [
        Event(
          title: 'Maintenance Scheduled',
          date: DateTime.now(),
          isRead: false,
        ),
        Event(
          title: 'New Feature Released',
          date: DateTime.now().subtract(Duration(days: 1)),
          isRead: true,
        ),
        Event(
          title: 'System Downtime',
          date: DateTime.now().subtract(Duration(days: 2)),
          isRead: false,
        ),
        Event(
          title: 'Weekly Report',
          date: DateTime.now().subtract(Duration(days: 3)),
          isRead: true,
        ),
      ];
      isLoading = false;
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
          drawer: NavigationDrawerWidget(),
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
                  isLoading
                      ? const Center(child: CircularProgressIndicator())
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
