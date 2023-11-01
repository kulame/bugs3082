import "dart:ui" as ui;

import "package:flutter/material.dart";
import "package:focus_app/shared/utils/log.dart";

class ImagePainter extends CustomPainter {
  final ui.Image image;

  ImagePainter({required this.image});

  @override
  void paint(Canvas canvas, Size size) {
    logger.d(size);
    canvas.drawImage(image, Offset.zero, Paint());
  }

  @override
  bool shouldRepaint(ImagePainter oldDelegate) => image != oldDelegate.image;
}
