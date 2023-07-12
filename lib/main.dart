import 'package:scevor/auth/AccountPage.dart';
import 'package:scevor/auth/LoginPage.dart';
import 'package:scevor/auth/SplashPage.dart';
import 'package:flutter/material.dart';
import 'package:scevor/pages/announcements/announcements.dart';
import 'package:scevor/pages/LiveStream.dart';
import 'package:scevor/pages/PlaceMap.dart';
import 'package:scevor/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

import 'decoratedButton.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  prefs = await SharedPreferences.getInstance();

  await Supabase.initialize(
      url: const String.fromEnvironment('SUPABASE_URL'),
      anonKey: const String.fromEnvironment('SUPABASE_ANONKEY')
  );

  runApp(const Scevor());
}

class Scevor extends StatelessWidget {
  const Scevor({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scevor',
      theme: ThemeData(
        useMaterial3: true,
      ),
      //home: const SplashPage(),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (_) => const SplashPage(),
        '/login': (_) => const LoginPage(),
        '/account': (_) => const AccountPage(),
        '/home': (_) => const HomePage(title: "School Event Organizer")
      },
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
  final _sections = supabase.from("profile_data").select().eq("user_id", userId).select<List<Map<String, dynamic>>>("sections");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/account");
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
            ListTile(
              title: const Text('Mappa'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PlaceMap()),
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

      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _sections,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final sections = snapshot.data!.elementAt(0).values.toList().first;
          return ListView.builder(
            itemCount: sections.length,
            itemBuilder: ((context, index) {
              final sec = sections[index];
              final page = pages.firstWhere((p) => p.keys.first == sec.toString()).values.elementAt(0);
              return DecoratedButton(
                  text: page.elementAt(0).toString(),
                  icon: Icon(page.elementAt(1) as IconData),
                  screen: page.elementAt(2) as Widget
              );
            }),
          );
        },
      ),
    );
  }
}
/*
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
*/