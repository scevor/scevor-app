import 'package:flutter/material.dart';
import 'package:scevor/pages/announcements/announcement.dart';

class DecoratedAnnouncement extends StatelessWidget {
  final Announcement ann;

  const DecoratedAnnouncement({super.key,
    required this.ann
  });

  @override
  Widget build(BuildContext context) {
    //TODO: implementare recupero nome autore da database

    return SizedBox(
      /*width: 300,
      height: 300,*/
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: (ann.important) ? Colors.redAccent : Colors.white,
          boxShadow: const [
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
                if(ann.important) Text("IMPORTANTE", style: DefaultTextStyle.of(context).style.apply(fontWeightDelta: 2)),
                Text(ann.title,
                    style: DefaultTextStyle.of(context)
                        .style
                        .apply(fontSizeFactor: 2.0)),
                Text("di ${ann.author}"),
                Text(ann.text,
                  style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.3),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
