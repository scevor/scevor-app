import 'package:scevor/pages/Announcements.dart';
import 'package:scevor/pages/LiveStream.dart';
import 'package:scevor/pages/PlaceMap.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const supabaseUrl = 'https://qmtgppnbibzqrgenmvpe.supabase.co';

final supabase = Supabase.instance.client;
final userId = supabase.auth.currentUser!.id;
final userName = supabase.auth.currentUser!.email;
const pages = [
  {"announcements" : ["Annunci", Icons.campaign_rounded, Announcements()]},
  {"map" : ["Mappa", Icons.map_rounded, PlaceMap()]},
  {"livestream" : ["Diretta", Icons.tv_rounded, LiveStream()]},
];

extension ShowSnackBar on BuildContext {
  void showSnackBar({
    required String message,
    Color backgroundColor = Colors.white,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
    ));
  }

  void showErrorSnackBar({required String message}) {
    showSnackBar(message: message, backgroundColor: Colors.red);
  }
}

extension ShowButton on BuildContext {
  BuildContext? get context => null;

  Widget? showDecoratedButton({
    required String text,
    required Icon icon,
    required Widget screen,
  }) {
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
                Text(text.toString(),
                    style: DefaultTextStyle.of(context!)
                        .style
                        .apply(fontSizeFactor: 2.0)),
              ],
            ),
          ),
          onTap: () {
            Navigator.push(
              context!,
              MaterialPageRoute(builder: (context) => screen),
            );
          },
        ),
      ),
    );
  }
}