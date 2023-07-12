import 'package:scevor/pages/announcements/announcements.dart';
import 'package:scevor/pages/LiveStream.dart';
import 'package:scevor/pages/PlaceMap.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

late final SharedPreferences prefs;

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

  void showSuccessSnackBar({required String message}) {
    showSnackBar(message: message, backgroundColor: Colors.green);
  }
}