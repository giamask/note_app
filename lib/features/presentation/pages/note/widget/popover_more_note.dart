import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../core/core.dart';
import '../../../../domain/entities/note.dart';
import '../../../blocs/blocs.dart';

class PopoverMoreNote extends StatelessWidget {
  final Note note;
  const PopoverMoreNote({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: AppIcons.trashNote,
            title: const Text('Delete').tr(),
            onTap: () => _onTrashNote(context),
          ),
          ListTile(
            leading: AppIcons.sendNote,
            title: const Text('Send').tr(),
            onTap: () {
              final text = '${note.title}\n${note.content}';
              Share.share(text);
            },
          ),
        ],
      ),
    );
  }

  void _onTrashNote(BuildContext context) {
    context.read<NoteBloc>().add(MoveNote(note, StatusNote.trash));
    context.pop();
  }
}
