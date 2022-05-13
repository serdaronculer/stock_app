import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stock_app/core/constants/constants.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({Key? key}) : super(key: key);
  final _logoPath = "assets/svg/logo.svg";
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      _logoPath,
      color: AppColors.white,
      width: 100.w,
      height: 100.h,
    );
  }
}
