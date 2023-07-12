import 'package:flutter/material.dart';
import 'package:scevor/pages/announcements/announcement.dart';
import 'package:scevor/constants.dart';
import 'package:scevor/pages/announcements/decoratedAnnouncement.dart';

import 'add_announcement.dart';

class Announcements extends StatefulWidget {
  const Announcements({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AnnouncementsState();
}

class _AnnouncementsState extends State<Announcements> {
  final Stream<List<Announcement>> _announcements = supabase
      .from('announcements')
      .stream(primaryKey: ['id'])
      .order("created_at", ascending: false)
      .map((maps) => maps.map((map) => Announcement.fromMap(map)).toList());

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
        body: StreamBuilder<List<Announcement>>(
          stream: _announcements,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else {
              final announcements = snapshot.data!;
              return ListView.builder(
                itemCount: announcements.length,
                itemBuilder: (context, index) {
                  return DecoratedAnnouncement(ann: announcements[index]);
                },
              );
            }
          }
        ),
      floatingActionButton:
        prefs.getInt("role")! > 1 ? FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddAnnouncement()),
              );
            },
            child: const Icon(Icons.edit),
          ) : null,
    );
  }


}
