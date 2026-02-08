import 'package:intl/intl.dart';

class DateUtility {
  static String timeAgo(DateTime? dateTime) {
    final now = DateTime.now();

    if (dateTime == null) {
      return '';
    }

    final targetDate = dateTime.add(DateTime.now().timeZoneOffset);
    final diff = now.difference(targetDate);

    if (diff.isNegative) {
      return 'เมื่อสักครู่';
    }

    if (diff.inSeconds < 60) {
      return 'เมื่อสักครู่';
    } else if (diff.inMinutes < 60) {
      return '${diff.inMinutes} นาทีที่แล้ว';
    } else if (diff.inHours < 24) {
      return '${diff.inHours} ชั่วโมงที่แล้ว';
    } else if (diff.inDays < 7) {
      return '${diff.inDays} วันที่แล้ว';
    } else if (diff.inDays < 31) {
      int weeks = (diff.inDays / 7).floor();
      return '$weeks สัปดาห์ที่แล้ว';
    } else {
      return DateFormat('d MMM y', 'th').format(targetDate);
    }
  }

  static String time(DateTime? dateTime) {
    if (dateTime == null) {
      return '';
    }

    final targetDate = dateTime.add(DateTime.now().timeZoneOffset);

    return DateFormat('d MMM y', 'th').format(targetDate);
  }
}
