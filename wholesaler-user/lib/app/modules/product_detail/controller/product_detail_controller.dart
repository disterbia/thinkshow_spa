import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/modules/add_product/add_product_view.dart';
import 'package:wholesaler_user/app/data/api_provider.dart';
import 'package:wholesaler_user/app/data/cache_provider.dart';
import 'package:wholesaler_user/app/models/product_model.dart';
import 'package:wholesaler_user/app/models/store_model.dart';
import 'package:wholesaler_user/app/modules/auth/user_login_page/views/user_login_view.dart';
import 'package:wholesaler_user/app/modules/cart/controllers/cart1_shopping_basket_controller.dart';
import 'package:wholesaler_user/app/modules/cart/views/cart1_shopping_basket_view.dart';
import 'package:wholesaler_user/app/widgets/snackbar.dart';
import 'package:wholesaler_user/app/constants/functions.dart';

class ProductDetailController extends GetxController {
  uApiProvider _apiProvider = uApiProvider();
  int productId = -1;

  // carousel
  RxInt sliderIndex = 0.obs;
  CarouselController indicatorSliderController = CarouselController();

  RxInt selectedOptionIndex = (-1).obs; // Wraning: don't change -1
  RxInt totalPrice = 0.obs;
  Rx<Product> product = Product(
          id: -1,
          title: '',
          imgUrl: '',
          store: Store(id: -1),
          images: [],
          quantity: 1.obs,
          price: 0,
          selectedOptionAddPrice: 0)
      .obs;

  // size table widget
  ScrollController arrowsController = ScrollController();
  ScrollController arrowsController2 = ScrollController();
  RxBool isLoading = false.obs;

  late QuillController quillController;

  @override
  Future<void> onInit() async {
    super.onInit();
    isLoading.value = true;
    productId = Get.arguments;
    print('productId $productId');

    if (productId == -1) {
      print('ERROR: ProductDetailController > productID is -1');
      return;
    }
    product.value = await _apiProvider.getProductDetail(productId: productId);
    // print(product.value.content);
    if(product.value.content != null){
      quillController = QuillController(
        document: Document.fromJson(jsonDecode(product.value.content!.value)),
        selection: TextSelection.collapsed(offset: 0));
    }
    else{
      quillController = QuillController.basic();
    }

    if (product.value.quantity == null) {
      product.value.quantity = 1.obs;
    }
    totalPrice.value = product.value.price!;
    isLoading.value = false;
  }

  void UpdateTotalPrice() {
    print('UpdateTotalPrice');
    int addPrice = selectedOptionIndex.value != -1
        ? product.value.options![selectedOptionIndex.value].add_price!
        : 0;
    totalPrice.value =
        (product.value.price! + addPrice) * product.value.quantity!.value;
  }

  Future<void> purchaseBtnPressed({required bool isDirectBuy}) async {
    if (!isOptionSelected()) {
      return;
    }
    if (CacheProvider().getToken().isEmpty) {
      Get.to(() => User_LoginPageView());
      return;
    }
    int product_option_id =
        product.value.options![selectedOptionIndex.value].id!;
    bool isSuccess = await _apiProvider.postAddToShoppingBasket(
        product_option_id, product.value.quantity!.value);

    if (isDirectBuy) {
      Get.to(() => Cart1ShoppingBasketView());
    } else {
      if (isSuccess) {
        mSnackbar(
          message: '상품을 장바구니에 담았습니다.',
          actionText: 'go'.tr,
          onPressed: () {
            Get.to(() => Cart1ShoppingBasketView());
          },
        );
      }
      Get.back();
    }
  }

  bool isOptionSelected() {
    if (selectedOptionIndex.value == -1) {
      Get.back();
      mSnackbar(message: '옵션을 선택하세요.');
      return false;
    } else {
      return true;
    }
  }

  storeBookmarkPressed() async {
    if (CacheProvider().getToken().isEmpty) {
      mFuctions.userLogout();
      return;
    }
    bool result = await uApiProvider().chekToken();
    if (!result) {
      print('logout');
      mSnackbar(message: '로그인 세션이 만료되었습니다.');
      mFuctions.userLogout();
      return;
    }

    product.value.store.isBookmarked!.toggle();
    bool isSuccess =
        await _apiProvider.putAddStoreFavorite(storeId: product.value.store.id);
    if (isSuccess) {
      if (product.value.store.isBookmarked!.value) {
        mSnackbar(message: '스토어 찜 설정이 완료되었습니다.');
      } else {
        mSnackbar(message: '스토어 찜 설정이 취소되었습니다.');
      }
    }
  }

  likeBtnPressed({required bool newValue}) async {
    if (CacheProvider().getToken().isEmpty) {
      Get.to(() => User_LoginPageView());
      return;
    }

    bool result = await uApiProvider().chekToken();

    if (!result) {
      print('logout');
      mSnackbar(message: '로그인 세션이 만료되었습니다.');
      mFuctions.userLogout();
      return;
    }

    bool isSuccess =
        await _apiProvider.putProductLikeToggle(productId: product.value.id);

    if (isSuccess) {
      product.value.isLiked!.value = newValue;

      if (newValue)
        mSnackbar(message: '찜 완료', duration: 1);
      else
        mSnackbar(message: '찜 취소 완료', duration: 1);
    }
  }

  editProductBtnPressed() {
    Get.to(() => AddProductView(), arguments: productId);
  }
}
