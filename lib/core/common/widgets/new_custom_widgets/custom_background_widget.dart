import 'package:flutter/material.dart';

import '../../../utils/constants/image_path.dart';

class CustomBackground extends StatelessWidget {
  final Widget? child;
  final BoxFit fit;
  final bool useSafeArea;
  final bool showBottomImage; // 👈 control visibility

  const CustomBackground({
    super.key,
    this.child,
    this.fit = BoxFit.cover,
    this.useSafeArea = true,
    this.showBottomImage = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              ImagePath.allBackGroundImage,
              fit: fit,
            ),
          ),

          // Screen content
          if (child != null)
            SizedBox.expand(
              child: useSafeArea
                  ? SafeArea(child: child!)
                  : child!,
            ),

          // Bottom image (optional)
          if (showBottomImage)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                ImagePath.bottomNavBarImage,
                fit: BoxFit.cover,
              ),
            ),
        ],
      ),
    );
  }
}
