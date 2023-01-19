import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/constant/enums.dart';
import 'package:wholesaler_partner/app/models/add_product/option.dart';
import 'package:wholesaler_partner/app/models/add_product/product_body_size/product_body_size_model.dart';
import 'package:wholesaler_partner/app/models/add_product/product_body_size/size_category.dart';
import 'package:wholesaler_partner/app/modules/add_product/controller/add_product_controller.dart';
import 'package:wholesaler_partner/app/modules/add_product/part2_image_sizetable_options/controller/part2_image_sizetable_options_controller.dart';
import 'package:wholesaler_user/app/Constants/styles.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/widgets/category_tags/cloth_category.dart';
import 'package:wholesaler_user/app/widgets/snackbar.dart';

class AP_Part2View extends GetView<AP_Part2Controller> {
  AP_Part2Controller ctr = Get.put(AP_Part2Controller());
  AddProductController addProductCtr = Get.put(AddProductController());

  @override
  Widget build(BuildContext context) {
    // AP_Part2ColorController ctr2 = Get.put(AP_Part2ColorController());

    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 25),
            _title(),
            SizedBox(height: 5),
            // cloth pictures
            _clothPicture(),
            _sizeTable(),
            // 옵션 단가등록
            //_unitPriceCheckbox(),
            // Column(
            //   children: [
            //     // ctr.unitPriceCheckbox.isTrue &&
            //     //     ctr.isOptionCheckbox.isTrue
            //     //     ?
            //     //  : Container(),
            //   ],
            // ),

            _optionUnitPriceChildrenNewMode(),
            // aaa(),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  aaa() {
    final unitPriceChildren = <Widget>[];

    int aa = 0;

    for (var colorIndex = 0;
        colorIndex < addProductCtr.colorsList.length;
        colorIndex++) {
      // print(addProductCtr.options.length);
      if (ctr.productBodySizeList
          .firstWhere((element) => element.size == 'FREE')
          .isSelected
          .value) {
        unitPriceChildren.add(_unitPriceTile(colorIndex, aa, 'FREE'));
        aa++;
      }

      if (ctr.productBodySizeList
          .firstWhere((element) => element.size == 'XS')
          .isSelected
          .value) {
        unitPriceChildren.add(_unitPriceTile(colorIndex, aa, 'XS'));
        aa++;
      }
      if (ctr.productBodySizeList
          .firstWhere((element) => element.size == 'S')
          .isSelected
          .value) {
        unitPriceChildren.add(_unitPriceTile(colorIndex, aa, 'S'));
        aa++;
      }
      if (ctr.productBodySizeList
          .firstWhere((element) => element.size == 'M')
          .isSelected
          .value) {
        unitPriceChildren.add(_unitPriceTile(colorIndex, aa, 'M'));
        aa++;
        // print(addProductCtr.options.length);
      }
      if (ctr.productBodySizeList
          .firstWhere((element) => element.size == 'L')
          .isSelected
          .value) {
        unitPriceChildren.add(_unitPriceTile(colorIndex, aa, 'L'));
        aa++;
      }
    }

    return Column(
      children: unitPriceChildren,
    );
  }

  Widget _title() {
    return Text(
      'Enter_option'.tr,
      style: MyTextStyles.f16.copyWith(color: MyColors.black2),
    );
  }

  List<String> subCatImageList = [
    '', //양말
    '', //스타킹
    '', //목걸이
    '', //귀걸이
    '', //모자
    '', //헤어밴드
    '', //헤어핀/집게
    '', //헤어스크런치
    '', //벨트
    '', //시계
    '', //머플러
    '', //장갑
    '', //이너웨어(상의)
    '', //이너웨어(하의)
    'assets/diagraming/가방.jpg', //백팩&클러치
    'assets/diagraming/가방.jpg', //숄더백
    'assets/diagraming/가방.jpg', //크로스백
    'assets/diagraming/가방.jpg', //토트백
    'assets/diagraming/가방.jpg', //에코백
    'assets/diagraming/[신발]샌들_플랫_로퍼_힐_스니커즈.jpg', //샌들
    'assets/diagraming/[신발]샌들_플랫_로퍼_힐_스니커즈.jpg', //플랫
    'assets/diagraming/[신발]샌들_플랫_로퍼_힐_스니커즈.jpg', //로퍼
    'assets/diagraming/[신발]부츠.jpg', //부츠
    'assets/diagraming/[신발]샌들_플랫_로퍼_힐_스니커즈.jpg', //힐
    'assets/diagraming/[신발]샌들_플랫_로퍼_힐_스니커즈.jpg', //스니커즈
    'assets/diagraming/[아우터]코트.jpg', //코트
    'assets/diagraming/[아우터]자켓_무스탕&퍼.jpg', //자켓
    'assets/diagraming/[아우터]점퍼.jpg', //점퍼
    'assets/diagraming/[아우터]가디건.jpg', //가디건
    'assets/diagraming/[아우터]자켓_무스탕&퍼.jpg', //무스탕&퍼
    'assets/diagraming/[아우터]베스트.jpg', //아우터베스트
    'assets/diagraming/[상의]티셔츠_니트&스웨터_맨투맨.jpg', //티셔츠
    'assets/diagraming/[상의]블라우스&셔츠.jpg', //블라우스&셔츠
    'assets/diagraming/[상의]티셔츠_니트&스웨터_맨투맨.jpg', //니트&스웨터
    'assets/diagraming/[상의]티셔츠_니트&스웨터_맨투맨.jpg', //맨투맨
    'assets/diagraming/[상의]후드.jpg', //후드
    'assets/diagraming/[상의]뷔스티에&슬리브리스.jpg', //뷔스티에&슬리브리스
    'assets/diagraming/[상의]베스트.jpg', //상의베스트
    'assets/diagraming/[바지]슬랙스_면바지_데님_조거&트레이닝.jpg', //슬랙스
    'assets/diagraming/[바지]슬랙스_면바지_데님_조거&트레이닝.jpg', //면바지
    'assets/diagraming/[바지]슬랙스_면바지_데님_조거&트레이닝.jpg', //데님
    'assets/diagraming/[바지]슬랙스_면바지_데님_조거&트레이닝.jpg', //조거트레이닝
    'assets/diagraming/[바지]반바지.jpg', //반바지
    'assets/diagraming/[스커트]미니스커트_미디스커트_롱스커트.jpg', //미니스커트
    'assets/diagraming/[스커트]미니스커트_미디스커트_롱스커트.jpg', //미디스커트
    'assets/diagraming/[스커트]미니스커트_미디스커트_롱스커트.jpg', //롱스커트
    'assets/diagraming/[원피스]미니원피스_미디원피스_롱원피스.jpg', //미니원피스
    'assets/diagraming/[원피스]미니원피스_미디원피스_롱원피스.jpg', //미디원피스
    'assets/diagraming/[원피스]미니원피스_미디원피스_롱원피스.jpg', //롱원피스
    'assets/diagraming/[원피스]점프수트.jpg', //점프슈트
    '', //치마셑
    '', //바지셋
  ];

  Widget _clothPicture() {
    print('addProductCtr.selectedSubCat.value.id');
    print(addProductCtr.selectedSubCat.value.id);
    if (addProductCtr.selectedSubCat.value.id == -1) {
      return SizedBox.shrink();
    } else if (addProductCtr.selectedSubCat.value.id ==
        ClothSubCategoryEnum.SKIRTSSET) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                // ClothCategory.clothImages[addProductCtr.category.value.title]!,
                'assets/diagraming/[상의]티셔츠_니트&스웨터_맨투맨.jpg', fit: BoxFit.fill,
              ),
              Image.asset(
                // ClothCategory.clothImages[addProductCtr.category.value.title]!,
                'assets/diagraming/[스커트]미니스커트_미디스커트_롱스커트.jpg',
                fit: BoxFit.fill,
              ),
            ],
          ),
        ),
      );
    } else if (addProductCtr.selectedSubCat.value.id ==
        ClothSubCategoryEnum.PANTSSET) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                // ClothCategory.clothImages[addProductCtr.category.value.title]!,
                'assets/diagraming/[상의]티셔츠_니트&스웨터_맨투맨.jpg', fit: BoxFit.fill,
              ),
              Image.asset(
                // ClothCategory.clothImages[addProductCtr.category.value.title]!,
                'assets/diagraming/[바지]슬랙스_면바지_데님_조거&트레이닝.jpg',
                fit: BoxFit.fill,
              ),
            ],
          ),
        ),
      );
    } else if (subCatImageList[
            addProductCtr.selectedSubCat.value.id - ClothSubCategoryEnum.SOX] ==
        '') {
      return SizedBox.shrink();
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Center(
          child: Image.asset(
            // ClothCategory.clothImages[addProductCtr.category.value.title]!,
            subCatImageList[addProductCtr.selectedSubCat.value.id -
                ClothSubCategoryEnum.SOX],
            fit: BoxFit.fill,
          ),
        ),
      );
    }
  }

  Widget _sizeTable() {
    return addProductCtr.category != null
        ? Center(
            child: Table(
              children: [
                TableRow(children: [
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: SizedBox(
                      height: 20,
                      width: 20,
                      child: Center(
                        child: Text('SIZE'),
                      ),
                    ),
                  ),
                  for (int i = 0; i < ctr.productBodySizeList.length; i++)
                    // size title: FREE, XS
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: _sizeCategory(
                        value: ctr.productBodySizeList[i].size,
                        isEnable: ctr.productBodySizeList[i].isSelected,
                      ),
                    ),
                ]),
                for (int k = 0;
                    k <
                        // SizeCategory.getWithCatId(
                        //         addProductCtr.category.value.id)
                        //     .children
                        //     .length;

                        SizeCategory.getWithCatId(
                                addProductCtr.selectedSubCat.value.id)
                            .children
                            .length;
                    k++)
                  TableRow(children: [
                    // size field: ex 가슴단면
                    TableCell(
                      // child: _sizeTitle(SizeCategory.getWithCatId(
                      //         addProductCtr.category.value.id)
                      //     .children[k]
                      //     .korean)),
                      child: _sizeTitle(SizeCategory.getWithCatId(
                              addProductCtr.selectedSubCat.value.id)
                          .children[k]
                          .korean),
                    ),
                    // textfields holding values inside table
                    for (int j = 0; j < ctr.productBodySizeList.length; j++)
                      // ctr.productBodySizeList[j].sizeCategory.seunghanTestValue;
                      sizeFieldBuilder(
                          productBodySizeListIndex: j,
                          sizeCategoryIndex: k,
                          isLining: SizeCategory.getWithCatId(
                                          addProductCtr.selectedSubCat.value.id)
                                      .children[k]
                                      .english ==
                                  'lining'
                              ? true
                              : false),
                  ]),
              ],
            ),
          )
        : SizedBox.shrink();
  }

  // size title: FREE, XS
  Widget _sizeCategory({required String value, required RxBool isEnable}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Center(
          child: isEnable.value
              ? ElevatedButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero, // and this
                  ),
                  onPressed: () => isEnable.toggle(),
                  child: Text(
                    value,
                    style: MyTextStyles.f11.copyWith(
                        color:
                            isEnable.value ? MyColors.black : MyColors.grey8),
                  ),
                )
              : OutlinedButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero, // and this
                  ),
                  onPressed: () => isEnable.toggle(),
                  child: Text(
                    value,
                    style: MyTextStyles.f11.copyWith(
                        color:
                            isEnable.value ? MyColors.black : MyColors.grey8),
                  ),
                )),
    );
  }

  // size title: FREE, XS
  Widget _sizeTitle(String title) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: Text(
        title,
        style: MyTextStyles.f12,
      ),
    ));
  }

  sizeFieldBuilder(
      {required int productBodySizeListIndex,
      required int sizeCategoryIndex,
      required bool isLining}) {
    ctr.sizeFieldInitialize(
        productBodySizeListIndex: productBodySizeListIndex,
        sizeCategoryIndex: sizeCategoryIndex);

    return TableCell(
        child: _sizeField(
      isActive: ctr.productBodySizeList[productBodySizeListIndex].isSelected,
      productBodySizeListIndex: productBodySizeListIndex,
      sizeCategoryIndex: sizeCategoryIndex,
      isLining: isLining,
    ));
  }

  Widget _sizeField({
    required RxBool isActive,
    required int productBodySizeListIndex,
    required int sizeCategoryIndex,
    required bool isLining,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        height: 35,
        child: Obx(
          () => TextField(
            textAlign: TextAlign.center,
            controller: ctr.textEditingControllers[
                productBodySizeListIndex.toString() +
                    sizeCategoryIndex.toString()],
            readOnly: !isActive.value,
            keyboardType: isLining ? TextInputType.text : TextInputType.number,
            onChanged: (String value) => ctr.sizetableFieldChanged(
                value: value,
                productBodySizeListIndex: productBodySizeListIndex,
                sizeCategoryIndex: sizeCategoryIndex),
            style: isActive.value
                ? MyTextStyles.f12
                : MyTextStyles.f12.copyWith(color: MyColors.grey8),
            decoration: InputDecoration(
              hintText: isLining ? '유/무' : '',
              hintStyle: TextStyle(fontSize: 9, color: MyColors.grey1),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: isActive.value ? MyColors.grey9 : MyColors.grey1,
                    width: 1.0),
              ),
              border: OutlineInputBorder(),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
            ),
          ),
        ),
      ),
    );
  }

  // 옵션 단가등록
  Widget _unitPriceCheckbox() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          SizedBox(
            height: 25,
            width: 25,
            child: Checkbox(
              activeColor: MyColors.primary,
              value: ctr.isOptionCheckbox.value,
              // onChanged: (value) => null,
              onChanged: (value) => ctr.isOptionCheckbox.toggle(),
            ),
          ),
          Text('옵션 추가 금액'),
        ],
      ),
    );
  }

  _optionUnitPriceChildrenNewMode() {
    if (addProductCtr.colorsList.isEmpty) {
      return Center(
        child: Text("색상추가하세요."),
      );
    }
    if (ctr.productBodySizeList.isEmpty) {
      return Center(child: Text('사이즈 추가하세요.'));
    }
    final unitPriceChildren = <Widget>[];
    for (var colorIndex = 0;
        colorIndex < addProductCtr.colorsList.length;
        colorIndex++) {
      // FREE, XS, S, M, L
      if (ctr.productBodySizeList
          .firstWhere((element) => element.size == 'FREE')
          .isSelected
          .value) {
        Option? option;

        if (addProductCtr.isEditing.isTrue) {
          option = addProductCtr.productModifyModel.value.options!
              .firstWhereOrNull((option) =>
                  option.size == 'FREE' &&
                  option.color == addProductCtr.colorsList[colorIndex]);
        }
        print(option);
        addProductCtr.optionsControllers.add(TextEditingController(
            text: option != null ? option.addPrice : '0'));
        addProductCtr.options.add(Option(
            color: addProductCtr.colorsList[colorIndex],
            size: 'FREE',
            addPrice: option != null ? option.addPrice : '0'));
        unitPriceChildren.add(
            _unitPriceTile(colorIndex, addProductCtr.options.length, 'FREE'));
      }
      if (ctr.productBodySizeList
          .firstWhere((element) => element.size == 'XS')
          .isSelected
          .value) {
        Option? option;
        if (addProductCtr.isEditing.isTrue) {
          option = addProductCtr.productModifyModel.value.options!
              .firstWhereOrNull((option) =>
                  option.size == 'XS' &&
                  option.color == addProductCtr.colorsList[colorIndex]);
        }
        addProductCtr.optionsControllers.add(TextEditingController(
            text: option != null ? option.addPrice : '0'));
        addProductCtr.options.add(Option(
            color: addProductCtr.colorsList[colorIndex],
            size: 'XS',
            addPrice: option != null ? option.addPrice : '0'));
        unitPriceChildren.add(
            _unitPriceTile(colorIndex, addProductCtr.options.length, 'XS'));
      }
      if (ctr.productBodySizeList
          .firstWhere((element) => element.size == 'S')
          .isSelected
          .value) {
        Option? option;
        if (addProductCtr.isEditing.isTrue) {
          option = addProductCtr.productModifyModel.value.options!
              .firstWhereOrNull((option) =>
                  option.size == 'S' &&
                  option.color == addProductCtr.colorsList[colorIndex]);
        }
        addProductCtr.optionsControllers.add(TextEditingController(
            text: option != null ? option.addPrice : '0'));
        addProductCtr.options.add(Option(
            color: addProductCtr.colorsList[colorIndex],
            size: 'S',
            addPrice: option != null ? option.addPrice : '0'));
        unitPriceChildren
            .add(_unitPriceTile(colorIndex, addProductCtr.options.length, 'S'));
      }
      if (ctr.productBodySizeList
          .firstWhere((element) => element.size == 'M')
          .isSelected
          .value) {
        Option? option;
        if (addProductCtr.isEditing.isTrue) {
          option = addProductCtr.productModifyModel.value.options!
              .firstWhereOrNull((option) =>
                  option.size == 'M' &&
                  option.color == addProductCtr.colorsList[colorIndex]);
        }
        addProductCtr.optionsControllers.add(TextEditingController(
            text: option != null ? option.addPrice : '0'));
        addProductCtr.options.add(Option(
            color: addProductCtr.colorsList[colorIndex],
            size: 'M',
            addPrice: option != null ? option.addPrice : '0'));
        unitPriceChildren
            .add(_unitPriceTile(colorIndex, addProductCtr.options.length, 'M'));
      }
      if (ctr.productBodySizeList
          .firstWhere((element) => element.size == 'L')
          .isSelected
          .value) {
        Option? option;
        if (addProductCtr.isEditing.isTrue) {
          option = addProductCtr.productModifyModel.value.options!
              .firstWhereOrNull((option) =>
                  option.size == 'L' &&
                  option.color == addProductCtr.colorsList[colorIndex]);
        }
        addProductCtr.optionsControllers.add(TextEditingController(
            text: option != null ? option.addPrice : '0'));
        addProductCtr.options.add(Option(
            color: addProductCtr.colorsList[colorIndex],
            size: 'L',
            addPrice: option != null ? option.addPrice : '0'));
        unitPriceChildren
            .add(_unitPriceTile(colorIndex, addProductCtr.options.length, 'L'));
      }
    }

    if (addProductCtr.colorsList.isEmpty) {
      return Center(child: Text('색상 추가하세요.'));
    } else {
      return Column(
        children: unitPriceChildren,
      );
    }
  }

  Widget _unitPriceTile(int colorIndex, int currentOptionLength, String size) {
    print('currentOptionLength ${currentOptionLength}');
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        color: MyColors.grey1,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              SizedBox(
                width: 80,
                child: Text(
                  addProductCtr.colorsList[colorIndex],
                  style: MyTextStyles.f14.copyWith(color: MyColors.black2),
                ),
              ),
              Container(
                height: 20,
                child: VerticalDivider(
                  thickness: 1,
                  color: MyColors.subTitle,
                ),
              ),
              SizedBox(width: 10),
              SizedBox(
                width: 60,
                child: Center(
                  child: Text(
                    size,
                    style: MyTextStyles.f14.copyWith(color: MyColors.black2),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Text(
                '추가금액',
                style: MyTextStyles.f14.copyWith(color: MyColors.black1),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Container(
                  child: TextField(
                      controller: addProductCtr
                          .optionsControllers[currentOptionLength - 1],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          fillColor: MyColors.white,
                          filled: true,
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 0.0))),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Widget _unitPriceTileEditMode(int optionIndex) {
  //   return Padding(
  //     padding: const EdgeInsets.all(5.0),
  //     child: Container(
  //       color: MyColors.grey1,
  //       child: Padding(
  //         padding: const EdgeInsets.all(10.0),
  //         child: Row(
  //           children: [
  //             SizedBox(
  //               width: 80,
  //               child: Text(
  //                 addProductCtr.options[optionIndex].color!,
  //                 style: MyTextStyles.f14.copyWith(color: MyColors.black2),
  //               ),
  //             ),
  //             Container(
  //               height: 20,
  //               child: VerticalDivider(
  //                 thickness: 1,
  //                 color: MyColors.subTitle,
  //               ),
  //             ),
  //             SizedBox(width: 10),
  //             SizedBox(
  //               width: 60,
  //               child: Center(
  //                 child: Text(
  //                   addProductCtr.options[optionIndex].size!,
  //                   style: MyTextStyles.f14.copyWith(color: MyColors.black2),
  //                 ),
  //               ),
  //             ),
  //             SizedBox(width: 10),
  //             Text(
  //               'Price'.tr,
  //               style: MyTextStyles.f14.copyWith(color: MyColors.black1),
  //             ),
  //             SizedBox(width: 10),
  //             Expanded(
  //               child: Container(
  //                 child: TextField(
  //                     controller: addProductCtr.optionsControllers[optionIndex],
  //                     keyboardType: TextInputType.number,
  //                     decoration: InputDecoration(
  //                         fillColor: MyColors.white,
  //                         filled: true,
  //                         focusedBorder: UnderlineInputBorder(
  //                           borderSide: BorderSide(color: Colors.white),
  //                         ),
  //                         enabledBorder: UnderlineInputBorder(
  //                           borderSide: BorderSide(color: Colors.white),
  //                         ),
  //                         contentPadding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0))),
  //               ),
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
