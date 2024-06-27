import 'package:flutter/material.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget mobileFirstView;
  final Widget desktopFirstView;

  const ResponsiveLayout({super.key, required this.mobileFirstView, required this.desktopFirstView});

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      const imageAssetsRatio = 1344/768;
      // final windowsRatio = constraints.maxWidth/constraints.maxHeight;
      final windowsRatio = MediaQuery.of(context).size.width/MediaQuery.of(context).size.height;

      if (windowsRatio > imageAssetsRatio) {
        return widget.desktopFirstView;
      } else {
        return widget.mobileFirstView;
      }
    });
  }
}