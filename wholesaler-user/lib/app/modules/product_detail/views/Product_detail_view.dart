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

  ProductDetailView();

  List<String> tabTitles = ['상세정보', '리뷰', '문의'];

  init() {
    //print("ddddddqqqqqq");
    //ctr2.init();
    if (Get.arguments != null) {
      CacheProvider().addRecentlyViewedProduct(Get.arguments);
      // print('ProductDetailView > addRecentlyViewedProduct: Get.arguments ${Get.arguments}');
    }
  }

  @override
  Widget build(BuildContext context) {
    init();
    return Obx(
      () => DefaultTabController(
        // animationDuration: Duration.zero,
        length: tabTitles.length,
        child: Scaffold(
          bottomNavigationBar: User_BottomNavbar(),
          backgroundColor: MyColors.white,
          appBar: _appbar(),
          body: ctr.isLoading.value
              ? LoadingWidget()
              : NestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return [
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            //MyVars.isUserProject() ? storeInfo() : Container(),
                            _productImages(),
                            storeInfo(),
                            Divider(),
                            _titleRatingPrice(context),
                            SizedBox(height: 15),
                          ],
                        ),
                      ),
                      SliverAppBar(
                        automaticallyImplyLeading: false,
                        pinned: true,
                        elevation: 0,
                        backgroundColor: Colors.white,
                        title: _tabs(),
                      ),
                    ];
                  },
                  body: tabViewBody(),
                ),
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
        Tab3InquiryView(),
      ],
    );
  }

  Widget storeInfo() {
    int favoriteCount = ctr.product.value.store.favoriteCount!.value;
    double temp = double.parse(favoriteCount.toString());
    String result = favoriteCount.toString();
    if (temp > 999) {
      result = (temp / 1000).toStringAsFixed(1) + "k";
    }
    return GestureDetector(
      onTap: () {
        Get.to(() => StoreDetailView(storeId: ctr.product.value.store.id));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(
            () => Padding(
                padding: const EdgeInsets.all(15),
                child: ctr.product.value.store.imgUrl != null
                    ? Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                                ctr.product.value.store.imgUrl!.value),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(ctr.product.value.store.name!)
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
                              ? Text(ctr.product.value.store.name!)
                              : SizedBox.shrink()),
                        ],
                      )),
          ),
          Obx(
            () => ctr.product.value.store.isBookmarked != null
                ? Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Column(
                      children: [
                        ctr.product.value.store.isBookmarked!.isTrue
                            ? InkWell(
                                onTap: () => ctr.storeBookmarkPressed(),
                                child: Icon(
                                  Icons.star,
                                  color: MyColors.primary,
                                ),
                              )
                            : InkWell(
                                onTap: () => ctr.storeBookmarkPressed(),
                                child: Icon(Icons.star_border,
                                    color: MyColors.primary)),
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
    );
  }

  Widget _productImages() {
    // double height = Get.width * 4 / 3;
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  ctr.product.value.title,
                  style: MyTextStyles.f16,
                ),
            ),
            Spacer(),
            InkWell(onTap: () async{
              print("-=-=-=/product_detail_view?id=${ctr.productId.toString()}");
              Share.share(
                await DynamicLink().getShortLink(
                 ctr.productId.toString(),
                ),
              );
            },child: Icon(Icons.share_outlined))
          ],
        ),
         Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Row(
                    children: [
                      Container(
                        child: ctr.product.value.totalRating==null?Text("리뷰없음"):RatingBar.builder(
                          glow: false,
                          itemSize: 10,
                          ignoreGestures: true,
                          initialRating:
                              ctr.product.value.totalRating!.value,
                          minRating: 1,
                          direction: Axis.horizontal,
                          itemCount: 5,
                          itemPadding:
                              EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                      ),
                      ctr.product.value.totalRating==null?Container():InkWell(
                            onTap: () =>
                                DefaultTabController.of(context)!.index = 1,
                            child: Text("리뷰 ${ctr3.reviews.length}개 보기")),
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
       Row(
         children: [
           Text("띵 할인가"),
           Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  Utils.numberFormat(
                      number: ctr.product.value.normalPrice ?? 0, suffix: '원'),
                  style: MyTextStyles.f18_bold,
                ),
              ),
         ],
       ),
        Row(
          children: [
            Text(Utils.numberFormat(
                number: ctr.product.value.priceDiscountPercent ?? 0, suffix: '%')),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                Utils.numberFormat(
                    number: ctr.product.value.price ?? 0, suffix: '원'),
                style: MyTextStyles.f18_bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget User_BottomNavbar() {
    return SafeArea(
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
                  padding: const EdgeInsets.only(right: 10),
                  child: CustomButton(
                    textColor: MyColors.white,
                    text: MyVars.isUserProject() ? '구매하기' : '수정하기',
                    onPressed: () {
                      MyVars.isUserProject()
                          ? SelectOptionBottomSheet()
                          : ctr.editProductBtnPressed();
                    },
                  ),
                ),
              ),
            ],
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
                                  icon: Icon(
                                    Icons.shopping_cart_outlined,
                                    color: MyColors.black,
                                  )),
                            )
                          : IconButton(
                              onPressed: () {
                                Get.to(() => Cart1ShoppingBasketView());
                              },
                              icon: Icon(
                                Icons.shopping_cart_outlined,
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
      indicatorColor: MyColors.primary,
      labelColor: Colors.black,
      isScrollable: false,
      tabs: [
        ...tabTitles.map((title) => Tab(text: title)),
      ],
    );
  }
}
