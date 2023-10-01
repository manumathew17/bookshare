import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../../theme/colors.dart';

class ShimmerLoader extends StatelessWidget {
  const ShimmerLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 30.w,
                  height: 20,
                  decoration: BoxDecoration(
                    color: lightPrimary_1,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  height: 30,
                  decoration: BoxDecoration(
                    color: lightPrimary_1,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: 100.w,
                  padding: const EdgeInsets.all(15),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              height: 40,
              decoration: BoxDecoration(
                color: lightPrimary_1,
                borderRadius: BorderRadius.circular(10),
              ),
              width: 100.w,
              padding: const EdgeInsets.all(15),
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
