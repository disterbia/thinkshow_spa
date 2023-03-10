import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/widgets/loading_widget.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/modules/cart/controllers/cart1_shopping_basket_controller.dart';
import 'package:wholesaler_user/app/modules/cart/views/cart1_shopping_basket_view.dart';
import 'package:wholesaler_user/app/modules/page3_exhibition_products/controller/exhibit_product_controller.dart';
import 'package:wholesaler_user/app/modules/search/views/search_page_view.dart';
import 'package:wholesaler_user/app/widgets/custom_appbar.dart';
import 'package:wholesaler_user/app/widgets/product_gridview_builder/product_gridview_builder.dart';

class ExhibitionProductsView extends GetView {
  ExhibitionProductsController ctr = Get.put(ExhibitionProductsController());
  Cart1ShoppingBasketController ctr2 = Get.put(Cart1ShoppingBasketController());

  ExhibitionProductsView();

  @override
  Widget build(BuildContext context) {
    ctr2.init();
    return Scaffold(
      appBar: _appbar(),
      body: _body(),
    );
  }

  Widget _body() => Obx(
      ()=>ctr.isLoading.value?LoadingWidget(): SingleChildScrollView(
          child: Column(
            children: [
               ListView.separated(padding: EdgeInsets.zero,
                  separatorBuilder: (context, index) => SizedBox(height: 5,),
                    itemCount:ctr.bannerPicture.length ,physics: NeverScrollableScrollPhysics(),shrinkWrap: true,
                    itemBuilder: (context,index) {
                        return ExtendedImage.network(clearMemoryCacheWhenDispose:true,enableMemoryCache:false,enableLoadState: false,cacheWidth: 1000,cacheHeight: 1000,
                           ctr.bannerPicture[index],
                            width: GetPlatform.isMobile?Get.width:500,
                            fit: BoxFit.fitWidth,

                          );
                      }
                    )
                    ,
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(height: 50,decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: MyColors.black,),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                          ctr.title.value,
                          style: MyTextStyles.f16_bold.copyWith(color: Colors.white)
                      ),
                    ),
                  ),
                ),
              ),

              ctr.products.isEmpty?Text(
                  "상품 없음",
                  style: MyTextStyles.f16_bold,
              ):Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ProductGridViewBuilder(
                  crossAxisCount: 3,
                  productHeight: (500*0.7).floor(),
                  products: ctr.products,
                  isShowLoadingCircle: false.obs,
                ),
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
  );

  AppBar _appbar() {
    return CustomAppbar(
        isBackEnable: true,
        title: 'Exhibition_product'.tr,
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: MyColors.black,
            ),
            onPressed: () {
              Get.to(() => SearchPageView());
            },
          ),
          Obx(
            () => ctr2.getNumberProducts() != 0
                ? Badge(
                    badgeColor: MyColors.primary,
                    badgeContent: Text(
                      ctr2.getNumberProducts().toString(),
                      style: TextStyle(
                          color: MyColors.white,
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
                      ),
                    ),
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
          )
        ]);
  }

  loadWithDelay() {}
}
