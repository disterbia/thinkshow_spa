import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/models/cart_model.dart';
import 'package:wholesaler_user/app/models/product_model.dart';
import 'package:wholesaler_user/app/models/store_model.dart';
import 'package:wholesaler_user/app/modules/cart/controllers/cart1_shopping_basket_controller.dart';
import 'package:wholesaler_user/app/modules/cart/widgets/circular_checkbox.dart';
import 'package:wholesaler_user/app/modules/page2_store_detail/view/store_detail_view.dart';
import 'package:wholesaler_user/app/utils/utils.dart';
import 'package:wholesaler_user/app/widgets/product/product_item_horiz_widget.dart';
import 'package:wholesaler_user/app/widgets/snackbar.dart';

class CartItemsList extends StatelessWidget {
  Cart1ShoppingBasketController ctr = Get.put(Cart1ShoppingBasketController());
  bool isCart1Page;
  List<Cart> cartItems;
  bool showClose = true;
  CartItemsList(
      {required this.isCart1Page,
      required this.cartItems,
      required this.showClose});
  @override
  Widget build(BuildContext context) {
    List<Product> products = [];
    return Obx(
      () => ListView.builder(
        //padding: EdgeInsets.all(15),
        physics: NeverScrollableScrollPhysics(),
        itemCount: cartItems.length,
        shrinkWrap: true,
        itemBuilder: (context, cartIndex) {
          // Cart 1: show all products
          if (isCart1Page) {
            products = cartItems[cartIndex].products;
          } else {
            // Cart 2: show selected products only
            products = cartItems[cartIndex]
                .products
                .where((tempProduct) => tempProduct.isCheckboxSelected == true)
                .toList();
          }
          
          return Padding(
            padding: const EdgeInsets.only(bottom: 10, left: 15, right: 15),
            child: Container(
              decoration: new BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.5),
                    blurRadius: 10, // soften the shadow
                    spreadRadius: 0.0, //extend the shadow
                    // offset: Offset(
                    //   5.0, // Move to right 10  horizontally
                    //   0.0, // Move to bottom 10 Vertically
                    // ),
                  )
                ],
              ),
              child: Card(
                color: Colors.white,
                //margin: EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                ),
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // show store only if it contains products
                    products.length > 0
                        ? Padding(
                            padding: const EdgeInsets.only(
                                top: 10.0, bottom: 0, left: 10),
                            child: _store(cartItems[cartIndex].store),
                          )
                        : SizedBox.shrink(),
                    Divider(),
                    // if cart 2 page, only show selected products
                    ...products.map(
                      (product) => _orderedProductBuilder(cartIndex,
                          products.indexOf(product), product, products.length),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        // separatorBuilder: (BuildContext context, int index) {
        //   if (products.length > 0) {
        //     return SizedBox(height: 0);
        //   } else {
        //     return SizedBox.shrink();
        //   }
        // },
      ),
    );
  }

  Widget _store(Store store) {
    return GestureDetector(
        onTap: () {
          Get.to(() => StoreDetailView(storeId: store.id),preventDuplicates: true);
        },
        child: Row(
          children: [
            Text(
              store.name ?? '',
              style: MyTextStyles.f18_bold.copyWith(color: MyColors.black3,fontWeight: FontWeight.bold),
            ),
          ],
        )
        // Row(
        //   children: [
        //     ClipRRect(
        //       borderRadius: BorderRadius.circular(50),
        //       child: store.imgUrl != null
        //           ? ExtendedImage.network(clearMemoryCacheWhenDispose:true,enableMemoryCache:false,enableLoadState: false,cacheWidth: 1024,cacheHeight: 1365,
        //               imageUrl: store.imgUrl!.value,
        //               width: 35,
        //               height: 35,
        //               fit: BoxFit.fill,
        //               // placeholder: (context, url) => CircularProgressIndicator(),
        //               errorWidget: (context, url, error) => Icon(Icons.error),
        //             )
        //           : Image.asset(
        //               store.imgAssetUrl,
        //               width: 35,
        //             ),
        //     ),
        //     SizedBox(
        //       width: 10,
        //     ),
        //     Text(
        //       store.name ?? '',
        //       style: MyTextStyles.f18_bold.copyWith(color: MyColors.black3),
        //     )
        //   ],
        // ),
        );
  }

  Widget _orderedProductBuilder(
      int cartIndex, int productIndex, Product product, int length) {
    int productPrice = product.price!;
    // Customize our ProductItemHorizontal view to match the design.
    Product tempProduct = Product(
      id: product.id,
      title: product.title,
      normalPrice: product.normalPrice,
      priceDiscountPercent: product.priceDiscountPercent,
      imgUrl: product.imgUrl,
      store: Store(id: product.store.id),
      selectedOptionAddPrice: product.selectedOptionAddPrice,
      OLD_option: product.OLD_option,
      quantity: product.quantity,
      imgHeight: product.imgHeight,
      imgWidth: product.imgWidth,
      showQuantityPlusMinus: product.showQuantityPlusMinus,
      cartId: product.cartId,
      isDeal: product.isDeal,
      isCheckboxSelected: true.obs
    );
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 10,
            ),
            isCart1Page
                // Checkbox left of Product
                ? Obx(
                    () => CustomCheckbox(
                      isChecked: product.isCheckboxSelected!.value,
                      cartIndex: cartIndex,
                      productIndex: productIndex,
                      onChanged: (bool value) {
                        product.isCheckboxSelected!.toggle();
                        ctr.updateTotalPaymentPrice();
                        value? ctr.checkCount++ :ctr.checkCount--;
                        ctr.checkCount==0 ?ctr.isSelectAllChecked.value=true:ctr.isSelectAllChecked.value=false;

                      },
                    ),
                  )
                : SizedBox.shrink(),
            isCart1Page ? SizedBox(width: 10) : SizedBox.shrink(),
            Flexible(
              child: ProductItemHorizontal(
                showClose: showClose,
                showPrice: true,
                product: tempProduct,
                // normalPrice: normalPrice,
                // discountPercent: discountPercent,
                price: productPrice,
                // totalPrice: productTotalPrice,
                // normalTotalPrice:normalTotalPrice,
                quantityPlusMinusOnPressed: (value) =>tempProduct.isDeal!?value?mSnackbar(message: "해당 상품은 1개만 구매 가능합니다."):null:
                    ctr.quantityPlusMinusOnPressed(
                  value: value,
                  cartId: tempProduct.cartId!,
                  qty: tempProduct.quantity!.value,
                ),
              ),
            ),
          ],
        ),
        length - 1 != productIndex
            ? Divider(
                thickness: 1,
                color: MyColors.grey3,
              )
            : Container(),
        SizedBox(
          height: 5,
        )
      ],
    );
  }
}
