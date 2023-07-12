import 'package:flutter/material.dart';
import 'package:scevor/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddAnnouncement extends StatefulWidget {
  const AddAnnouncement({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddAnnouncementState();
}

class _AddAnnouncementState extends State<AddAnnouncement> {
  bool _isLoading = false;
  final TextEditingController _title = TextEditingController();
  final TextEditingController _text = TextEditingController();
  bool _important = false;

  Future<void> _deliverAnnouncement() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await supabase
          .from('announcements')
          .insert([
            { "author": userId,
              "title": _title.text.trim(),
              "content": _text.text.trim(),
              "important": _important
            },
          ])
          .select();

      if (mounted) {
        _title.clear();
        _text.clear();
        _important = false;
      }

      context.showSuccessSnackBar(message: 'Annuncio inserito correttamente');

      Navigator.pop(context);
    }
    on PostgrestException catch (error) {
      if(error.code == "23514") {
        context.showErrorSnackBar(message: 'Titolo e testo non devono essere vuoti');
      } else {
        context.showErrorSnackBar(message: error.message);
      }
    } catch (error) {
      context.showErrorSnackBar(message: 'Unexpected error occurred');
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _title.dispose();
    _text.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Aggiungi un annuncio')),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
        children: [
          const Text('Inserisci titolo e testo dell\'annuncio'),
          const Text('Usa lo switch per scegliere se l\'annuncio è importante o non importante'),
          const SizedBox(height: 18),
          Form(
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                children: [
                  TextFormField(
                      controller: _title,
                      decoration: const InputDecoration(labelText: 'Titolo annuncio'),
                      validator: (value) {
                        return value!.length < 1 ? 'Il titolo non può essere vuoto' : null;
                      }
                  ),
                  TextFormField(
                    controller: _text,
                    decoration: const InputDecoration(labelText: 'Testo annuncio'),
                      validator: (value) {
                        return value!.length < 1 ? 'Il testo non può essere vuoto' : null;
                      }
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Importante: "),
                      Switch(
                        value: _important,
                        onChanged: (bool value) {
                          setState(() {
                            _important = value;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              )
          ),


          const SizedBox(height: 18),
          ElevatedButton(
            onPressed: _isLoading ? null : _deliverAnnouncement,
            child: Text(_isLoading ? 'Accesso in corso...' : 'Accedi'),
          ),
        ],
      ),
    );
  }


}
