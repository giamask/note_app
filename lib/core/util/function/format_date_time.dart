import 'package:easy_localization/easy_localization.dart';

abstract class FormatDateTime {
  FormatDateTime._();

  static const String _fixFormat = 'Edited 12:00';
  static final DateFormat _timeFormat = DateFormat('HH:mm');
  static final DateFormat _dayAndMonthFormat = DateFormat('dd MMM');
  static final DateFormat _fullFormat = DateFormat('dd MMM yy');

  static String getFormatDateTime(DateTime dateTime) {
    final now = DateTime.now();

    if (dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day) {
      if (dateTime.hour == 12 && dateTime.minute == 0) {
        return _fixFormat;
      } else {
        return 'Edited '.tr() + _timeFormat.format(dateTime);
      }
    } else if (dateTime.year == now.year) {
      return 'Edited '.tr() + _dayAndMonthFormat.format(dateTime);
    } else {
      return 'Edited '.tr() + _fullFormat.format(dateTime);
    }
  }
}
