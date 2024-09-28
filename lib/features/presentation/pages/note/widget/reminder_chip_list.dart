import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/features/domain/entities/reminder.dart';
import 'package:note_app/features/presentation/blocs/blocs.dart';
import 'package:note_app/features/presentation/pages/note/widget/deletable_chip.dart';
import 'package:note_app/features/presentation/pages/note/widget/show_datetime_picker.dart';

class ReminderChipList extends StatelessWidget {
  const ReminderChipList({
    super.key,
    required this.reminders,
  });

  final List<Reminder> reminders;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: DeletableActionChip(
                faded: reminders[index].dateTime.isBefore(DateTime.now()),
                label: (reminders[index].formattedDateTime),
                onPressed: () async {
                  final dateTime = await showDateTimePicker(
                      context: context, initialDate: reminders[index].dateTime);
                  if (dateTime != null) {
                    final newReminders = _updateReminder(
                        reminders[index].id, dateTime, reminders);
                    if (context.mounted) {
                      context
                          .read<NoteBloc>()
                          .add(ModifRemindersNote(newReminders));
                    }
                  }
                },
                onDeleted: () {
                  final newReminders =
                      _deleteReminder(reminders[index].id, reminders);
                  context
                      .read<NoteBloc>()
                      .add(ModifRemindersNote(newReminders));
                },
              ),
            ),
            itemCount: reminders.length,
            prototypeItem: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.0),
              child: DeletableActionChip(
                label: ('18 Sep 2022 12:022'),
              ),
            ),
          ),
        ));
  }
}

List<Reminder> _deleteReminder(int id, List<Reminder> reminders) {
  return [...reminders]..removeWhere((item) => item.id == id);
}

List<Reminder> _updateReminder(
    int id, DateTime date, List<Reminder> reminders) {
  final index = reminders.indexWhere((item) => item.id == id);
  var newId = 0;
  if (reminders.isNotEmpty) {
    var max = reminders
        .reduce((value, element) => value.id > element.id ? value : element)
        .id;
    newId = max + 1;
  }
  if (index != -1) {
    final newReminders = [...reminders];
    newReminders[index] = Reminder(id: newId, dateTime: date);
    return newReminders;
  } else {
    return reminders;
  }
}
