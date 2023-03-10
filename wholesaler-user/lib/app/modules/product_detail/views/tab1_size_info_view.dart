import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:wholesaler_partner/app/constant/enums.dart';
import 'package:wholesaler_partner/app/modules/add_product/part3_material_clothwash/controller/part3_material_clothwash_controller.dart';
import 'package:wholesaler_partner/app/modules/add_product/view/widget/cloth_wash_toggle/cloth_wash_model.dart';
import 'package:wholesaler_partner/app/modules/add_product/view/widget/cloth_wash_toggle/cloth_wash_toggle.dart';
import 'package:wholesaler_user/app/Constants/colors.dart';
import 'package:wholesaler_user/app/Constants/enum.dart';
import 'package:wholesaler_user/app/Constants/styles.dart';
import 'package:wholesaler_user/app/constants/dimens.dart';
import 'package:wholesaler_user/app/modules/product_detail/controller/product_detail_controller.dart';
import 'package:wholesaler_user/app/modules/product_detail/controller/tab_1_detail_info_controller.dart';
import 'package:wholesaler_user/app/modules/product_detail/views/size_table_widget.dart';
import 'package:wholesaler_user/app/widgets/webview_builder_flex_height.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;

class Tab4SizeInfo extends GetView {
  Tab1DetailInfoController ctr = Tab1DetailInfoController();
  ProductDetailController productDetailCtr = Get.put(ProductDetailController());
  AP_Part3Controller addProduct3Ctr = Get.put(AP_Part3Controller());

  // Tab1DetailInfo();

  List<String> subCatImageList = [
    'assets/diagraming/[상의]티셔츠_니트&스웨터_맨투맨.jpg', //티셔츠
    'assets/diagraming/[상의]블라우스&셔츠.jpg', //블라우스&셔츠
    'assets/diagraming/[상의]티셔츠_니트&스웨터_맨투맨.jpg', //니트&스웨터
    'assets/diagraming/[상의]티셔츠_니트&스웨터_맨투맨.jpg', //맨투맨
    'assets/diagraming/[상의]후드.jpg', //후드
    'assets/diagraming/[상의]뷔스티에&슬리브리스.jpg', //뷔스티에&슬리브리스
    'assets/diagraming/[상의]베스트.jpg', //상의베스트
    'assets/diagraming/[아우터]코트.jpg', //코트
    'assets/diagraming/[아우터]자켓_무스탕&퍼.jpg', //자켓
    'assets/diagraming/[아우터]점퍼.jpg', //점퍼
    'assets/diagraming/[아우터]가디건.jpg', //가디건
    'assets/diagraming/[아우터]자켓_무스탕&퍼.jpg', //무스탕&퍼
    'assets/diagraming/[아우터]베스트.jpg', //아우터베스트
    'assets/diagraming/[원피스]미니원피스_미디원피스_롱원피스.jpg', //미니원피스
    'assets/diagraming/[원피스]미니원피스_미디원피스_롱원피스.jpg', //미디원피스
    'assets/diagraming/[원피스]미니원피스_미디원피스_롱원피스.jpg', //롱원피스
    'assets/diagraming/[원피스]점프수트.jpg', //점프슈트
    'assets/diagraming/[바지]슬랙스_면바지_데님_조거&트레이닝.jpg', //슬랙스
    'assets/diagraming/[바지]슬랙스_면바지_데님_조거&트레이닝.jpg', //면바지
    'assets/diagraming/[바지]슬랙스_면바지_데님_조거&트레이닝.jpg', //데님
    'assets/diagraming/[바지]슬랙스_면바지_데님_조거&트레이닝.jpg', //조거트레이닝
    'assets/diagraming/[바지]반바지.jpg', //반바지
    'assets/diagraming/[스커트]미니스커트_미디스커트_롱스커트.jpg', //미니스커트
    'assets/diagraming/[스커트]미니스커트_미디스커트_롱스커트.jpg', //미디스커트
    'assets/diagraming/[스커트]미니스커트_미디스커트_롱스커트.jpg', //롱스커트
    '', //치마셑
    '', //바지셋
    'assets/diagraming/[신발]샌들_플랫_로퍼_힐_스니커즈.jpg', //샌들
    'assets/diagraming/[신발]샌들_플랫_로퍼_힐_스니커즈.jpg', //플랫
    'assets/diagraming/[신발]샌들_플랫_로퍼_힐_스니커즈.jpg', //로퍼
    'assets/diagraming/[신발]부츠.jpg', //부츠
    'assets/diagraming/[신발]샌들_플랫_로퍼_힐_스니커즈.jpg', //힐
    'assets/diagraming/[신발]샌들_플랫_로퍼_힐_스니커즈.jpg', //스니커즈
    'assets/diagraming/가방.jpg', //백팩&클러치
    'assets/diagraming/가방.jpg', //숄더백
    'assets/diagraming/가방.jpg', //크로스백
    'assets/diagraming/가방.jpg', //토트백
    'assets/diagraming/가방.jpg', //에코백
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
  ];

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ctr.clothWashToggleInitilize();
    });
    return  Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Webview
                // Obx(
                //   () => productDetailCtr.product.value.content != null
                //       ? WebviewBuilder(
                //           htmlContent: productDetailCtr.product.value.content!)
                //       : Container(),

                // ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text('PRODUCT INFO',
                          style: MyTextStyles.f18_bold
                              .copyWith(fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),

                      Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: MyColors.grey1)),
                          child: _clothPicture()),

                      SizedBox(
                        height: 20,
                      ),
                      // Size Table
                      // SizedBox(
                      //   width: GetPlatform.isMobile?Get.width:500,
                      //   child: Obx(() =>
                      //       productDetailCtr.product.value.sizes != null
                      //           ? SizeTableWidget()
                      //           : Container()),
                      // ),

                      Text(
                        '단위 : cm/단면',
                        style: TextStyle(color: MyColors.grey10, fontSize: 11),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      productDetailCtr.product.value.sizes != null
                          ? Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                      width: 3.0, color: MyColors.grey11),
                                  bottom: BorderSide(
                                      width: 3.0, color: MyColors.grey11),
                                ),
                              ),
                              child: SizeTableWidget())
                          : SizedBox.shrink(),
                      // Color
                      // SizedBox(height: 20),

                      SizedBox(height: 30),

                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(width: 3.0, color: MyColors.grey11),
                            bottom:
                                BorderSide(width: 3.0, color: MyColors.grey11),
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              // padding: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                      width: 1.0, color: MyColors.grey6),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 15),
                                      color: MyColors.grey1,
                                      width: 80,
                                      child: Center(
                                          child: Text(
                                        '두께감',
                                        style: MyTextStyles.f14
                                            .copyWith(color: MyColors.grey2),
                                      ))),
                                  Expanded(
                                    flex: 1,
                                    child: Center(
                                      child: Text(
                                        '두꺼움',
                                        style: MyTextStyles.f14.copyWith(
                                            color: productDetailCtr
                                                        .product
                                                        .value
                                                        .clothDetailSpec!
                                                        .thickness! ==
                                                    ProductThicknessType.thick
                                                ? MyColors.black2
                                                : MyColors.grey4),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Center(
                                      child: Text(
                                        '중간',
                                        style: MyTextStyles.f14.copyWith(
                                            color: productDetailCtr
                                                        .product
                                                        .value
                                                        .clothDetailSpec!
                                                        .thickness! ==
                                                    ProductThicknessType.middle
                                                ? MyColors.black2
                                                : MyColors.grey4),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Center(
                                      child: Text(
                                        '얇음',
                                        style: MyTextStyles.f14.copyWith(
                                            color: productDetailCtr
                                                        .product
                                                        .value
                                                        .clothDetailSpec!
                                                        .thickness! ==
                                                    ProductThicknessType.thin
                                                ? MyColors.black2
                                                : MyColors.grey4),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              // padding: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                      width: 1.0, color: MyColors.grey6),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 15),
                                      color: MyColors.grey1,
                                      width: 80,
                                      child: Center(
                                          child: Text(
                                        '비침',
                                        style: MyTextStyles.f14
                                            .copyWith(color: MyColors.grey2),
                                      ))),
                                  Expanded(
                                    flex: 1,
                                    child: Center(
                                      child: Text(
                                        '높음',
                                        style: MyTextStyles.f14.copyWith(
                                            color: productDetailCtr
                                                        .product
                                                        .value
                                                        .clothDetailSpec!
                                                        .seeThrough! ==
                                                    ProductSeethroughType.high
                                                ? MyColors.black2
                                                : MyColors.grey4),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Center(
                                        child: Text(
                                      '중간',
                                      style: MyTextStyles.f14.copyWith(
                                          color: productDetailCtr
                                                      .product
                                                      .value
                                                      .clothDetailSpec!
                                                      .seeThrough! ==
                                                  ProductSeethroughType.middle
                                              ? MyColors.black2
                                              : MyColors.grey4),
                                    )),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Center(
                                        child: Text(
                                      '없음',
                                      style: MyTextStyles.f14.copyWith(
                                          color: productDetailCtr
                                                      .product
                                                      .value
                                                      .clothDetailSpec!
                                                      .seeThrough! ==
                                                  ProductSeethroughType.none
                                              ? MyColors.black2
                                              : MyColors.grey4),
                                    )),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              // padding: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                      width: 1.0, color: MyColors.grey6),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 15),
                                      color: MyColors.grey1,
                                      width: 80,
                                      child: Center(
                                          child: Text(
                                        '신축성',
                                        style: MyTextStyles.f14
                                            .copyWith(color: MyColors.grey2),
                                      ))),
                                  Expanded(
                                    flex: 1,
                                    child: Center(
                                      child: Text('높음',
                                          style: MyTextStyles.f14.copyWith(
                                              color: productDetailCtr
                                                          .product
                                                          .value
                                                          .clothDetailSpec!
                                                          .flexibility! ==
                                                      ProductFlexibilityType
                                                          .high
                                                  ? MyColors.black2
                                                  : MyColors.grey4)),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Center(
                                      child: Text('중간',
                                          style: MyTextStyles.f14.copyWith(
                                              color: productDetailCtr
                                                          .product
                                                          .value
                                                          .clothDetailSpec!
                                                          .flexibility! ==
                                                      ProductFlexibilityType
                                                          .middle
                                                  ? MyColors.black2
                                                  : MyColors.grey4)),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Center(
                                      child: Text(
                                        '없음',
                                        style: MyTextStyles.f14.copyWith(
                                            color: productDetailCtr
                                                        .product
                                                        .value
                                                        .clothDetailSpec!
                                                        .flexibility! ==
                                                    ProductFlexibilityType.none
                                                ? MyColors.black2
                                                : MyColors.grey4),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Center(
                                      child: Text('벤딩',
                                          style: MyTextStyles.f14.copyWith(
                                              color: productDetailCtr
                                                          .product
                                                          .value
                                                          .clothDetailSpec!
                                                          .flexibility! ==
                                                      ProductFlexibilityType
                                                          .banding
                                                  ? MyColors.black2
                                                  : MyColors.grey4)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              // padding: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                  // border: Border(
                                  //   bottom: BorderSide(
                                  //       width: 1.0, color: MyColors.grey3),
                                  // ),
                                  ),
                              child: Row(
                                children: [
                                  Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 15),
                                      color: MyColors.grey1,
                                      width: 80,
                                      child: Center(
                                          child: Text(
                                        '안감',
                                        style: MyTextStyles.f14
                                            .copyWith(color: MyColors.grey2),
                                      ))),
                                  Expanded(
                                    flex: 1,
                                    child: Center(
                                      child: Text(
                                        '있음',
                                        style: MyTextStyles.f14.copyWith(
                                            color: productDetailCtr
                                                    .product
                                                    .value
                                                    .clothDetailSpec!
                                                    .isLining!
                                                ? MyColors.black2
                                                : MyColors.grey4),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Center(
                                      child: Text(
                                        '없음',
                                        style: MyTextStyles.f14.copyWith(
                                            color: productDetailCtr
                                                    .product
                                                    .value
                                                    .clothDetailSpec!
                                                    .isLining!
                                                ? MyColors.grey4
                                                : MyColors.black2),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // 두께감
                      // Text(
                      //   '두께감',
                      //   style:
                      //       MyTextStyles.f16.copyWith(color: MyColors.black2),
                      // ),
                      // SizedBox(height: 10),
                      // Obx(
                      //   () => productDetailCtr.product.value.clothDetailSpec !=
                      //           null
                      //       ? Row(
                      //           children: ThickThreeButtonBuilder(
                      //               selected: productDetailCtr.product.value
                      //                   .clothDetailSpec!.thickness!),
                      //         )
                      //       : SizedBox.shrink(),
                      // ),
                      // SizedBox(height: 20),
                      // // 비침
                      // Text(
                      //   '비침',
                      //   style:
                      //       MyTextStyles.f16.copyWith(color: MyColors.black2),
                      // ),
                      // SizedBox(height: 10),
                      // Obx(
                      //   () => productDetailCtr.product.value.clothDetailSpec !=
                      //           null
                      //       ? Row(
                      //           children: SeethroughThreeButtonBuilder(
                      //               selected: productDetailCtr.product.value
                      //                   .clothDetailSpec!.seeThrough!),
                      //         )
                      //       : SizedBox.shrink(),
                      // ),
                      // // 신축성
                      // SizedBox(height: 20),
                      // Text(
                      //   '신축성',
                      //   style:
                      //       MyTextStyles.f16.copyWith(color: MyColors.black2),
                      // ),
                      // SizedBox(height: 10),
                      // Obx(
                      //   () => productDetailCtr.product.value.clothDetailSpec !=
                      //           null
                      //       ? Row(
                      //           children: FlexibilityThreeButtonBuilder(
                      //               selected: productDetailCtr.product.value
                      //                   .clothDetailSpec!.flexibility!),
                      //         )
                      //       : SizedBox.shrink(),
                      // ),
                      // // 안감
                      // SizedBox(height: 20),
                      // Text(
                      //   '안감',
                      //   style:
                      //       MyTextStyles.f16.copyWith(color: MyColors.black2),
                      // ),
                      // SizedBox(height: 10),
                      // Obx(
                      //   () => productDetailCtr.product.value.clothDetailSpec !=
                      //           null
                      //       ? Row(
                      //           children: LiningTwoButtonBuilder(
                      //               isSelected: productDetailCtr.product.value
                      //                   .clothDetailSpec!.isLining!),
                      //         )
                      //       : SizedBox.shrink(),
                      // ),

                      SizedBox(
                        height: 20,
                      ),

                      Obx(() {
                        if (productDetailCtr.product.value.productModelInfo ==
                            null) {
                          return SizedBox.shrink();
                        } else if (productDetailCtr
                                .product.value.productModelInfo!.modelSize ==
                            null) {
                          return SizedBox.shrink();
                        } else {
                          if (productDetailCtr.product.value.productModelInfo!
                                  .height.isEmpty &&
                              productDetailCtr.product.value.productModelInfo!
                                  .modelWeight.isEmpty &&
                              productDetailCtr.product.value.productModelInfo!
                                  .modelSize.isEmpty) return SizedBox.shrink();

                          String content = productDetailCtr
                                  .product.value.productModelInfo!.height +
                              ' / ';

                          content += productDetailCtr
                                  .product.value.productModelInfo!.modelWeight +
                              ' / ';

                          content += productDetailCtr
                              .product.value.productModelInfo!.modelSize;

                          return FittingMaterialColorSizeWidget(
                              '모델 피팅', content);
                        }
                      }),

                      Obx(() {
                        if (productDetailCtr.product.value.materials == null) {
                          return SizedBox.shrink();
                        } else if (productDetailCtr
                            .product.value.materials!.isEmpty) {
                          return SizedBox.shrink();
                        } else {
                          String content = '';
                          for (int k = 0;
                              k <
                                  productDetailCtr
                                      .product.value.materials!.length;
                              k++) {
                            if (productDetailCtr
                                        .product.value.materials!.length -
                                    1 !=
                                k) {
                              content += productDetailCtr
                                      .product.value.materials![k].name! +
                                  ' ' +
                                  productDetailCtr
                                      .product.value.materials![k].ratio!
                                      .toString() +
                                  '% / ';
                            } else {
                              content += productDetailCtr
                                      .product.value.materials![k].name! +
                                  ' ' +
                                  productDetailCtr
                                      .product.value.materials![k].ratio!
                                      .toString()+'%';
                            }
                          }

                          return FittingMaterialColorSizeWidget('소재', content);
                        }
                      }),

                      Obx(() {
                        if (productDetailCtr.product.value.colors == null)
                          return SizedBox.shrink();
                        else {
                          String content = '';
                          for (int k = 0;
                              k < productDetailCtr.product.value.colors!.length;
                              k++) {
                            if (productDetailCtr.product.value.colors!.length -
                                    1 !=
                                k) {
                              content +=
                                  productDetailCtr.product.value.colors![k] +
                                      ' / ';
                            } else {
                              content +=
                                  productDetailCtr.product.value.colors![k];
                            }
                          }

                          return FittingMaterialColorSizeWidget('색상', content);
                        }
                      }),

                      Obx(
                        () {
                          if (productDetailCtr.product.value.sizes == null) {
                            return SizedBox.shrink();
                          } else if (productDetailCtr
                              .product.value.sizes!.isEmpty) {
                            return SizedBox.shrink();
                          } else {
                            String content = '';
                            for (int k = 0;
                                k <
                                    productDetailCtr
                                        .product.value.sizes!.length;
                                k++) {
                              if (productDetailCtr.product.value.sizes!.length -
                                      1 !=
                                  k) {
                                content += productDetailCtr
                                        .product.value.sizes![k].size! +
                                    ' / ';
                              } else {
                                content += productDetailCtr
                                    .product.value.sizes![k].size!;
                              }
                            }
                            return FittingMaterialColorSizeWidget(
                                '사이즈', content);
                          }
                        },
                      ),
                      FittingMaterialColorSizeWidget("제조국", productDetailCtr.product.value.country!),

                      Divider(),

                      SizedBox(height: 10),

                      sizeInfoText(),
                      SizedBox(height: 30),
                      // Cloth Washing tips
                      Obx(() =>
                          productDetailCtr.product.value.clothCaringGuide !=
                                  null
                              ? clothWashTipsGrid()
                              : SizedBox.shrink()),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            );
  }

  Widget _clothPicture() {
    // print(productDetailCtr.product.value.mainCategoryId);

    if (productDetailCtr.product.value.subCategoryId == -1) {
      return SizedBox.shrink();
    } else if (productDetailCtr.product.value.subCategoryId ==
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
    } else if (productDetailCtr.product.value.subCategoryId ==
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
    } else if (subCatImageList[productDetailCtr.product.value.subCategoryId! -
            ClothSubCategoryEnum.TSHIRT] ==
        '') {
      return SizedBox.shrink();
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Center(
          child: Image.asset(
            // ClothCategory.clothImages[addProductCtr.category.value.title]!,
            subCatImageList[productDetailCtr.product.value.subCategoryId! -
                ClothSubCategoryEnum.TSHIRT],
            fit: BoxFit.fill,
          ),
        ),
      );
    }
  }

  Widget FittingMaterialColorSizeWidget(String title, String content) {
    return Column(
      children: [
        Divider(),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  title,
                  style: TextStyle(
                    color: MyColors.grey10,
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Text(
                 content,
                  style: TextStyle(
                      color: MyColors.black2,
                      fontWeight: FontWeight.w400,
                      fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget EnableButton(String text, bool isSelected) {
    return Expanded(
      child: Container(
        height: 35,
        decoration: BoxDecoration(
            color: isSelected ? MyColors.primary : MyColors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
                color: isSelected ? MyColors.white : MyColors.grey1)),
        child: Center(
            child: Text(
          text,
          style: TextStyle(color: isSelected ? MyColors.black : MyColors.black),
        )),
      ),
    );
  }

  // ThickThreeButtonBuilder [두꺼움, 중간, 얇음]
  List<Widget> ThickThreeButtonBuilder({required String selected}) {
    List<Widget> buttons = [];
    // thick '두꺼움'
    if (selected == ProductThicknessType.thick) {
      buttons.add(EnableButton('두꺼움', true));
    } else {
      buttons.add(EnableButton('두꺼움', false));
    }
    buttons.add(SizedBox(width: 10));
    // middle '중간'
    if (selected == ProductThicknessType.middle) {
      buttons.add(EnableButton('중간', true));
    } else {
      buttons.add(EnableButton('중간', false));
    }
    buttons.add(SizedBox(width: 10));
    // thin '얇음'
    if (selected == ProductThicknessType.thin) {
      buttons.add(EnableButton('얇음', true));
    } else {
      buttons.add(EnableButton('얇음', false));
    }

    return buttons;
  }

  // SeethroughThreeButtonBuilder [높음, 중간,  없음]
  List<Widget> SeethroughThreeButtonBuilder({required String selected}) {
    List<Widget> buttons = [];
    // 높음
    if (selected == ProductSeethroughType.high) {
      buttons.add(EnableButton('높음', true));
    } else {
      buttons.add(EnableButton('높음', false));
    }
    buttons.add(SizedBox(width: 10));
    // middle '중간'
    if (selected == ProductSeethroughType.middle) {
      buttons.add(EnableButton('중간', true));
    } else {
      buttons.add(EnableButton('중간', false));
    }
    buttons.add(SizedBox(width: 10));
    // 없음
    if (selected == ProductSeethroughType.none) {
      buttons.add(EnableButton('없음', true));
    } else {
      buttons.add(EnableButton('없음', false));
    }
    return buttons;
  }

  // FlexibilityThreeButtonBuilder [높음, 중간, 없음, 밴딩]
  List<Widget> FlexibilityThreeButtonBuilder({required String selected}) {
    List<Widget> buttons = [];
    // 높음
    if (selected == ProductFlexibilityType.high) {
      buttons.add(EnableButton('높음', true));
    } else {
      buttons.add(EnableButton('높음', false));
    }
    buttons.add(SizedBox(width: 10));
    // middle '중간'
    if (selected == ProductFlexibilityType.middle) {
      buttons.add(EnableButton('중간', true));
    } else {
      buttons.add(EnableButton('중간', false));
    }
    buttons.add(SizedBox(width: 10));
    // 없음
    if (selected == ProductFlexibilityType.none) {
      buttons.add(EnableButton('없음', true));
    } else {
      buttons.add(EnableButton('없음', false));
    }
    buttons.add(SizedBox(width: 10));
    // 밴딩
    if (selected == ProductFlexibilityType.banding) {
      buttons.add(EnableButton('밴딩', true));
    } else {
      buttons.add(EnableButton('밴딩', false));
    }
    return buttons;
  }

  // LiningTwoButtonBuilder [있음, 없음]
  List<Widget> LiningTwoButtonBuilder({required bool isSelected}) {
    List<Widget> buttons = [];
    // 있음
    if (isSelected == true) {
      buttons.add(EnableButton('있음', true));
    } else {
      buttons.add(EnableButton('있음', false));
    }
    buttons.add(SizedBox(width: 10));
    // 없음
    if (isSelected == false) {
      buttons.add(EnableButton('없음', true));
    } else {
      buttons.add(EnableButton('없음', false));
    }
    return buttons;
  }

// clothing_care_guide
  Widget clothWashTipsGrid() {
    return Container(
      child: GridView.count(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 4,
        crossAxisSpacing: 15.0,
        mainAxisSpacing: 15.0,
        children: List.generate(8, (index) {
          // return ClothWashToggle(
          //   clothWash: addProduct3Ctr.clothWashToggles[index],
          //   onPressed: () => null,
          // );
          return ClothWashToggleUser(addProduct3Ctr.clothWashToggles[index]);
        }),
      ),
    );
  }

  Widget sizeInfoText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '· 상세 사이즈는 측정 밥법과 위치, 소재에 따라 1~3cm 오차가 발생될 수 있습니다.',
          style: MyTextStyles.f12.copyWith(color: MyColors.grey4),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          '· 제품 컬러는 모니터 해상도와 각도에 따라 다르게 보일 수 있습니다.',
          style: MyTextStyles.f12.copyWith(color: MyColors.grey4),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          '· 아리보리, 화이트 계열의 색상의 경우 비침이 있을 수도 있습니다.',
          style: MyTextStyles.f12.copyWith(color: MyColors.grey4),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          '· 모델컷보다 디테일컷이 실제 상품 색상에 가깝습니다.',
          style: MyTextStyles.f12.copyWith(color: MyColors.grey4),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          '· 사이즈는 단면(cm) 측정입니다.',
          style: MyTextStyles.f12.copyWith(color: MyColors.grey4),
        ),
      ],
    );
  }

  Widget ClothWashToggleUser(ClothWash clothWash) {
    return Container(
      decoration: BoxDecoration(
        color: clothWash.isActive.value ? MyColors.grey6 : MyColors.white,
        borderRadius: BorderRadius.all(Radius.circular(MyDimensions.radius)),
        border: Border.all(
          color: MyColors.grey1,
        ),
      ),
      height: 10,
      width: 20,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: Image.asset(
                clothWash.iconPath,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(height: 5),
            Center(
              child: Text(
                clothWash.title,
                style: TextStyle(
                    color: clothWash.isActive.value
                        ? MyColors.black2
                        : MyColors.grey10,
                    fontSize: 12),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }

  // Widget modelInfo() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Row(
  //         children: [
  //           Text('키'),
  //           SizedBox(width: 5),
  //           Text(productDetailCtr.product.value.productModelInfo!.height
  //               .toString()),
  //           SizedBox(width: 15),
  //           Text('몸무게'),
  //           SizedBox(width: 5),
  //           Text(productDetailCtr.product.value.productModelInfo!.modelWeight
  //               .toString()),
  //           SizedBox(width: 15),
  //         ],
  //       ),
  //       SizedBox(
  //         height: 10,
  //       ),
  //       Text('FITTING'),
  //       Text(productDetailCtr.product.value.productModelInfo!.modelSize
  //           .toString()),
  //     ],
  //   );
  // }

  colorsBuilder() {
    return Row(
      children: [
        ...productDetailCtr.product.value.colors!.map(
          (color) => Row(
            children: [
              Text(color),
              SizedBox(width: 10),
            ],
          ),
        )
      ],
    );
  }

  materialsBuilder() {
    return Row(
      children: [
        ...productDetailCtr.product.value.materials!.map(
          (material) => Row(
            children: [
              Text(material.name!),
              SizedBox(width: 5),
              Text(material.ratio!.toString() + '%'),
              SizedBox(width: 15),
            ],
          ),
        )
      ],
    );
  }
}
