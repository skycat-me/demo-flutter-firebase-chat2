part of chat;

enum DateStringFormat {
  defaultFormat, // yyyy/mm/dd hh:ii
  dateFormatYearMonthDate, // yyyy/mm/dd
}

// timestampを指定したフォーマットに変換する
String timestampToString({
  @required int timestamp,
  DateStringFormat format = DateStringFormat.defaultFormat,
}) {
  final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  var dateString;
  switch (format) {
    case DateStringFormat.defaultFormat:
      dateString =
          '${date.year.toString().padLeft(4, '0')}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
      break;
    case DateStringFormat.dateFormatYearMonthDate:
      dateString =
          '${date.year.toString().padLeft(4, '0')}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';
      break;
  }
  return dateString;
}

// datetimeを指定したフォーマットに変換する
String datetimeToString({
  @required DateTime date,
  DateStringFormat format = DateStringFormat.defaultFormat,
}) {
  if (date == null) {
    return null;
  }
  var dateString;
  switch (format) {
    case DateStringFormat.defaultFormat:
      dateString =
          '${date.year.toString().padLeft(4, '0')}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
      break;
    case DateStringFormat.dateFormatYearMonthDate:
      dateString =
          '${date.year.toString().padLeft(4, '0')}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';
      break;
  }
  return dateString;
}
