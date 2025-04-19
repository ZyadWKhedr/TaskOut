import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: Row(
        children: [
          Expanded(child: Divider(color: Colors.grey[400], thickness: 1.h)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Text(
              'or',
              style: TextStyle(color: Colors.grey, fontSize: 16.sp),
            ),
          ),
          Expanded(child: Divider(color: Colors.grey[400], thickness: 1.h)),
        ],
      ),
    );
  }
}
