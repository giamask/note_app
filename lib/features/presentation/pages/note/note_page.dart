import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:note_app/features/domain/entities/reminder.dart';
import 'package:note_app/features/presentation/blocs/pictures/pictures_cubit.dart';
import 'package:note_app/features/presentation/pages/note/widget/reminder_chip_list.dart';

import '../../../../core/core.dart';
import '../../../domain/entities/note.dart';
import '../../blocs/blocs.dart';
import 'widget/widgets.dart';

class NotePage extends StatefulWidget {
  const NotePage({
    super.key,
    required this.note,
  });

  final Note note;

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _undoController = UndoHistoryController();
  List<Reminder> get reminders {
    final noteBloc = context.read<NoteBloc>();
    return noteBloc.currentReminders;
  }

  Color get noteColor {
    final noteBloc = context.read<NoteBloc>();
    return ColorNote.getColor(context, noteBloc.currentColor);
  }

  Note get originNote {
    return Note(
        id: widget.note.id,
        title: widget.note.title,
        content: widget.note.content,
        modifiedTime: widget.note.modifiedTime,
        colorIndex: widget.note.colorIndex,
        stateNote: widget.note.stateNote,
        images: widget.note.images,
        reminders: widget.note.reminders);
  }

  Note get currentNote {
    final noteBloc = context.read<NoteBloc>();
    final noteStatusBloc = context.read<StatusIconsCubit>();
    final imagesCubit = context.read<PicturesCubit>();
    //==>
    final StatusNote currentStatusNote =
        noteStatusBloc.state is ToggleIconsStatusState
            ? (noteStatusBloc.state as ToggleIconsStatusState).currentNoteStatus
            : StatusNote.trash;
    //==>
    return Note(
        id: widget.note.id,
        title: _titleController.text,
        content: _contentController.text,
        modifiedTime: widget.note.modifiedTime,
        colorIndex: noteBloc.currentColor,
        stateNote: currentStatusNote,
        reminders: reminders,
        images: imagesCubit.state.files);
  }

  @override
  void initState() {
    context.read<PicturesCubit>().initializePictures(widget.note.images);
    _loadNoteFields();

    super.initState();
  }

  void _loadNoteFields() {
    _titleController.text = widget.note.title.isNotEmpty
        ? widget.note.title
        : (DateFormat('dd-MM-yyyy')).format(DateTime.now());
    _contentController.text = widget.note.content;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    if (context.mounted) context.read<PicturesCubit>().reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (_) => _onBack(),
      child: BlocConsumer<NoteBloc, NoteState>(
        listener: (context, state) => _displaylistener(context, state),
        builder: (context, state) {
          return Scaffold(
            backgroundColor: noteColor,
            bottomNavigationBar: CustomBottomBar(currentNote, _undoController),
            appBar: AppBarNote(press: _onBack),
            body: _buildBody(),
          );
        },
      ),
    );
  }

  Widget _buildBody() {
    return SafeArea(child: Scrollbar(
      child:
          BlocBuilder<PicturesCubit, PicturesState>(builder: (context, state) {
        return CustomScrollView(
          slivers: [
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200.0,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 0.7,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return GestureDetector(
                      onTap: () => context.pushNamed(
                          AppRouterName.imagePreview.name,
                          pathParameters: {"noteId": widget.note.id.toString()},
                          extra: {"index": index.toString()}),
                      child:
                          Image(image: FileImage(currentNote.images[index])));
                },
                childCount: currentNote.images.length,
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return ReminderChipList(reminders: reminders);
                },
                childCount: reminders.isNotEmpty ? 1 : 0,
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: TextFieldsForm(
                controllerTitle: _titleController,
                controllerContent: _contentController,
                undoController: _undoController,
                autofocus: false,
              ),
            ),
          ],
        );
      }),
    ));
  }

  Future<bool> _onBack() async {
    context.read<NoteBloc>().add(PopNoteAction(currentNote, originNote));
    return true;
  }

  void _displaylistener(BuildContext context, NoteState state) {
    if (state is GoPopNoteState) context.pop();
  }
}
