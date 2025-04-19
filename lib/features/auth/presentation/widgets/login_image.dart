import 'package:flutter/material.dart';
import 'package:task_out/core/constants/app_assets.dart';
import 'package:task_out/core/utils/app_sizes.dart';

class LoginImage extends StatelessWidget {
  const LoginImage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppSizes.blockWidth * 95,
      child: Image.asset(
        AppAssets.login,
        fit: BoxFit.fill,
      ),
    );
  }
}
