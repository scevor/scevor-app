import 'package:flutter/material.dart';

class PlaceMap extends StatefulWidget {
  const PlaceMap({super.key});

  @override
  State<StatefulWidget> createState() => _PlaceMap();
}

class _PlaceMap extends State<PlaceMap> {
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
