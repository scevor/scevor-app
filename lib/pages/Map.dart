import 'package:flutter/material.dart';

class Map extends StatefulWidget {
  const Map({super.key});

  @override
  State<StatefulWidget> createState() => _Map();
}

class _Map extends State<Map> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text('Mappa'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text(
              'Sei nella pagina della mappa. Clicca qui per tornare indietro'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
