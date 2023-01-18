import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:flutter_quill/flutter_quill.dart' as Quill;
import 'package:wholesaler_partner/app/modules/add_product/view/widget/editor_widget/editor_controller.dart';
import 'dart:convert';

import 'package:wholesaler_user/app/models/product_image_model.dart';

class EditorWidget extends GetView {
  EditorController ctr = Get.put(EditorController());
  // EditorWidget();

  final Map<String, String> _fontFamilyValues = {
    '기본': 'SpoqaHanSansNeo-Medium',
    '본고딕': 'Noto_Sans',
    '본명조': 'Noto_Serif',
    '나눔고딕': 'Nanum_Gothic',
    '나눔명조': 'Nanum_Myeongjo'
  };

  // QuillController tt = QuillController.basic();
  @override
  Widget build(BuildContext context) {
    // print("또 빌드 여러번>???");
    // ctr.editorController.value.addListener(() {
    //   // print(ctr.editorController.value.document.length);
    //   print(ctr.editorController.value.getSelectionStyle());
    //   // length가 줄어들면
    //   // print(ctr.editorController.value.changes);
    //   // print(jsonEncode(ctr.editorController.value.document.toDelta().toJson()));
    // });

    // ctr.editorController.value.document.changes.listen((event) {
    //   // print(event.item1); //Delta
    //   if (event.item2.toString().substring(0, 6) == 'retain')
    //     print(event.item2.toString().substring(0, 6)); //Delta
    //   // print(event.item3); //ChangeSource
    // });
    return Obx(
      () => Column(
        children: [
          // QuillEditor(
          //   locale: Locale('ko', 'KR'),
          //   minHeight: 300,
          //   maxHeight: 500,
          //   controller: ctr.editorController.value,
          //   scrollController: ScrollController(),
          //   scrollable: false,
          //   focusNode: FocusNode(),
          //   autoFocus: false,
          //   padding: EdgeInsets.zero,
          //   expands: false,
          //   readOnly: false,
          //   showCursor: true,
          // ),
          Container(
            height: 200, decoration: BoxDecoration(border: Border.all()),
            // child: Quill.QuillEditor.basic(
            //   controller: ctr.editorController.value,
            //   readOnly: false, // true for view only mode
            // ),
            child: QuillEditor(
              // onSingleLongTapStart: (details, p1) {
              //   print(ctr.editorController.value.selection.start);
              //   print(ctr.editorController.value.selection.end);

              //   if (ctr.editorController.value.selection.start !=
              //       ctr.editorController.value.selection.end) {
              //     ctr.aa.value = true;
              //   } else {
              //     ctr.aa.value = false;
              //   }
              //   return false;
              // },
              // onSingleLongTapEnd: (details, p1) {
              //   print(ctr.editorController.value.selection.start);
              //   print(ctr.editorController.value.selection.end);
              //   if (ctr.editorController.value.selection.start !=
              //       ctr.editorController.value.selection.end) {
              //     ctr.aa.value = true;
              //   } else {
              //     ctr.aa.value = false;
              //   }
              //   return false;
              // },
              // onSingleLongTapMoveUpdate: (details, p1) {
              //   print(ctr.editorController.value.selection.start);
              //   print(ctr.editorController.value.selection.end);
              //   if (ctr.editorController.value.selection.start !=
              //       ctr.editorController.value.selection.end) {
              //     ctr.aa.value = true;
              //   } else {
              //     ctr.aa.value = false;
              //   }
              //   return true;
              // },
              // onTapDown: (details, p1) {
              //   print(ctr.editorController.value.selection.start);
              //   print(ctr.editorController.value.selection.end);
              //   if (ctr.editorController.value.selection.start !=
              //       ctr.editorController.value.selection.end) {
              //     ctr.aa.value = true;
              //   } else {
              //     ctr.aa.value = false;
              //   }
              //   return false;
              // },
              // onTapUp: (details, p1) {
              //   print(ctr.editorController.value.selection.start);
              //   print(ctr.editorController.value.selection.end);
              //   if (ctr.editorController.value.selection.start !=
              //       ctr.editorController.value.selection.end) {
              //     ctr.aa.value = true;
              //   } else {
              //     ctr.aa.value = false;
              //   }
              //   return false;
              // },

              // onSingleLongTapStart: (details, p1) {
              //   print('33');

              //   return true;
              // },
              placeholder: ' * 한글은 작성 후 변경할 영역을 선택하여 스타일을 변경해 주세요. ',
              paintCursorAboveText: false,
              controller: ctr.editorController.value,
              scrollController: ScrollController(),
              scrollable: true,
              focusNode: FocusNode(),
              autoFocus: false,
              padding: EdgeInsets.zero,
              expands: false,
              readOnly: false,
              showCursor: true,
              locale: Locale('ko'),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Quill.QuillToolbar.basic(
            fontFamilyValues: _fontFamilyValues,
            controller: ctr.editorController.value,
            fontSizeValues: {
              '10': '10',
              '20': '20',
              '30': '30',
              '40': '40',
              '50': '50',
              '60': '60',
              'Clear': '0'
            },
            showAlignmentButtons: true,
            showBackgroundColorButton: true,
            showBoldButton: true,
            showCenterAlignment: true,
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
            showJustifyAlignment: true,
            showLeftAlignment: true,
            showLink: true,
            showListBullets: false,
            showListCheck: false,
            showListNumbers: false,
            showQuote: false,
            showRedo: false,
            showRightAlignment: true,
            showSearchButton: false,
            showSmallButton: false,
            showStrikeThrough: false,
            showUnderLineButton: true,
            showUndo: false,
            multiRowsDisplay: false,
            locale: Locale('ko'),
            afterButtonPressed: () {
              ctr.aa.value = !ctr.aa.value;
            },
          ),
        ],
      ),
    );

    // return Column(
    //   children: [
    //     Quill.QuillToolbar.basic(
    //       // fontFamilyValues: _fontFamilyValues,
    //       // controller: ctr.editorController.value,
    //       controller: tt,
    //       fontSizeValues: {
    //         '10': '10',
    //         '20': '20',
    //         '30': '30',
    //         '40': '40',
    //         '50': '50',
    //         '60': '60',
    //         'Clear': '0'
    //       },
    //       showAlignmentButtons: true,
    //       showBackgroundColorButton: true,
    //       showBoldButton: true,
    //       showCenterAlignment: true,
    //       showClearFormat: false,
    //       showCodeBlock: false,
    //       showColorButton: true,
    //       showDirection: false,
    //       showDividers: false,
    //       showFontFamily: true,
    //       showFontSize: true,
    //       showHeaderStyle: false,
    //       showIndent: false,
    //       showInlineCode: false,
    //       showItalicButton: false,
    //       showJustifyAlignment: true,
    //       showLeftAlignment: true,
    //       showLink: true,
    //       showListBullets: false,
    //       showListCheck: false,
    //       showListNumbers: false,
    //       showQuote: false,
    //       showRedo: false,
    //       showRightAlignment: true,
    //       showSearchButton: false,
    //       showSmallButton: false,
    //       showStrikeThrough: false,
    //       showUnderLineButton: true,
    //       showUndo: false,
    //       multiRowsDisplay: false,
    //     ),
    //     SizedBox(
    //       height: 45,
    //     ),
    //     Container(
    //       height: 200, decoration: BoxDecoration(border: Border.all()),
    //       // child: Quill.QuillEditor.basic(
    //       //   controller: ctr.editorController.value,
    //       //   readOnly: false, // true for view only mode
    //       // ),
    //       child: QuillEditor(
    //         // controller: ctr.editorController.value,
    //         controller: tt,
    //         scrollController: ScrollController(),
    //         scrollable: false,
    //         focusNode: FocusNode(),
    //         autoFocus: false,
    //         padding: EdgeInsets.zero,
    //         expands: false,
    //         readOnly: false,
    //         showCursor: true,
    //       ),
    //     )
    //   ],
    // );
  }
}
