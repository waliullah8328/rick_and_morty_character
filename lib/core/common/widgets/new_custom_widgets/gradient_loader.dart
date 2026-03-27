import 'package:flutter/material.dart';

class GradientLoader extends StatefulWidget {
  final double size;
  final double strokeWidth;

  const GradientLoader({
    super.key,
    this.size = 40,
    this.strokeWidth = 4,
  });

  @override
  State<GradientLoader> createState() => _GradientLoaderState();
}

class _GradientLoaderState extends State<GradientLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5000), // faster rotation
    )..repeat(); // infinite loop
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: widget.size,
        width: widget.size,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.rotate(
              angle: _controller.value * 6.28319, // 2π for smooth rotation
              child: CustomPaint(
                painter: _GradientLoaderPainter(strokeWidth: widget.strokeWidth),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _GradientLoaderPainter extends CustomPainter {
  final double strokeWidth;

  _GradientLoaderPainter({required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    final gradient = SweepGradient(
      startAngle: 0,
      endAngle: 3.14, // half-circle tail effect
      colors: [
        const Color(0xff8A2BE2).withValues(alpha: 1.0), // high opacity
        const Color(0xff8A2BE2).withValues(alpha: 0.1), // low opacity
      ],
    );

    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;

    final radius = size.width / 2;
    canvas.drawArc(
      Rect.fromCircle(center: Offset(radius, radius), radius: radius),
      0,
      6.28319, // full circle
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
