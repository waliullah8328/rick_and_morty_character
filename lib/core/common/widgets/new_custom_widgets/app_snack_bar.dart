import 'package:flutter/material.dart';

import '../../../utils/constants/app_sizer.dart';





class AppSnackBar {

  static void showError(BuildContext context, String message, {required String title }) {
    _showTopSnackBar(
      context,
      title,
      message,
      backgroundColor: const Color(0xffDC143C),
      icon: Icons.error_outline,
    );
  }

  static void showSuccess(BuildContext context, String message, {required String title}) {
    _showTopSnackBar(
      context,
      title,
      message,
      backgroundColor: Colors.green.shade700,
      icon: Icons.check_circle_outline,
    );
  }

  /// SHOW ANIMATED TOP SNACKBAR
  static void _showTopSnackBar(
      BuildContext context,
      String title,
      String message, {
        required Color backgroundColor,
        required IconData icon,
      }) {
    final overlay = Overlay.of(context);

    final animationController = AnimationController(
      vsync: Navigator.of(context),
      duration: const Duration(milliseconds: 300),
    );

    final curvedAnimation =
    CurvedAnimation(parent: animationController, curve: Curves.easeOutBack);

    final overlayEntry = OverlayEntry(
      builder: (_) {
        return Positioned(
          top: 40.h,
          left: 0.w,
          right: 0.w,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, -1.5),
              end: Offset.zero,
            ).animate(curvedAnimation),
            child: Material(
              color: Colors.transparent,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                padding: EdgeInsets.all(14.w),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: backgroundColor.withValues(alpha: 0.4),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: Row(
                  children: [
                    Icon(icon, color: Colors.white, size: 26),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp)),
                         SizedBox(height: 4.h),
                          Text(message,
                              style:  TextStyle(
                                  color: Colors.white, fontSize: 14.sp)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );

    overlay.insert(overlayEntry);
    animationController.forward();

    // Auto dismiss after 3 seconds
    Future.delayed(const Duration(seconds: 3), () async {
      await animationController.reverse();
      overlayEntry.remove();
    });
  }
}
