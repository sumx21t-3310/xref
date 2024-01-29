import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:xref/application/app_config.dart';
import 'package:xref/application/file_download.dart';
import 'package:xref/application/grid_toggle_notifier.dart';
import 'package:xref/application/history_notifier.dart';
import 'package:xref/canvas_page/canvas_page_app_bar.dart';
import 'package:xref/canvas_page/canvas_page_body.dart';
import 'package:xref/canvas_page/transformation_controller_notifier.dart';
import 'package:xref/components/push_page.dart';
import 'package:xref/components/url_dialog.dart';

import 'canvas_page_speed_dial.dart';

class CanvasPage extends ConsumerStatefulWidget {
  const CanvasPage({super.key, required this.id});

  @override
  ConsumerState<CanvasPage> createState() => _CanvasPageState();
  final String id;
}

class _CanvasPageState extends ConsumerState<CanvasPage> {
  final isPremiumUser = false;

  Future _addScrapFromGallery() async {
    final picker = ImagePicker();
    final xFile = await picker.pickImage(source: ImageSource.gallery);

    if (xFile == null) return;

    final file = File(xFile.path);
    _addImageFile(file);
  }

  Future _addScrapFromClipBoard() async {}

  Future _addScrapFromPinterestBoard() async {}

  Future _addScrapTakePhoto() async {
    final picker = ImagePicker();
    final xFile = await picker.pickImage(source: ImageSource.camera);

    if (xFile == null) return;

    final file = File(xFile.path);
    _addImageFile(file);
  }

  Future _addScrapFromURL() async {
    var url = (await showURLDialog(context, "")) ?? "";

    if (url.isEmpty) return;

    var dir = await getApplicationDocumentsDirectory();
    var file = await downloadFile(Uri.parse(url), dir);

    if (file == null) return;

    _addImageFile(file);
  }

  void _addImageFile(File file) {}

  @override
  Widget build(BuildContext context) {
    var history = ref.watch(historyNotifierProvider);
    var controller = ref.watch(transformationControllerNotifierProvider);
    var visibleGrid = ref.watch(gridToggleNotifierProvider);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CanvasPageAppBar(
        onSettingsTap: () => pushSettingsPage(context),
        onCenterFocusTap: ref
            .read(transformationControllerNotifierProvider.notifier)
            .setInitialPosition,
        visibleGrid: visibleGrid,
        onGridToggle: (value) {
          ref.read(gridToggleNotifierProvider.notifier).setValue(value);
        },
        canUndo: history.canUndo,
        onUndo: ref.read(historyNotifierProvider.notifier).undo,
        canRedo: history.canRedo,
        onRedo: ref.read(historyNotifierProvider.notifier).undo,
        onCloseCanvasTap: () {
          Navigator.of(context).pop();
        },
      ),
      body: CanvasPageBody(
        controller: controller,
        visibleGrid: visibleGrid,
        children: [],
      ),
      floatingActionButton: CanvasPageSpeedDial(
        onGalleryTap: _addScrapFromGallery,
        onClipBoardTap: _addScrapFromClipBoard,
        onURLTap: _addScrapFromURL,
        onPinterestTap: _addScrapFromPinterestBoard,
        onTakePhoto: _addScrapTakePhoto,
        isPremiumUser: isPremiumUser,
        isCameraSupported: AppConfig.isCameraSupported,
      ),
    );
  }
}
