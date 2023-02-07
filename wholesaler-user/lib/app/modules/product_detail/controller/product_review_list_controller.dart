import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/modules/add_product/add_product_view.dart';
import 'package:wholesaler_user/app/data/api_provider.dart';
import 'package:wholesaler_user/app/data/cache_provider.dart';
import 'package:wholesaler_user/app/models/product_model.dart';
import 'package:wholesaler_user/app/models/review.dart';
import 'package:wholesaler_user/app/models/store_model.dart';
import 'package:wholesaler_user/app/modules/auth/user_login_page/views/user_login_view.dart';
import 'package:wholesaler_user/app/modules/cart/controllers/cart1_shopping_basket_controller.dart';
import 'package:wholesaler_user/app/modules/cart/views/cart1_shopping_basket_view.dart';
import 'package:wholesaler_user/app/widgets/snackbar.dart';
import 'package:wholesaler_user/app/constants/functions.dart';

class ProductReviewListController extends GetxController {
  uApiProvider _apiProvider = uApiProvider();

  RxList<Review> reviews = <Review>[].obs;

  late RxList<int> sliderIndex;
  late RxList<CarouselController> indicatorSliderController;

  Rx<ScrollController> scrollController = ScrollController().obs;
  int offset = 0;
  RxBool allowCallAPI = true.obs;

  @override
  Future<void> onInit() async {
    Get.arguments['isPhoto']
        ? await getProductReviewOnlyPhoto(productId: Get.arguments['productId'])
        : await getProductReviews(productId: Get.arguments['productId']);

    if (reviews.length < 20) allowCallAPI.value = false;

    sliderIndex = List.filled(reviews.length, 0).obs;
    indicatorSliderController =
        List.filled(reviews.length, CarouselController()).obs;

    scrollController.value.addListener(() {
      //  print('scrollController.value.addListener');
      if (scrollController.value.position.pixels ==
              scrollController.value.position.maxScrollExtent &&
          allowCallAPI.isTrue) {
        //  print('scrollController end detected. isLoading.value = ${allowCallAPI.value} offset = $offset');
        offset += 20;
        //  print('scrollController end detected. isLoading.value = ${allowCallAPI.value} offset = $offset');
        addDataToList();
      }
    });

    super.onInit();
  }

  getProductReviews({required int productId}) async {
    // print(productId);
    reviews.value = await _apiProvider.getProductReviews(
        productId: productId, offset: 0, limit: 20);
  }

  getProductReviewOnlyPhoto({required int productId}) async {
    reviews.value = await _apiProvider.getProductReviewOnlyPhoto(
        productId: productId, offset: 0, limit: 20);
  }

  addDataToList() async {
    // print('inside addDataToList: offset $offset');
    List<Review> tempReviews = Get.arguments['isPhoto']
        ? await getProductReviewOnlyPhoto(productId: Get.arguments['productId'])
        : await getProductReviews(productId: Get.arguments['productId']);

    // check if last product from server.
    if (tempReviews.length == 0) {
      allowCallAPI.value = false;
    }
  }
}
