import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_quill/flutter_quill.dart' as Quill;
import 'package:wholesaler_partner/app/modules/add_product/view/widget/editor_widget/editor_controller.dart';
import 'dart:convert';

import 'package:wholesaler_user/app/models/product_image_model.dart';

class EditorWidget extends GetView {
  EditorController ctr = Get.put(EditorController());
  EditorWidget();


  @override
  Widget build(BuildContext context) {
    return  Obx(()=> Column(
        children: [
          Quill.QuillToolbar.basic(
            controller: ctr.editorController.value,
            fontSizeValues: {
              '10': '10',
              '20': '20',
              '30': '30',
              '40': '40',
              '50':'50',
              '60':'60',
              'Clear':'0'
            },
            showAlignmentButtons: false,
            showBackgroundColorButton: true,
            showBoldButton: true,
            showCenterAlignment: false,
            showClearFormat: false,
            showCodeBlock: false,
            showColorButton: true,
            showDirection: false,
            showDividers: false,
            showFontFamily: true,
            showFontSize: true,
            showHeaderStyle: false,
            showIndent: false,
            showInlineCode: false,
            showItalicButton: false,
            showJustifyAlignment: false,
            showLeftAlignment: false,
            showLink: true,
            showListBullets: false,
            showListCheck: false,
            showListNumbers: false,
            showQuote: false,
            showRedo: false,
            showRightAlignment: false,
            showSearchButton: false,
            showSmallButton: false,
            showStrikeThrough: false,
            showUnderLineButton: true,
            showUndo: false,
            multiRowsDisplay: false,
          ),
          Quill.QuillEditor.basic(
            controller: ctr.editorController.value,
            readOnly: false, // true for view only mode
          )
        ],
      ),
    );

  }
}
