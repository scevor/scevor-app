import 'package:flutter/material.dart';
import 'package:app/pages/Announcements.dart';
import 'package:app/pages/LiveStream.dart';
import 'package:app/pages/Map.dart';

void main() {
  runApp(const Scevor());
}

class Scevor extends StatelessWidget {
  const Scevor({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scevor',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(title: 'School Event Organizer'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    int cols = 1;
    if (width > 400) cols = 2;
    if (width > 650) cols = 3;
    if (width > 1080) cols = 4;
    if (width > 1400) cols = 5;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TestScreen("l'icona dell'account")),
              );
            },
            icon: const Image(
              image: NetworkImage("https://placekitten.com/50/50"),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Scevor'),
            ),
            ListTile(
              title: const Text('Annunci'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Announcements()),
                );
              },
            ),
            /*ListTile(
              title: const Text('Chat diretta'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TestScreen("Chat diretta")),
                );
              },
            ),
            ListTile(
              title: const Text('Chat gruppo 1'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TestScreen("Chat gruppo 1")),
                );
              },
            ),
            ListTile(
              title: const Text('Chat gruppo 2'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TestScreen("Chat gruppo 2")),
                );
              },
            ),*/
            ListTile(
              title: const Text('Mappa'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Map()),
                );
              },
            ),
            ListTile(
              title: const Text('Live Stream'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LiveStream()),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
          child: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: cols,
        children: const <Widget>[
          DecoratedButton(
              text: "Annunci",
              icon: Icon(Icons.campaign_rounded),
              screen: Announcements()),
          /*DecoratedButton(
              text: "Chat diretta",
              icon: Icon(Icons.chat_rounded),
              screen: TestScreen("Chat diretta")),
          DecoratedButton(
              text: "Chat gruppo 1",
              icon: Icon(Icons.chat_rounded),
              screen: TestScreen("Chat gruppo 1")),
          DecoratedButton(
              text: "Chat gruppo 2",
              icon: Icon(Icons.chat_rounded),
              screen: TestScreen("Chat gruppo 2")),*/
          DecoratedButton(text: "Mappa", icon: Icon(Icons.map), screen: Map()),
          DecoratedButton(
              text: "Live Stream",
              icon: Icon(Icons.live_tv),
              screen: LiveStream()),
        ],
      )),
    );
  }
}

//--------------------------

class TestScreen extends StatelessWidget {
  final String clicked;

  const TestScreen(this.clicked, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text('Test Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Hai cliccato $clicked'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

class DecoratedButton extends StatelessWidget {
  final String text;
  final Icon icon;
  final Widget screen;

  const DecoratedButton(
      {super.key,
      required this.text,
      required this.icon,
      required this.screen});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 300,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(5.0, 5.0),
              blurRadius: 10.0,
              spreadRadius: 2.0,
            ),
          ],
        ),
        child: InkWell(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconTheme(data: const IconThemeData(size: 110), child: icon),
                Text(text,
                    style: DefaultTextStyle.of(context)
                        .style
                        .apply(fontSizeFactor: 2.0)),
              ],
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => screen),
            );
          },
        ),
      ),
    );
  }
}
