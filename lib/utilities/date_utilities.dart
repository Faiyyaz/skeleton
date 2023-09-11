import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../localization/app_localization.dart';

class DateUtilities {
  static String formatTimeAgo(
    BuildContext context,
    DateTime time,
    String format,
  ) {
    final now = DateTime.now().toLocal();
    final difference = now.difference(time.toLocal());
    final Locale locale = context.getLocale();

    if (difference.inDays >= 7) {
      final DateFormat formatter = DateFormat(format, locale.languageCode);
      final String formatted = formatter.format(time.toLocal());
      return formatted;
    } else if (difference.inDays >= 1) {
      if (difference.inDays > 1) {
        return context.getString('days', {'value': difference.inDays});
      } else {
        return context.getString('day');
      }
    } else if (difference.inHours >= 1) {
      if (difference.inHours > 1) {
        return context.getString('hours', {'value': difference.inHours});
      } else {
        return context.getString('hour');
      }
    } else if (difference.inMinutes >= 1) {
      if (difference.inMinutes > 1) {
        return context.getString('minutes', {'value': difference.inMinutes});
      } else {
        return context.getString('minute');
      }
    } else {
      return context.getString('just_now');
    }
  }
}
