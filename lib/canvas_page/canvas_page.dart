import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_box_transform/flutter_box_transform.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_size_getter/file_input.dart';
import 'package:image_size_getter/image_size_getter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:xref/application/app_config.dart';
import 'package:xref/application/box_data.dart';
import 'package:xref/application/file_download.dart';
import 'package:xref/application/grid_toggle_notifier.dart';
import 'package:xref/application/history_notifier.dart';
import 'package:xref/application/save_data_repository.dart';
import 'package:xref/canvas_page/canvas_page_app_bar.dart';
import 'package:xref/canvas_page/canvas_page_body.dart';
import 'package:xref/canvas_page/image_box.dart';
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
  var selectedIndex = -1;

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
    var repository = ref.watch(saveDataRepositoryProvider);
    var saveData = repository.firstWhere((element) => element.id == widget.id);

    var imageSize = ImageSizeGetter.getSize(FileInput(savedFile));

    final newData = saveData.copyWith(
      id: widget.id,
      boxes: [
        ...saveData.boxes,
        BoxData(
          name: savedFile.path,
          visibleHandles: {...HandlePosition.corners},
          rect: Rect.fromCenter(
            center: Offset(
              AppConfig.viewSize.width * .5,
              AppConfig.viewSize.height * .5,
            ),
            width: imageSize.width.toDouble(),
            height: imageSize.height.toDouble(),
          ),
          image: savedFile,
        ),
      ],
    );

    ref.read(saveDataRepositoryProvider.notifier).save(newData);
  }

  @override
  Widget build(BuildContext context) {
    var history = ref.watch(historyNotifierProvider);
    var controller = ref.watch(transformationControllerNotifierProvider);
    var visibleGrid = ref.watch(gridToggleNotifierProvider);
    var saveData = ref
        .watch(saveDataRepositoryProvider)
        .firstWhere((element) => element.id == widget.id);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CanvasPageAppBar(
        onSettingsTap: () => pushSettingsPage(context),
        onCenterFocusTap: () => ref
            .read(transformationControllerNotifierProvider.notifier)
            .setInitialPosition(),
        visibleGrid: visibleGrid,
        onGridToggle: (value) {
          ref.read(gridToggleNotifierProvider.notifier).setValue(value);
        },
        canUndo: history.canUndo,
        onUndo: ref.read(historyNotifierProvider.notifier).undo,
        canRedo: history.canRedo,
        onRedo: ref.read(historyNotifierProvider.notifier).undo,
        onCloseCanvasTap:(){
          ref.read(saveDataRepositoryProvider.notifier).save(saveData);
          Navigator.of(context).pop();
        },
      ),
      body: CanvasPageBody(
        controller: controller,
        visibleGrid: visibleGrid,
        onTap: () => setState(() => selectedIndex = -1),
        children: [
          for (var index = 0; index < saveData.boxes.length; index++) ...{
            ImageBox(
              boxData: saveData.boxes[index],
              isSelect: selectedIndex == index,
              onSelect: () => setState(() => selectedIndex = index),
              onChanged: (result, details) {
                saveData.boxes[index].rect = result.rect;

                ref.watch(saveDataRepositoryProvider.notifier).save(saveData);
              },
            )
          }
        ],
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
