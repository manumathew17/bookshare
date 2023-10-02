import 'package:bookshare/model/model_user.dart';
import 'package:intl/intl.dart';

class Helper {
  static String getReturnDate(books) {
    DateTime inputDate = DateFormat("yyyy-MM-dd").parse(books['rent_end_date']);
    return DateFormat("d'th' MMM yyyy").format(inputDate);
  }

  static double getRemaningValue(books) {
    DateTime startDate = DateTime.parse(books['rent_start_date']);
    DateTime endDate = DateTime.parse(books['rent_end_date']);
    DateTime now = DateTime.now();
    Duration diff1 = endDate.difference(startDate);
    Duration diff2 = endDate.difference(now);
    if (diff1.inDays - diff2.inDays > 0) {
      return (diff1.inDays - diff2.inDays) / diff1.inDays;
    }
    return 0;
  }

  static int showDateNo(books) {
    DateTime endDate = DateTime.parse(books['rent_end_date']);
    DateTime now = DateTime.now();
    Duration diff2 = endDate.difference(now);
    print(books['rent_end_date']);
    return diff2.inDays;
  }
}
