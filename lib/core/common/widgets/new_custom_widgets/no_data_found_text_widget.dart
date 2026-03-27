import 'package:flutter/material.dart';


import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/app_sizer.dart';
import '../custom_text.dart';

class NoDataFoundText extends StatelessWidget {
  const NoDataFoundText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomText(text: 'No data found...',fontSize: 16.sp,fontWeight: FontWeight.w500,color: AppColors.textGrey,);
  }
}