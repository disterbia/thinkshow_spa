import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/Constants/constants.dart';
import 'package:wholesaler_user/app/data/api_provider.dart';
import 'package:wholesaler_user/app/models/product_model.dart';
import 'package:wholesaler_user/app/widgets/category_tags/category_tag_controller.dart';
import 'package:wholesaler_user/app/widgets/category_tags/category_tag_controller3.dart';

class Tab4DingDongController extends GetxController {
  CategoryTagController3 categoryTagCtr = Get.put(CategoryTagController3());
  RxList<Product> products = <Product>[].obs;
  uApiProvider _apiProvider = uApiProvider();

  Rx<ScrollController> scrollController = ScrollController().obs;
  int offset = 0;
  RxBool allowCallAPI = true.obs;
  RxBool isLoading = false.obs;

  @override
  Future<void> onInit() async {
    isLoading.value = true;
    products.value = await _apiProvider.getDingdongProductPopular(
        offset: offset, limit: mConst.limit);
    scrollController.value.addListener(() {
      print(
          "${scrollController.value.position.pixels}===== ${scrollController.value.position.maxScrollExtent}");
      if (scrollController.value.position.pixels ==
          scrollController.value.position.maxScrollExtent) {
        print("bbbbb");
        offset += mConst.limit;
        addDataToList();
      }
    });
    isLoading.value = false;
    super.onInit();
  }

  Future<void> init() async {
    offset = 0;
    isLoading.value = true;
    products.value = await _apiProvider.getDingdongProductPopular(
        offset: 0, limit: mConst.limit);
    // scrollController.value.addListener(() {
    //   if (scrollController.value.position.pixels == scrollController.value.position.maxScrollExtent && allowCallAPI.isTrue) {
    //     offset += mConst.limit;
    //     addDataToList();
    //   }
    // });
    isLoading.value = false;
    if (products.length < mConst.limit) allowCallAPI.value = false;
    super.onInit();
  }

  Future<void> updateProducts() async {
    // reset variables
    products.clear();
    offset = 0;
    allowCallAPI.value = true;

    if (categoryTagCtr.selectedMainCatIndex.value == 0) {
      //print('index 0, show 인기');
      products.value = await _apiProvider.getDingdongProductPopular(
          offset: offset, limit: mConst.limit);
    } else {
      //print('index > 0 , show categories');
      products.value = await _apiProvider.getDingdongProductsWithCat(
          categoryId: categoryTagCtr.selectedMainCatIndex.value,
          offset: offset,
          limit: mConst.limit);
    }
    allowCallAPI.value = false;
  }

  addDataToList() async {
    List<Product> tempProducts = [];
    if (categoryTagCtr.selectedMainCatIndex.value == 0) {
      print("offset");
      tempProducts = await _apiProvider.getDingdongProductPopular(
          offset: offset, limit: mConst.limit);
    } else {
      print('index > 0 , show categories');
      tempProducts = await _apiProvider.getDingdongProductsWithCat(
          categoryId: categoryTagCtr.selectedMainCatIndex.value,
          offset: offset,
          limit: mConst.limit);
    }
    products.addAll(tempProducts);
    // check if last product from server.
    if (tempProducts.length == 0) {
      allowCallAPI.value = false;
    }
  }
}
