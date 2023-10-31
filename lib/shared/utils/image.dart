import 'dart:async';

import 'package:image/image.dart' as img;
import "dart:ui" as ui;
import 'package:image_picker/image_picker.dart';
import "package:google_mlkit_commons/google_mlkit_commons.dart";
import 'package:loop/shared/utils/log.dart';

class ImageUtils {
  static InputImage xFileToInput(XFile file) {
    var path = file.path;
    return InputImage.fromFilePath(path);
  }

  static Future<img.Image?> xFileToImage(XFile file) async {
    logger.d(file.name);
    var img = await xFileToFlutterUi(file);
    if (img != null) {
      return await flutterUiToImage(img);
    } else {
      throw Exception("Could not find image");
    }
  }

  static Future<ui.Image?> xFileToFlutterUi(XFile file) async {
    final completer = Completer<ui.Image>();
    ui.decodeImageFromList(await file.readAsBytes(), completer.complete);
    return completer.future;
  }

  static Future<ui.Image> imageToFlutterUi(img.Image image) async {
    if (image.format != img.Format.uint8 || image.numChannels != 4) {
      final cmd = img.Command()
        ..image(image)
        ..convert(format: img.Format.uint8, numChannels: 4);
      final rgba8 = await cmd.getImageThread();
      if (rgba8 != null) {
        image = rgba8;
      }
    }

    ui.ImmutableBuffer buffer =
        await ui.ImmutableBuffer.fromUint8List(image.toUint8List());

    ui.ImageDescriptor id = ui.ImageDescriptor.raw(buffer,
        height: image.height,
        width: image.width,
        pixelFormat: ui.PixelFormat.rgba8888);

    ui.Codec codec = await id.instantiateCodec(
        targetHeight: image.height, targetWidth: image.width);

    ui.FrameInfo fi = await codec.getNextFrame();
    ui.Image uiImage = fi.image;

    return uiImage;
  }

  static Future<img.Image> flutterUiToImage(ui.Image uiImage) async {
    final uiBytes = await uiImage.toByteData(format: ui.ImageByteFormat.png);
    return img.decodeImage(uiBytes!.buffer.asUint8List())!;
  }
}
