import 'package:flutter/material.dart';

class LiveStream extends StatefulWidget {
  const LiveStream({super.key});

  @override
  State<StatefulWidget> createState() => _LiveStreamState();
}

class _LiveStreamState extends State<LiveStream> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text('Live Stream'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text(
              'Sei nella pagina della diretta. Clicca qui per tornare indietro'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
