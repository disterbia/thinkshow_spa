// ignore_for_file: must_be_immutable

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wholesaler_partner/app/widgets/loading_widget.dart';
import 'package:wholesaler_user/app/Constants/variables.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/data/cache_provider.dart';
import 'package:wholesaler_user/app/data/dynamic_link.dart';
import 'package:wholesaler_user/app/modules/cart/controllers/cart1_shopping_basket_controller.dart';
import 'package:wholesaler_user/app/modules/cart/views/cart1_shopping_basket_view.dart';
import 'package:wholesaler_user/app/modules/page2_store_detail/view/store_detail_view.dart';
import 'package:wholesaler_user/app/modules/product_detail/controller/product_detail_controller.dart';
import 'package:wholesaler_user/app/modules/product_detail/controller/tab_2_review_controller.dart';
import 'package:wholesaler_user/app/modules/product_detail/views/carousel_slider_widget.dart';
import 'package:wholesaler_user/app/modules/product_detail/views/select_option_bottom_sheet_view.dart';
import 'package:wholesaler_user/app/modules/product_detail/views/tab1_detail_info_view.dart';
import 'package:wholesaler_user/app/modules/product_detail/views/tab1_size_info_view.dart';
import 'package:wholesaler_user/app/modules/product_detail/views/tab2_review_view.dart';
import 'package:wholesaler_user/app/modules/product_detail/views/tab3_inquiry_view.dart';
import 'package:wholesaler_user/app/modules/search/views/search_page_view.dart';
import 'package:wholesaler_user/app/utils/utils.dart';
import 'package:wholesaler_user/app/widgets/custom_appbar.dart';
import 'package:wholesaler_user/app/widgets/custom_button.dart';

class ProductDetailView extends GetView {
  ProductDetailController ctr = Get.put(ProductDetailController());
  Cart1ShoppingBasketController ctr2 = Get.put(Cart1ShoppingBasketController());
  Tab2ReviewProductDetailController ctr3 =
      Get.put(Tab2ReviewProductDetailController());

  RxInt tabIndex = 0.obs;

  ProductDetailView();

  List<String> tabTitles = ['상세정보', '리뷰', "사이즈", '문의'];

  init() {
    //print("ddddddqqqqqq");
    ctr2.init();
    if (Get.arguments != null) {
      CacheProvider().addRecentlyViewedProduct(Get.arguments);
      // print('ProductDetailView > addRecentlyViewedProduct: Get.arguments ${Get.arguments}');
    }
  }
  @override
  Widget build(BuildContext context) {
    init();

    return Obx(
      () => Scaffold(
        bottomNavigationBar: User_BottomNavbar(),
        backgroundColor: MyColors.white,
        appBar: _appbar(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: 45,
              height: 45,
              child: FloatingActionButton(
                  heroTag: null,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.arrow_upward_rounded,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    ctr.arrowsController
                        .jumpTo(ctr.arrowsController.position.minScrollExtent);
                  }),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 45,
              height: 45,
              child: FloatingActionButton(
                  heroTag: null,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.arrow_downward_rounded, color: Colors.grey),
                  onPressed: () {
                    ctr.arrowsController
                        .jumpTo(ctr.arrowsController.position.maxScrollExtent);
                  }),
            ),
          ],
        ),
        body: ctr.isLoading.value
            ? LoadingWidget()
            : Obx(
                () {
                  print(tabIndex);
                  return SingleChildScrollView(
                    controller: ctr.arrowsController,
                    child: ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        //MyVars.isUserProject() ? storeInfo() : Container(),
                        _productImages(),
                        storeInfo(),
                        Divider(),
                        _titleRatingPrice(context),
                        SizedBox(height: 10),
                        Divider(thickness: 3,color: MyColors.grey3,),
                        TabBar(
                          controller: ctr.tabController,
                          onTap: (index) {
                            print(tabIndex);
                            tabIndex.value = index;
                          },
                          indicatorColor: Colors.black,
                          labelColor: Colors.black,unselectedLabelColor: Colors.grey,
                          isScrollable: false,
                          tabs: [
                            ...tabTitles.map((title) => Tab(text: title)),
                          ],
                        ),
                        Builder(builder: (_) {
                          if (tabIndex.value == 0) {
                            return Tab1DetailInfo(); //1st custom tabBarView
                          } else if (tabIndex.value == 1) {
                            return Tab2ReviewView(); //2nd tabView
                          } else if (tabIndex.value == 2) {
                            return Tab4SizeInfo(); //3rd tabView
                          } else {
                            return Tab3InquiryView();
                          }
                        }),
                      ],
                    ),

                    // SliverAppBar(
                    //   automaticallyImplyLeading: false,
                    //    pinned: true,
                    //   elevation: 0,
                    //   backgroundColor: Colors.white,
                    //   title: _tabs(),
                    // ),
                  );
                },
              ),
      ),
    );
  }

  Widget tabViewBody() {
    return TabBarView(
      physics: NeverScrollableScrollPhysics(),
      children: [
        Tab1DetailInfo(),
        Tab2ReviewView(),
        Tab4SizeInfo(),
        Tab3InquiryView(),
      ],
    );
  }

  Widget storeInfo() {
    List<String> categoris = (ctr.product.value.store.categories!)
        .map((item) => item as String)
        .toList();
    String category = "";
    for (var i = 0; i < categoris.length; i++) {
      if (i == categoris.length - 1)
        category = category + categoris[i];
      else
        category = category + categoris[i] + "·";
    }
    int favoriteCount = ctr.product.value.store.favoriteCount!.value;
    double temp = double.parse(favoriteCount.toString());
    String result = favoriteCount.toString();
    if (temp > 999) {
      result = (temp / 1000).toStringAsFixed(1) + "k";
    }
    return GestureDetector(
      onTap: MyVars.isUserProject()
          ? () {
              Get.to(
                () => StoreDetailView(storeId: ctr.product.value.store.id),
                preventDuplicates: true,
              );
            }
          : null,
      child: Padding(
        padding: const EdgeInsets.only(top: 10,bottom: 3,left: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(
              () => ctr.product.value.store.imgUrl != null
                  ? Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              ctr.product.value.store.imgUrl!.value),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              ctr.product.value.store.name!,
                              style: MyTextStyles.f14_bold,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                                categoris.isNotEmpty ? category : "스토어 정보 없음",
                                style: MyTextStyles.f12
                                    .copyWith(color: Colors.grey))
                          ],
                        )
                      ],
                    )
                  : Row(
                      children: [
                        Image.asset(
                          'assets/icons/ic_store.png',
                          width: 40,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Obx(() => ctr.product.value.store.name != null
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    ctr.product.value.store.name!,
                                    style: MyTextStyles.f14_bold,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                      categoris.isNotEmpty
                                          ? category
                                          : "스토어 정보 없음",
                                      style: MyTextStyles.f12
                                          .copyWith(color: Colors.grey))
                                ],
                              )
                            : SizedBox.shrink()),
                      ],
                    ),
            ),
            Obx(
              () => ctr.product.value.store.isBookmarked != null &&
                      MyVars.isUserProject()
                  ? Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Column(
                        children: [
                          ctr.product.value.store.isBookmarked!.isTrue
                              ? InkWell(
                                  onTap: () => ctr.storeBookmarkPressed(),
                                  child: Image.asset("assets/icons/ico_star_on.png",height: 25,),
                                )
                              : InkWell(
                                  onTap: () => ctr.storeBookmarkPressed(),
                                  child: Image.asset("assets/icons/ico_star_off.png",height: 25,)),
                          Text(
                            result,
                            style: TextStyle(
                              color: MyColors.grey4,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        ],
                      ),
                    )
                  : SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _productImages() {
    // double height = 500 * 4 / 3;
    return Container(
      child: Obx(
        () => ctr.product.value.images!.isNotEmpty
            ? ImagesCarouselSlider()
            : SizedBox.shrink(),
      ),
    );
  }

  Widget _titleRatingPrice(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  ctr.product.value.title,
                  style: MyTextStyles.f16_bold.copyWith(color: Colors.black),
                ),
              ),
            ),
            MyVars.isUserProject()
                ? InkWell(
                    onTap: () async {
                      Share.share(
                        await DynamicLink().getShortLink(
                          ctr.productId.toString(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(
                        "assets/icons/ic_share.png",height: 25,
                      ),
                    ))
                : SizedBox.shrink()
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Row(
            children: [
              Container(
                child: ctr.product.value.totalRating == null
                    ? Container()
                    : RatingBar.builder(
                        itemSize: 17,
                        ignoreGestures: true,
                        initialRating: ctr.product.value.totalRating!.value,
                        minRating: 1,
                        direction: Axis.horizontal,
                        itemCount: 5,
                        // itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
              ),
              SizedBox(
                width: 5,
              ),
              ctr.product.value.totalRating == null
                  ? Container()
                  : InkWell(
                      onTap: () {
                        ctr.tabController.animateTo(1);
                        tabIndex.value = 1;
                        ctr.arrowsController.animateTo(
                          450.0,
                          curve: Curves.easeOut,
                          duration: const Duration(milliseconds: 300),
                        );
                      },
                      child: Text("리뷰 ${ctr3.reviews.length}개 보기",style: TextStyle(color: Colors.grey),)),
            ],
          ),
          // Row(
          //   children: [
          //     Icon(Icons.star, color: MyColors.primary),
          //     Text(
          //       ctr.product.value.totalRating!.value.toString(),
          //       textAlign: TextAlign.start,
          //     )
          //   ],
          // ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 10),
          child: Row(
            children: [
              Text(
                "띵 할인가 ",
                style: TextStyle(fontSize: 15, color: Colors.redAccent),
              ),
              Text(
                Utils.numberFormat(
                    number: ctr.product.value.normalPrice ?? 0, suffix: '원'),
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontFamily: 'SpoqaHanSansNeo-Medium',
                    fontSize: 15.0,
                    decoration: TextDecoration.lineThrough),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 5, bottom: 10),
          child: Row(
            children: [
              Text(
                (ctr.product.value.priceDiscountPercent ?? 0).toString()+"% ",
                style: MyTextStyles.f18_bold.copyWith(
                    color: MyColors.primary2,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                Utils.numberFormat(
                    number: ctr.product.value.price ?? 0, suffix: '원'),
                style: MyTextStyles.f18_bold
                    .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Divider(),
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 5),
          child: Row(
            children: [
              Text(
                "배송정보   ",
                style: MyTextStyles.f16.copyWith(color: Colors.grey),
              ),
              ctr.product.value.hasBellIconAndBorder!.value
                  ? Row(
                      children: [
                        Icon(Icons.notifications, color: MyColors.primary),
                        Text("띵동배송",
                            style: MyTextStyles.f16
                                .copyWith(color: MyColors.primary)),
                      ],
                    )
                  : Container(),
              ctr.product.value.hasBellIconAndBorder!.value
                  ? SizedBox(
                      width: 10,
                    )
                  : Container(),
              Text("무료배송",
                  style:
                      MyTextStyles.f16.copyWith(fontWeight: FontWeight.w500)),
            ],
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.only(left: 10, top: 5),
        //   child: Row(
        //     children: [
        //       Text("혜택정보   ",
        //           style: MyTextStyles.f16.copyWith(color: MyColors.grey4)),
        //       Text("최대 300p 적립",
        //           style: MyTextStyles.f16.copyWith(fontWeight: FontWeight.w500))
        //     ],
        //   ),
        // )
      ],
    );
  }

  Widget User_BottomNavbar() {
    return Obx(
      ()=>ctr.isLoading.value?LoadingWidget(): SafeArea(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              children: [
                MyVars.isUserProject()
                    ? Obx(
                        () => ctr.product.value.isLiked != null
                            ? IconButton(
                                onPressed: () => ctr.likeBtnPressed(
                                    newValue: !ctr.product.value.isLiked!.value),
                                icon: ctr.product.value.isLiked!.isTrue
                                    ? Icon(
                                        Icons.favorite,
                                        color: MyColors.primary,
                                      )
                                    : Icon(
                                        Icons.favorite_border,
                                        color: MyColors.primary,
                                      ),
                              )
                            : IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.favorite_border,
                                  color: MyColors.primary,
                                )),
                      )
                    : SizedBox.shrink(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      height: 50,
                      child: CustomButton(
                        textColor: MyColors.black,
                        text: MyVars.isUserProject() ? '구매하기' : '수정하기',
                        onPressed: () {
                          MyVars.isUserProject()
                              ? SelectOptionBottomSheet()
                              : ctr.editProductBtnPressed();
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar _appbar() {
    return CustomAppbar(
        isBackEnable: true,
        hasHomeButton: true,
        title: '',
        actions: [
          MyVars.isUserProject()
              ? Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.search,
                        color: MyColors.black,
                      ),
                      onPressed: () {
                        Get.to(SearchPageView());
                      },
                    ),
                    Obx(
                      () => ctr2.getNumberProducts() != 0
                          ? Badge(
                              badgeColor: MyColors.primary,
                              badgeContent: Text(
                                ctr2.getNumberProducts().toString(),
                                style: TextStyle(
                                    color: MyColors.black,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold),
                              ),
                              toAnimate: false,
                              position: BadgePosition.topEnd(top: 5, end: 5),
                              child: IconButton(
                                  onPressed: () {
                                    Get.to(() => Cart1ShoppingBasketView());
                                  },
                                  icon: ImageIcon(
                                    AssetImage('assets/icons/top_cart.png'),
                                    size: 21,
                                    // Icons.shopping_cart_outlined,
                                    color: MyColors.black,
                                  )),
                            )
                          : IconButton(
                              onPressed: () {
                                Get.to(() => Cart1ShoppingBasketView());
                              },
                              icon: ImageIcon(
                                AssetImage('assets/icons/top_cart.png'),
                                size: 21,
                                // Icons.shopping_cart_outlined,
                                color: MyColors.black,
                              ),
                            ),
                    ),
                  ],
                )
              : SizedBox.shrink(),
        ]);
  }

  Widget _tabs() {
    return TabBar(
      onTap: (index) => tabIndex.value = index,
      indicatorColor: MyColors.primary,
      labelColor: Colors.black,
      isScrollable: false,
      tabs: [
        ...tabTitles.map((title) => Tab(text: title)),
      ],
    );
  }
}
