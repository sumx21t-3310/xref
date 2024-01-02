import 'package:flutter/foundation.dart';
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
  });

  final Function() onGalleryTap;
  final Function() onClipBoardTap;
  final Function() onURLTap;
  final Function() onPinterestTap;
  final bool isPremiumUser;

  @override
  Widget build(BuildContext context) {
    var options = [
      SpeedDialChild(
        label: "Add Image: Photo Gallery",
        onTap: onGalleryTap,
      ),
      SpeedDialChild(
        label: "AddImage: Clip board",
        onTap: onClipBoardTap,
      ),
      SpeedDialChild(
        label: "Add Image: URL",
        onTap: onURLTap,
      ),
      if (isPremiumUser || kDebugMode) ...{
        SpeedDialChild(
          label: "Add Images: Pinterest idea boards",
          onTap: null,
        )
      }
    ];

    return SpeedDial(
      elevation: 0,
      children: options,
      tooltip: "Add Image",
      child: const Icon(Icons.add_photo_alternate),
    );
  }
}
