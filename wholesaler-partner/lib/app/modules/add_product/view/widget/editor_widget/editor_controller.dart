import 'dart:io';

// import 'package:file_picker/src/platform_file.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:flutter_quill/flutter_quill.dart' as Quill;
import 'package:wholesaler_partner/app/data/api_provider.dart';
import 'package:wholesaler_user/app/models/product_image_model.dart';

class EditorController extends GetxController {
  // pApiProvider _apiProvider = pApiProvider();

  RxBool aa = false.obs;

  Rx<Quill.QuillController> editorController = Quill.QuillController(
    document: Document(),
    selection: const TextSelection.collapsed(offset: 0),
    // onSelectionCompleted: () {
    //   print('asdfasdf');
    //   // print(textSelection.start);
    //   // print(textSelection.end);
    //   // print(textSelection.base);
    //   // print(editorController.value.plainTextEditingValue);
    // },
  ).obs;

  @override
  void onInit() {
    print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
    // editorController = Quill.QuillController.basic().obs;
    // editorController.value.onSelectionChanged = (textSelection) {
    //   print(textSelection.baseOffset);
    //   print(textSelection.extentOffset);
    //   print(textSelection.base);
    //   print(textSelection.isDirectional);
    //   if (textSelection.baseOffset != textSelection.extentOffset) {
    //     // aa.value = true;
    //   }
    //   else{
    //     // aa.value = false;
    //   }
    // };
    super.onInit();
  }

  @override
  void onClose() {
    editorController.value.dispose();
    editorController.close();
    super.onClose();
  }

  // Future<ProductImageModel> uploadImageToServer(PlatformFile file) async {
  //   ProductImageModel tempImgModel = await _apiProvider.uploadProductImage(pickedImage: File(file.path!));
  //   return tempImgModel;
  // }
}
