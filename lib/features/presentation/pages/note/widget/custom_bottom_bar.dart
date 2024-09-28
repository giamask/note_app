import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/features/domain/entities/reminder.dart';
import 'package:note_app/features/presentation/blocs/blocs.dart';
import 'package:note_app/features/presentation/blocs/pictures/pictures_cubit.dart';
import 'package:note_app/features/presentation/pages/note/widget/reminder_note.dart';
import 'package:note_app/features/presentation/pages/note/widget/scan_doc_icon_note.dart';
import 'package:cunning_document_scanner/cunning_document_scanner.dart';
import 'package:note_app/features/presentation/pages/note/widget/show_datetime_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../../core/core.dart';
import '../../../../domain/entities/note.dart';
import './widgets.dart';

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar(
    this.note,
    this.undoController,
  ) : super(key: null);

  final UndoHistoryController undoController;
  final Note note;

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  bool isShowUndoRedo = false;

  @override
  void initState() {
    _loadListenerUndo();
    super.initState();
  }

  _loadListenerUndo() {
    widget.undoController.addListener(
      () => setState(
        () => isShowUndoRedo = true,
      ),
    );
  }

  @override
  void dispose() {
    widget.undoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CommonBottomAppBar(
      isShowFAB: false,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            ColorIconNote(
              press: () => _showModalBottomSheet(
                  sheetPopoverType: SheetPopover.coloring),
            ),
            ScanDocIconNote(
              press: () async {
                try {
                  final imagePath = await CunningDocumentScanner.getPictures();
                  if (imagePath?.isEmpty ?? true) return;
                  final cacheFile = File(imagePath!.first);
                  final appDir = await getApplicationDocumentsDirectory();

                  final newFile = await cacheFile.copy(
                      "${appDir.path}/${cacheFile.uri.pathSegments.last}");
                  await cacheFile.delete();
                  if (newFile.existsSync() && context.mounted) {
                    context.read<PicturesCubit>().addPicture(newFile);
                  }
                } catch (_) {
                  throw NoDataException();
                }
              },
            ),
            ReminderNote(
              press: () async {
                final newReminderDatetime = await showDateTimePicker(
                    context: context,
                    initialDate: DateTime.now().add(const Duration(days: 1)));

                if (newReminderDatetime != null) {
                  final newReminders = _createReminder(
                      newReminderDatetime, widget.note.reminders);
                  if (context.mounted) {
                    context
                        .read<NoteBloc>()
                        .add(ModifRemindersNote(newReminders));
                  }
                }
              },
            )
          ]),
          isShowUndoRedo
              ? UndoRedoButtons(undoController: widget.undoController)
              : Text(
                  FormatDateTime.getFormatDateTime(widget.note.modifiedTime),
                ),
          MoreIconNote(
            pressMore: () =>
                _showModalBottomSheet(sheetPopoverType: SheetPopover.more),
            pressRecovery: () =>
                _showModalBottomSheet(sheetPopoverType: SheetPopover.recovery),
          )
        ],
      ),
    );
  }

  void _showModalBottomSheet({
    required SheetPopover sheetPopoverType,
  }) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (context) => CommonPopover(
        child: () {
          switch (sheetPopoverType) {
            case SheetPopover.coloring:
              return const PopoverColoringNote();
            case SheetPopover.more:
              return PopoverMoreNote(note: widget.note);
            case SheetPopover.recovery:
              return PopoverRecoveryNote(note: widget.note);
          }
        }(),
      ),
    );
  }
}

List<Reminder> _createReminder(DateTime date, List<Reminder> reminders) {
  var id = 0;
  if (reminders.isNotEmpty) {
    var max = reminders
        .reduce((value, element) => value.id > element.id ? value : element)
        .id;
    id = max + 1;
  }
  return [...reminders, Reminder(id: id, dateTime: date)];
}
