import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class CanvasPageSpeedDial extends StatelessWidget {
  const CanvasPageSpeedDial({
    super.key,
    required this.onGalleryTap,
    required this.onClipBoardTap,
    required this.onURLTap,
    required this.onPinterestTap,
    required this.isPremiumUser,
    required this.isCameraSupported,
    required this.onTakePhoto,
  });

  final Function() onGalleryTap;
  final Function() onClipBoardTap;
  final Function() onURLTap;
  final Function() onPinterestTap;
  final Function() onTakePhoto;
  final bool isPremiumUser;
  final bool isCameraSupported;

  @override
  Widget build(BuildContext context) {
    final options = [
      SpeedDialChild(
        label: "Add Image: Photo Gallery",
        onTap: onGalleryTap,
      ),
      SpeedDialChild(
        label: "AddImage: Past clip board",
        onTap: onClipBoardTap,
      ),
      SpeedDialChild(
        label: "Add Image: URL",
        onTap: onURLTap,
      ),
      if (isPremiumUser) ...{
        SpeedDialChild(
          label: "Add Images: Pinterest idea boards",
          onTap: onPinterestTap,
        )
      },
      if (isCameraSupported) ...{
        SpeedDialChild(
          label: "Add Images: Take Photo",
          onTap: onTakePhoto,
        )
      }
    ];

    return SpeedDial(
      elevation: 0,
      children: options,
      tooltip: "Add Image",
      mini: true,
      child: const Icon(Icons.add_photo_alternate),
    );
  }
}
