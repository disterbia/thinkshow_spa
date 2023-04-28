import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/widgets/loading_widget.dart';
import 'package:wholesaler_user/app/Constants/functions.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/constants.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/constants/variables.dart';
import 'package:wholesaler_user/app/data/api_provider.dart';
import 'package:wholesaler_user/app/data/cache_provider.dart';
import 'package:wholesaler_user/app/models/product_model.dart';
import 'package:wholesaler_user/app/models/product_number_model.dart';
import 'package:wholesaler_user/app/modules/auth/user_login_page/views/user_login_view.dart';
import 'package:wholesaler_user/app/modules/page1_home/views/tabs/tab4_ding_dong.dart';
import 'package:wholesaler_user/app/modules/page2_store_detail/controller/store_detail_controller.dart';
import 'package:wholesaler_user/app/modules/page2_store_list/controllers/shopping_controller.dart';
import 'package:wholesaler_user/app/modules/page2_store_list/controllers/shopping_controller2.dart';
import 'package:wholesaler_user/app/widgets/category_tags/category_tags.dart';
import 'package:wholesaler_user/app/widgets/category_tags/category_tags4.dart';
import 'package:wholesaler_user/app/widgets/category_tags/cloth_category.dart';
import 'package:wholesaler_user/app/widgets/dingdong_3products_horiz/dingdong_3products_horiz_view.dart';
import 'package:wholesaler_user/app/widgets/product/product_item_vertical_widget.dart';
import 'package:wholesaler_user/app/widgets/product_gridview_builder/product_gridview_builder.dart';
import 'package:wholesaler_user/app/widgets/snackbar.dart';

class StoreDetailView extends GetView {
  StoreDetailController ctr = Get.put(StoreDetailController());
  Page2StoreListController ctr2 = Get.put(Page2StoreListController());
  String? prevPage;
  int? storeId;

  StoreDetailView({required this.storeId, String? prevPage}) {
    print('storeId $storeId');

    if (prevPage != null) {
      this.prevPage = prevPage;
      print(prevPage);
    } else {
      //ctr2.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    ctr.storeId.value = storeId!;
    ctr.init();
    return Scaffold(
      appBar: _appbar(),
      body: _body(),
    );
  }

  Widget _body() {
    HorizontalChipList4().ctr.selectedMainCatIndex.value = 0;
    return Obx(
      () => ctr.isLoading.value
          ? LoadingWidget()
          : SingleChildScrollView(
              controller: ctr.scrollController.value,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      _image(),
                      _starStore(),
                    ],
                  ),
                  SizedBox(height: 10),
                  // 띵동배송
                  Obx(() => ctr.privilateProductsNotEmpty()
                      ? Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            titleBuilder('띵동 배송', 'view_more'.tr, () {
                              Get.to(() => Tab4DingDongView());
                            }),
                            Dingdong3ProductsHorizView(),
                            SizedBox(height: 10),
                          ],
                        )
                      : SizedBox()),

                  // 우리매장 베스트
                  titleBuilder('Best_in_store'.tr, 'manage'.tr, () {}),
                  _top10Products(),
                  SizedBox(height: 20),
                  Divider(thickness: 10, color: MyColors.grey3),
                  SizedBox(height: 20),
                  // Product Category Chips
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Obx(
                      () => HorizontalChipList4().getAllMainCat(
                          categoryList: ClothCategory.getAllMainCat()
                              .map((e) => e.name)
                              .toList(),
                          onTapped: () =>
                              ctr.updateProducts(isScrolling: false)),
                    ),
                  ),
                  SizedBox(height: 5),
                  dropdownBuilder(),
                  SizedBox(height: 5),
                  // Products list
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: ProductGridViewBuilder(
                      crossAxisCount: 2,
                      productHeight: (500*0.8).floor(),
                      products: ctr.products,
                      isShowLoadingCircle: ctr.allowCallAPI,
                    ),
                  ),

                  SizedBox(height: 80),
                ],
              ),
            ),
    );
  }

  Widget _image() {
    return Obx(
      () => ctr.mainStoreModel.value.mainTopImageUrl != null
          ? ExtendedImage.network(clearMemoryCacheWhenDispose:true,enableMemoryCache:false,enableLoadState: false,cacheWidth: 1024,cacheHeight: 1365,
             ctr.mainStoreModel.value.mainTopImageUrl!.value,
              width: GetPlatform.isMobile?Get.width:500,
              height: GetPlatform.isMobile?Get.width:500,
              fit: BoxFit.fitWidth,
            )
          : Container(
              height: GetPlatform.isMobile?Get.width:500,
              child: Center(child: Text('등록된 사진이 없습니다.')),
            ),
    );
  }

  Widget _starStore() {
    return Positioned(
      right: 5,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Obx(
          () => ctr.mainStoreModel.value.isFavorite != null
              ? IconButton(
                  onPressed: () async{
                    bool result = await uApiProvider().chekToken();
                    if(!result) {
                       mFuctions.userLogout();
                      return mSnackbar(message: "로그인 후 이용 가능합니다.");
                    }
                    bool value = ctr.mainStoreModel.value.isFavorite!.value;
                    ctr.mainStoreModel.value.isFavorite!.value = !value;
                    print('new value ${!value}');
                    ctr.starIconPressed().then((_) {
                      if (prevPage != null) {
                        print('-=-=${prevPage}');
                        if (prevPage == '최신순') {
                          ctr2.getNewestStoreData();
                        }else if (prevPage == '인기순') {
                          ctr2.getMostStoreData();
                        }else if (prevPage == '리뷰순') {
                          ctr2.getReviewStoreData();
                        }
                        else if (prevPage == 'bookmark')
                          Get.find<Page2StoreListController2>().getBookmarkedStoreData();
                      }
                    });
                  },
                  icon: ctr.mainStoreModel.value.isFavorite!.value
                      ? Icon(
                          Icons.star,
                          size: 30,
                        )
                      : Icon(
                          Icons.star_border,
                          size: 30,
                        ),
                  color: MyColors.accentColor,
                )
              : SizedBox.shrink(),
        ),
      ),
    );
  }

  Widget titleBuilder(
      String title, String buttonText, VoidCallback buttonOnPressed) {
    return Obx(
      () => ctr.top10Products.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.only(left: 20, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: MyTextStyles.f16,
                  ),
                  // 관리하기 button
                  MyVars.isUserProject() == false
                      ? TextButton(
                          onPressed: buttonOnPressed,
                          child: Row(
                            children: [
                              Text(
                                buttonText,
                                style: MyTextStyles.f16,
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: MyColors.black2,
                                size: 15,
                              )
                            ],
                          ),
                        )
                      : SizedBox.shrink(),
                ],
              ),
            )
          : SizedBox(),
    );
  }

  _top10Products() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 우리매장 베스트
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Obx(
            () => ctr.top10Products.isNotEmpty
                ? SizedBox(
                    height: GetPlatform.isMobile?240:300,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: ctr.top10Products.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          SizedBox(width: 14),
                      itemBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          width: GetPlatform.isMobile?Get.width-30:500/3-30,
                          child: ProductItemVertical(
                            product: ctr.top10Products.elementAt(index),
                            productNumber: ProductNumber(
                              number: index + 1,
                              backgroundColor:
                                  MyColors.numberColors.length > index
                                      ? MyColors.numberColors[index]
                                      : MyColors.numberColors[0],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : MyVars.isUserProject()
                    ? SizedBox.shrink()
                    : Center(child: Text('제품을 등록해 주세요.')),
          ),
        ),
      ],
    );
  }

  Widget dropdownBuilder() {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Obx(
            () => DropdownButton(
              hint: Text(ctr.dropdownItems[ctr.selectedDropdownIndex.value]),
              items: itemsBuilder(ctr.dropdownItems),
              onChanged: (String? newValue) {
                print('DropdownButton newValue $newValue');
                ctr.selectedDropdownIndex.value =
                    ctr.dropdownItems.indexOf(newValue!);
                ctr.updateProducts(isScrolling: false);
              },
            ),
          ),
        ],
      ),
    );
  }

  List<DropdownMenuItem<String>> itemsBuilder(List<String> itemStrings) {
    return itemStrings.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();
  }

  AppBar _appbar() {
    return AppBar(
      centerTitle: true,
      leadingWidth: 100,
      backgroundColor: MyColors.white,
      title: Obx(
        () => Text(
          ctr.mainStoreModel.value.storeName ?? '',
          textAlign: TextAlign.start,
          style: const TextStyle(color: MyColors.black),
        ),
      ),
      leading: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Back icon
          IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: MyColors.black,
              size: 20,
            ),
            onPressed: () => Get.back(),
          ),
        ],
      ),
      elevation: 0.9,
      titleSpacing: 0.0,
      automaticallyImplyLeading: false,
    );
  }

  Widget _indicator(List<Product> products) {
    print('inisde _indicator imgList $products');
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: products.asMap().entries.map((entry) {
          return GestureDetector(
              // onTap: () => ctr.indicatorSliderController.animateToPage(entry.key),
              child: Container(
            width: 10.0,
            height: 10.0,
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: MyColors.primary.withOpacity(
                    ctr.sliderIndex.value == entry.key ? 0.9 : 0.4)),
          ));
        }).toList(),
      ),
    );
  }

  List<Widget> top10ProductItemsBuilder({required double height}) {
    List<Widget> items = [];
    for (Product product in ctr.top10Products) {
      int index = ctr.top10Products.indexOf(product);
      items.add(
        Container(
          width: 130,
          height: height,
          padding: const EdgeInsets.only(right: 10),
          child: ProductItemVertical(
            product: product,
            productNumber: ProductNumber(
                number: index + 1,
                backgroundColor:
                    MyColors.numberColors[index > 10 ? 10 : index]),
          ),
        ),
      );
    }

    return items;
  }
}
