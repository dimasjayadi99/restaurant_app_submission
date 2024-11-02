import 'package:intl/intl.dart';

String formatDate(String inputDate) {
  DateTime dateTime = DateFormat('d MMMM yyyy', 'id_ID').parse(inputDate);
  String formattedDate = DateFormat('d MMM yyyy', 'id_ID').format(dateTime);
  return formattedDate;
}
