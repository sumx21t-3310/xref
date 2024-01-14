import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:xref/application/app_config.dart';
import 'package:xref/application/file_download.dart';
import 'package:xref/application/save_data.dart';
import 'package:xref/application/save_data_notifier.dart';
import 'package:xref/canvas_page/states/canvas_body_transformation_controller_notifier.dart';
import 'package:xref/canvas_page/states/grid_toggle_notifier.dart';
import 'package:xref/canvas_page/states/history_notifier.dart';
import 'package:xref/canvas_page/views/canvas_page_app_bar.dart';
import 'package:xref/canvas_page/views/canvas_page_body.dart';
import 'package:xref/canvas_page/views/imageBox.dart';
import 'package:xref/components/url_dialog.dart';
import 'package:xref/settings_page/settings_page.dart';

import 'canvas_page_speed_dial.dart';

class CanvasPage extends ConsumerStatefulWidget {
  const CanvasPage({super.key, required this.saveData});

  @override
  ConsumerState<CanvasPage> createState() => _CanvasPageState();
  final SaveData saveData;
}

class _CanvasPageState extends ConsumerState<CanvasPage> with RouteAware {
  /// region state var.
  final isPremiumUser = false;
  final _scraps = <ImageBox>[];

  /// endregion

  /// region canvas page functions
  Future _initScraps(List<File> files) async {
    for (var file in files) {
      _scraps.add(ImageBox(file: file));
    }

    ref
        .read(transformationControllerNotifierProvider.notifier)
        .setInitialPosition();
  }

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

    if (file == null) {
      return;
    }

    _addImageFile(file);
  }

  Future _addImageFile(File file) async {
    var directory = await getApplicationSupportDirectory();
    var savedFile = await copyToDirectory(file, directory);
    ref
        .read(transformationControllerNotifierProvider.notifier)
        .setInitialPosition();
    ref.read(saveDataNotifierProvider.notifier).addFile(savedFile);
  }

  void routeSettingsPage() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const SettingsPage()),
    );
  }

  /// endregion

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var history = ref.watch(historyNotifierProvider);
    var controller =
        ref.watch(transformationControllerNotifierProvider.notifier);
    var visibleGrid = ref.watch(gridToggleNotifierProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CanvasPageAppBar(
        onSettingsTap: routeSettingsPage,
        onCenterFocusTap: () => controller.setInitialPosition(),
        visibleGrid: visibleGrid,
        onGridToggle: (value) {
          ref.read(gridToggleNotifierProvider.notifier).toggle(value);
        },
        canUndo: history.canUndo,
        onUndo: history.undo,
        canRedo: history.canRedo,
        onRedo: history.redo,
      ),
      body: CanvasPageBody(
        children: _scraps,
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
