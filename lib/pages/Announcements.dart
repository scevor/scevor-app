import 'package:flutter/material.dart';

class Announcements extends StatefulWidget {
  const Announcements({super.key});

  @override
  State<StatefulWidget> createState() => _AnnouncementsState();
}

class _AnnouncementsState extends State<Announcements> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text('Annunci'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text(
              'Sei nella pagina degli annunci. Clicca qui per tornare indietro'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
