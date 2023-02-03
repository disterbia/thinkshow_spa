import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:wholesaler_partner/app/modules/add_product/part3_material_clothwash/controller/part3_material_clothwash_controller.dart';
import 'package:wholesaler_partner/app/modules/add_product/view/widget/cloth_wash_toggle/cloth_wash_model.dart';
import 'package:wholesaler_partner/app/modules/add_product/view/widget/cloth_wash_toggle/cloth_wash_toggle.dart';
import 'package:wholesaler_user/app/Constants/colors.dart';
import 'package:wholesaler_user/app/Constants/enum.dart';
import 'package:wholesaler_user/app/Constants/styles.dart';
import 'package:wholesaler_user/app/Constants/variables.dart';
import 'package:wholesaler_user/app/constants/dimens.dart';
import 'package:wholesaler_user/app/modules/product_detail/controller/product_detail_controller.dart';
import 'package:wholesaler_user/app/modules/product_detail/controller/tab_1_detail_info_controller.dart';
import 'package:wholesaler_user/app/modules/product_detail/views/size_table_widget.dart';
import 'package:wholesaler_user/app/widgets/custom_button.dart';
import 'package:wholesaler_user/app/widgets/product/product_item_vertical_widget.dart';
import 'package:wholesaler_user/app/widgets/webview_builder_flex_height.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;

class Tab1DetailInfo extends GetView {
  Tab1DetailInfoController ctr = Tab1DetailInfoController();
  ProductDetailController productDetailCtr = Get.put(ProductDetailController());
  AP_Part3Controller addProduct3Ctr = Get.put(AP_Part3Controller());
  RxBool isMore = false.obs;

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
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Stack(
                    children: [
                      Obx(
                        () => Container(
                          height: productDetailCtr
                                      .product.value.imagesColor!.length >= 2 ? isMore.value
                                  ? null
                                  : Get.height * 1.2
                              : null,
                          child: ListView.builder(itemCount:productDetailCtr
                              .product.value.imagesColor!.length ,
                            itemBuilder: (context, index) {
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
                              );
                              return Container(
                                height: Get.height * 0.6,
                                child: ClipRRect(borderRadius: !isMore.value && index==1 ?
                                BorderRadius.only(bottomRight: Radius.circular(8),bottomLeft:Radius.circular(8) ):
                                BorderRadius.all( Radius.zero),
                                  child: CachedNetworkImage(
                                    imageUrl: productDetailCtr
                                        .product.value.imagesColor![index],
                                    fit: BoxFit.fill,
                                    placeholder: (context, url) {
                                      return Container(
                                        height: 300,
                                        child: Center(
                                            child: CircularProgressIndicator()),
                                      );
                                    },
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                ),
                              );

                            },
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,


                          ),
                          // ListView(
                          //   physics: NeverScrollableScrollPhysics(),
                          //   shrinkWrap: true,
                          //   children: [
                          //     for (String imagesColor in productDetailCtr
                          //         .product.value.imagesColor!) ...[
                          //       Container(
                          //         height: Get.height * 0.6,
                          //         child: CachedNetworkImage(
                          //           imageUrl: imagesColor,
                          //           fit: BoxFit.fill,
                          //           placeholder: (context, url) {
                          //             return Container(
                          //               height: 300,
                          //               child: Center(
                          //                   child: CircularProgressIndicator()),
                          //             );
                          //           },
                          //           errorWidget: (context, url, error) =>
                          //               Icon(Icons.error),
                          //         ),
                          //       )
                          //     ],
                          //     QuillEditor(
                          //       controller: productDetailCtr.quillController,
                          //       scrollController: ScrollController(),
                          //       scrollable: true,
                          //       focusNode: FocusNode(),
                          //       autoFocus: true,
                          //       readOnly: true,
                          //       expands: false,
                          //       padding: EdgeInsets.all(15),
                          //       showCursor: false,
                          //       enableSelectionToolbar: false,
                          //       enableInteractiveSelection: false,
                          //     ),
                          //   ],
                          // ),
                        ),
                      ),
                      Obx(
                        () =>  productDetailCtr
                            .product.value.imagesColor!.length >= 2 ? isMore.value
                            ? Container()
                            : Positioned(
                            bottom: 0,right: 0,left: 0,
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          colors: [
                                        Colors.white.withOpacity(1),
                                        Colors.white.withOpacity(0)
                                      ],
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter)),
                                  height: 80,
                                  width: Get.width,
                                ),
                               Container(
                                            height: 60,
                                            child: CustomButton(
                                                width: Get.width,
                                                onPressed: () {
                                                  isMore.value = true;
                                                },
                                                backgroundColor: Colors.black,
                                                borderColor: Colors.black,
                                                child:Row(mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "상품정보 더보기",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    Icon(Icons.keyboard_arrow_down_outlined,color: Colors.white,)
                                                  ],
                                                )),
                                          )
                                    ,
                              ]
                            )): Container(),
                      )
                    ],
                  ),
                ),
                Obx(
                ()=>SizedBox(height: isMore.value?0:30,)),
                Divider(
                  thickness: 10,
                  color: MyColors.grey3,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "이 상품과 비슷한 상품",
                    style: MyTextStyles.f18_bold,
                  ),
                ),
                GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  primary: false,
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) {
                    return ProductItemVertical(
                      product: productDetailCtr.product.value,
                    );
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing:10,
                    crossAxisCount: 3,
                    childAspectRatio:  context.width / 3 /
                        (MyVars.isSmallPhone()
                            ? 300
                            : 290),
                    // explanation: add productheight +10 for small screen sizes, if we don't, on small screen the product height is too short
                  ),
                ),
                Divider(
                  thickness: 10,
                  color: MyColors.grey3,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "스토어에서 인기 있는 상품",
                    style: MyTextStyles.f18_bold,
                  ),

                ),SizedBox(height: 10),
                GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  primary: false,
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) {
                    return ProductItemVertical(
                      product: productDetailCtr.product.value,
                    );
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 10,
                    crossAxisCount: 3,
                    childAspectRatio:  context.width / 3 /
                        (MyVars.isSmallPhone()
                            ? 300
                            : 290),
                  // explanation: add productheight +10 for small screen sizes, if we don't, on small screen the product height is too short
                  ),
                ),

                // 반품교환정보
                SizedBox(height: 50),
                Text(
                  '띵쇼 교환 및 반품 안내',
                  style: MyTextStyles.f16.copyWith(color: MyColors.black2),
                ),
                SizedBox(height: 10),
                Obx(
                  () => productDetailCtr.product.value.return_exchange_info !=
                          null
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            productDetailCtr
                                .product.value.return_exchange_info!,
                            style: TextStyle(color: MyColors.grey4),
                          ),
                        )
                      : SizedBox.shrink(),
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
