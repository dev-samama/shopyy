import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerticalSpace extends StatelessWidget {
  const VerticalSpace({super.key, this.h = 0, this.w = 0});
  final double h;
  final double w;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: h.h,
      width: w.w,
    );
  }
}

Size getSize(BuildContext context) => MediaQuery.of(context).size;
