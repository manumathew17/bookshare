
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class NoData extends StatelessWidget {
  final double width;
  final double height;
  final String text;

  const NoData({super.key,
    required this.width,
    required this.height,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset('assets/lottie/nodata.json', repeat: false),
          SizedBox(height: 1.h,),
          Text(text)
        ],
      )
    );
  }
}
