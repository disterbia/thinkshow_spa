import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
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

class Tab1DetailInfo extends GetView {
  Tab1DetailInfoController ctr = Tab1DetailInfoController();
  ProductDetailController productDetailCtr = Get.put(ProductDetailController());
  AP_Part3Controller addProduct3Ctr = Get.put(AP_Part3Controller());

  // Tab1DetailInfo();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ctr.clothWashToggleInitilize();
    });
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: 1,
            (context, index) => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Webview
                // Obx(
                //   () => productDetailCtr.product.value.content != null
                //       ? WebviewBuilder(
                //           htmlContent: productDetailCtr.product.value.content!)
                //       : Container(),

                // ),

                QuillEditor(
                  controller: productDetailCtr.quillController,
                  scrollController: ScrollController(),
                  scrollable: true,
                  focusNode: FocusNode(),
                  autoFocus: true,
                  readOnly: true,
                  expands: false,
                  padding: EdgeInsets.all(15),
                  showCursor: false,
                  enableSelectionToolbar: false,
                  enableInteractiveSelection: false,
                ),

                for (String imagesColor
                    in productDetailCtr.product.value.imagesColor!) ...[
                  CachedNetworkImage(
                    imageUrl: imagesColor,
                    fit: BoxFit.fill,
                    placeholder: (context, url) {
                      return Container(
                        height: 300,
                        child: Center(child: CircularProgressIndicator()),
                      );
                    },
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  )
                ],

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      // Size Table
                      SizedBox(
                        width: double.infinity,
                        child: Obx(() =>
                            productDetailCtr.product.value.sizes != null
                                ? SizeTableWidget()
                                : Container()),
                      ),
                      // Color
                      // SizedBox(height: 20),
                      Text(
                        '색상',
                        style:
                            MyTextStyles.f16.copyWith(color: MyColors.black2),
                      ),
                      SizedBox(height: 10),
                      Obx(
                        () => productDetailCtr.product.value.colors != null
                            ? colorsBuilder()
                            : Container(),
                      ),
                      SizedBox(height: 20),
                      Text(
                        '소재',
                        style:
                            MyTextStyles.f16.copyWith(color: MyColors.black2),
                      ),
                      SizedBox(height: 10),
                      Obx(
                        () => productDetailCtr.product.value.materials != null
                            ? materialsBuilder()
                            : Container(),
                      ),
                      SizedBox(height: 20),
                      // 두께감
                      Text(
                        '두께감',
                        style:
                            MyTextStyles.f16.copyWith(color: MyColors.black2),
                      ),
                      SizedBox(height: 10),
                      Obx(
                        () => productDetailCtr.product.value.clothDetailSpec !=
                                null
                            ? Row(
                                children: ThickThreeButtonBuilder(
                                    selected: productDetailCtr.product.value
                                        .clothDetailSpec!.thickness!),
                              )
                            : SizedBox.shrink(),
                      ),
                      SizedBox(height: 20),
                      // 비침
                      Text(
                        '비침',
                        style:
                            MyTextStyles.f16.copyWith(color: MyColors.black2),
                      ),
                      SizedBox(height: 10),
                      Obx(
                        () => productDetailCtr.product.value.clothDetailSpec !=
                                null
                            ? Row(
                                children: SeethroughThreeButtonBuilder(
                                    selected: productDetailCtr.product.value
                                        .clothDetailSpec!.seeThrough!),
                              )
                            : SizedBox.shrink(),
                      ),
                      // 신축성
                      SizedBox(height: 20),
                      Text(
                        '신축성',
                        style:
                            MyTextStyles.f16.copyWith(color: MyColors.black2),
                      ),
                      SizedBox(height: 10),
                      Obx(
                        () => productDetailCtr.product.value.clothDetailSpec !=
                                null
                            ? Row(
                                children: FlexibilityThreeButtonBuilder(
                                    selected: productDetailCtr.product.value
                                        .clothDetailSpec!.flexibility!),
                              )
                            : SizedBox.shrink(),
                      ),
                      // 안감
                      SizedBox(height: 20),
                      Text(
                        '안감',
                        style:
                            MyTextStyles.f16.copyWith(color: MyColors.black2),
                      ),
                      SizedBox(height: 10),
                      Obx(
                        () => productDetailCtr.product.value.clothDetailSpec !=
                                null
                            ? Row(
                                children: LiningTwoButtonBuilder(
                                    isSelected: productDetailCtr.product.value
                                        .clothDetailSpec!.isLining!),
                              )
                            : SizedBox.shrink(),
                      ),
                      // 의류 관리 안내
                      SizedBox(height: 20),
                      Text(
                        '의류 관리 안내',
                        style:
                            MyTextStyles.f16.copyWith(color: MyColors.black2),
                      ),
                      SizedBox(height: 10),
                      // Cloth Washing tips
                      Obx(() =>
                          productDetailCtr.product.value.clothCaringGuide !=
                                  null
                              ? clothWashTipsGrid()
                              : SizedBox.shrink()),
                      // 모델정보
                      Obx(
                        () => productDetailCtr.product.value.productModelInfo !=
                                    null &&
                                productDetailCtr.product.value.productModelInfo!
                                        .modelSize !=
                                    null
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 20),
                                  Text(
                                    '모델정보',
                                    style: MyTextStyles.f16
                                        .copyWith(color: MyColors.black2),
                                  ),
                                  SizedBox(height: 10),
                                  modelInfo(),
                                ],
                              )
                            : SizedBox.shrink(),
                      ),
                      // 반품교환정보
                      SizedBox(height: 50),
                      Text(
                        '반품 및 교환',
                        style:
                            MyTextStyles.f16.copyWith(color: MyColors.black2),
                      ),
                      SizedBox(height: 10),
                      Obx(
                        () => productDetailCtr
                                    .product.value.return_exchange_info !=
                                null
                            ? Text(productDetailCtr
                                .product.value.return_exchange_info!)
                            : SizedBox.shrink(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
          style:
              TextStyle(color: isSelected ? MyColors.white : MyColors.primary),
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
      buttons.add(EnableButton('없음', false));
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

  Widget ClothWashToggleUser(ClothWash clothWash) {
    return Container(
      decoration: BoxDecoration(
        color: clothWash.isActive.value ? MyColors.primary : MyColors.white,
        borderRadius: BorderRadius.all(Radius.circular(MyDimensions.radius)),
        border: Border.all(
          color: clothWash.isActive.value ? MyColors.primary : MyColors.grey1,
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
                        : MyColors.black2,
                    fontSize: 12),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget modelInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('키'),
            SizedBox(width: 5),
            Text(productDetailCtr.product.value.productModelInfo!.height
                .toString()),
            SizedBox(width: 15),
            Text('몸무게'),
            SizedBox(width: 5),
            Text(productDetailCtr.product.value.productModelInfo!.modelWeight
                .toString()),
            SizedBox(width: 15),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Text('FITTING'),
        Text(productDetailCtr.product.value.productModelInfo!.modelSize
            .toString()),
      ],
    );
  }

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
