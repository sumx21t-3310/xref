import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_box_transform/flutter_box_transform.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_size_getter/file_input.dart';
import 'package:image_size_getter/image_size_getter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:xref/application/app_config.dart';
import 'package:xref/application/save_data.dart';
import 'package:xref/canvas_page/box_data.dart';

import 'file_download.dart';

ChangeNotifierProvider createSaveDataModelNotifier(SaveData saveData) {
  return ChangeNotifierProvider((ref) => null);
}

class SaveDataModel extends ChangeNotifier {
  SaveDataModel(this._saveData);

  SaveData get saveData => _saveData;

  final SaveData _saveData;
  int _selectBoxIndex = -1;

  bool get isSelect => _selectBoxIndex < 0;

  void addNewBox(File file) async {
    final directory = await getApplicationSupportDirectory();
    final savedImage = await copyToDirectory(file, directory);
    final imageSize = ImageSizeGetter.getSize(FileInput(savedImage));

    final rect = Rect.fromCenter(
      center: Offset(
        AppConfig.viewSize.width / 2,
        AppConfig.viewSize.height / 2,
      ),
      width: imageSize.width.toDouble(),
      height: imageSize.height.toDouble(),
    );

    final newBox = ImageBoxData(rect: rect, image: savedImage);
    _saveData.boxes.add(newBox);

    notifyListeners();
  }

  void removeSelectBox() {
    if (isSelect == false) return;

    saveData.boxes.removeAt(_selectBoxIndex);
    _clearSelect();
    notifyListeners();
  }

  void onSelect(int selected) {
    _selectBoxIndex = selected;
    notifyListeners();
  }

  void _clearSelect() => _selectBoxIndex = -1;

  void onChanged(UITransformResult result) {
    if (_selectBoxIndex < -1) return;

    saveData.boxes[_selectBoxIndex].rect = result.rect;

    notifyListeners();
  }
}
