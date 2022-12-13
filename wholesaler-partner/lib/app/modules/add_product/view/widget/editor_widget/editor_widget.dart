import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:wholesaler_partner/app/modules/add_product/view/widget/editor_widget/editor_controller.dart';
import 'dart:convert';

import 'package:wholesaler_user/app/models/product_image_model.dart';

class EditorWidget extends GetView {
  EditorController ctr = Get.put(EditorController());
  EditorWidget();

  @override
  Widget build(BuildContext context) {
    return HtmlEditor(
      controller: ctr.editorController,
      htmlEditorOptions: HtmlEditorOptions(
        hint: '상품 설명을 입력해주세요.',
        // initialText: "<p>text content initial, if any</p>",
      ),
      htmlToolbarOptions: HtmlToolbarOptions(
        toolbarPosition: ToolbarPosition.aboveEditor, //by default
        toolbarType: ToolbarType.nativeGrid, //by default
        onButtonPressed:
            (ButtonType type, bool? status, Function? updateStatus) {
          print(
              "sajad button pressed, the current selected status is $status and the type is $type updateStatus is $updateStatus");
          return true;
        },
        onDropdownChanged: (DropdownType type, dynamic changed,
            Function(dynamic)? updateSelectedItem) {
          print("sajad dropdown  changed to $changed");
          return true;
        },
        mediaLinkInsertInterceptor: (String url, InsertFileType type) {
          return false;
        },
        // mediaUploadInterceptor: (PlatformFile file, InsertFileType type) async {
        mediaUploadInterceptor: (file, InsertFileType type) async {
          print('sajad file.name ${file.name}'); //filename
          print('sajad file.size ${file.size}'); //size in bytes
          print(
              'sajad file.extension ${file.extension}'); //file extension (eg jpeg or mp4)
          print('sajad file.path ${file.path}');

          // change image width to 100%
          if (type == InsertFileType.image) {
            ProductImageModel tempImgModel =
                await ctr.uploadImageToServer(file);
            // ctr.editorController.insertNetworkImage(tempImgModel.url);
            String image100Witdh =
                """<img src="${tempImgModel.url}" data-filename="${file.name}" width="100%"/>""";
            ctr.editorController.insertHtml(image100Witdh);
          }

          return false;
        },
      ),
      otherOptions: OtherOptions(
        height: 700,
      ),
      callbacks: Callbacks(onBeforeCommand: (String? currentHtml) {
        print('sajad html before change is $currentHtml');
      }, onChangeContent: (String? changed) {
        // print('sajad content changed to $changed');
      }, onChangeCodeview: (String? changed) {
        // print('sajad code changed to $changed');
      }, onChangeSelection: (EditorSettings settings) {
        print('sajad parent element is ${settings.parentElement}');
        print('font name is ${settings.fontName}');
      }, onDialogShown: () {
        print('sajad dialog shown');
      }, onEnter: () {
        print('sajad enter/return pressed');
      }, onFocus: () {
        print('sajad editor focused');
      }, onBlur: () {
        print('sajad editor unfocused');
      }, onBlurCodeview: () {
        print('sajad codeview either focused or unfocused');
      }, onInit: () {
        print('sajad init');
      },
          //this is commented because it overrides the default Summernote handlers
          //     onImageLinkInsert: (String? url) {
          //   print('sajad onImageLinkInsert url $url');
          // },
          onImageUpload: (FileUpload file) async {
        print('sajad onImageUpload file name is ${file.name}');
        print('sajad onImageUpload file size is ${file.size}');
        print('sajad onImageUpload file type is ${file.type}');
        print('sajad onImageUpload file base64 is ${file.base64}');
      }, onImageUploadError:
              (FileUpload? file, String? base64Str, UploadError error) {
        print('sajad base64Str is $base64Str');
        print('sajad error is $error');
        if (file != null) {
          print('sajad file name is ${file.name}');
          print('sajad file size is ${file.size}');
          print('sajad file type is ${file.type}');
        }
      }, onKeyDown: (int? keyCode) {
        print('sajad $keyCode key downed');
        print('sajad current character count: ');
      }, onKeyUp: (int? keyCode) {
        print('sajad $keyCode key released');
      }, onMouseDown: () {
        print('sajad mouse downed');
      }, onMouseUp: () {
        print('sajad mouse released');
      }, onNavigationRequestMobile: (String url) {
        print('sajad onNavigationRequestMobile url $url');
        return NavigationActionPolicy.ALLOW;
      }, onPaste: () {
        print('pasted into editor');
      }, onScroll: () {
        print('editor scrolled');
      }),
      plugins: [
        SummernoteAtMention(
            getSuggestionsMobile: (String value) {
              var mentions = <String>['test1', 'test2', 'test3'];
              return mentions
                  .where((element) => element.contains(value))
                  .toList();
            },
            mentionsWeb: ['test1', 'test2', 'test3'],
            onSelect: (String value) {
              print('sajad value is $value');
            }),
      ],
    );
  }
}
