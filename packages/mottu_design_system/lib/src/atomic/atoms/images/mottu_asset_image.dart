import 'package:flutter/widgets.dart';
import 'package:mottu_design_system/src/atomic/atoms/images/mottu_images.dart';

class MottuAssetImage extends StatelessWidget {
  const MottuAssetImage(
    this.image, {
    super.key,
    this.color,
    this.width,
    this.height,
    this.fit,
  });

  final MottuImages image;
  final Color? color;
  final double? width;
  final double? height;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 40.0,
      height: height ?? 40.0,
      child: Image.asset(
        image.path,
        package: 'mottu_design_system',
        fit: fit,
      ),
    );
  }
}
