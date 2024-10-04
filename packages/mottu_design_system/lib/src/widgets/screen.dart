import 'package:flutter/material.dart';
import 'package:mottu_design_system/src/themes/mottu_color_theme.dart';

class Screen extends StatelessWidget {
  const Screen({
    super.key,
    this.appBar,
    required this.body,
    this.backgroundColor,
    this.scrollController,
  });

  final SliverPersistentHeaderDelegate? appBar;
  final List<Widget> body;
  final Color? backgroundColor;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MottuColorsTheme>()!;

    return Scaffold(
      backgroundColor: backgroundColor ?? colors.backgroundPrimary,
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          if (appBar != null) SliverPersistentHeader(pinned: true, delegate: appBar!),
          ...body,
        ],
      ),
    );
  }
}
