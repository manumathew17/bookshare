import 'package:bookshare/theme/app_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class NotFound extends StatelessWidget {
  final String text;

  const NotFound({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 20.h, child: Lottie.asset('assets/lottie/notfound.json', repeat: false)),
        Text(
          text,
          style: header12,
          textAlign: TextAlign.center,

        )
      ],
    );
  }
}
