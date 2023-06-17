import 'package:flutter/material.dart';
import 'package:scevor/Announcement.dart';

import '../constants.dart';
import '../decoratedAnnouncement.dart';

class Announcements extends StatefulWidget {
  const Announcements({super.key});

  @override
  State<StatefulWidget> createState() => _AnnouncementsState();
}

class _AnnouncementsState extends State<Announcements> {
  final _announcements = supabase.from('announcements').stream(primaryKey: ['id']).order("created_at", ascending: false);

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
        body: StreamBuilder(
          stream: _announcements,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else {
              final announcements = snapshot.data;
              return ListView.builder(
                  itemCount: announcements?.length,
                  itemBuilder: ((context, index) {
                    final announcement = announcements?[index].values.toList();
                    final Announcement ann = Announcement(id: announcement?[0], createdAt: DateTime.parse(announcement?[1]), author: announcement?[2], text: announcement?[3], title: announcement?[4], important: announcement?[5]);

                    return DecoratedAnnouncement(ann: ann);

                  })
              );
            }
          }
      ),
    );
  }


}
