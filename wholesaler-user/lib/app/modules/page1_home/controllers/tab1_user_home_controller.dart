import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/Constants/constants.dart';
import 'package:wholesaler_user/app/data/api_provider.dart';
import 'package:wholesaler_user/app/models/product_model.dart';
import 'package:wholesaler_user/app/widgets/category_tags/category_tag_controller.dart';

/// Warning Don't confuse [Tab1Home] with [Page1Home]. Inside Page1 we have tab1 with the name Home
class Tab1UserHomeController extends GetxController {
  CategoryTagController categoryTagCtr = Get.put(CategoryTagController());

  uApiProvider _apiProvider = uApiProvider();
  RxList<Product> products1 = <Product>[].obs;
  RxList<Product> products2 = <Product>[].obs;
  RxList<Product> products3 = <Product>[].obs;
  RxList<Product> products4 = <Product>[].obs;
  RxList<Product> products5 = <Product>[].obs;
  

  Rx<ScrollController> scrollController = ScrollController().obs;
  int offset = 30;
  RxBool allowCallAPI = true.obs;
  RxBool isLoading = false.obs;

  @override
  Future<void> onInit() async {
    scrollController.value.addListener(() {
      // print(scrollController.value.position.pixels);
      if (scrollController.value.position.pixels ==
              scrollController.value.position.maxScrollExtent ) {
        offset += mConst.limit;
        addDataToList();
      }
    });
    super.onInit();
  }

  Future<void> init() async {
    isLoading.value = true;
    offset = 30;
    products1.value =
        await _apiProvider.getAllProducts(offset: 0, limit: 6);
    products2.value =
    await _apiProvider.getAllProducts(offset: 6, limit: 8);
    products3.value =
    await _apiProvider.getAllProducts(offset: 14, limit: 4);
    products4.value =
    await _apiProvider.getAllProducts(offset: 18, limit: 12);
    products5.value =
    await _apiProvider.getAllProducts(offset: 30, limit: mConst.limit);




    isLoading.value = false;
    super.onInit();
  }

  // getAllProducts() async {
  //   isLoading.value = true;

  //   offset = 0;
  //   products.value =
  //       await _apiProvider.getAllProducts(offset: offset, limit: mConst.limit);

  //   isLoading.value = false;
  // }

  Future<void> updateProducts() async {
    // reset variables
    products1.clear();
    products2.clear();
    products3.clear();
    products4.clear();
    products5.clear();

    offset = 30;
    allowCallAPI.value = true;
    isLoading.value=true;
    // Note: we have two APIs. API 1: When "ALL" chip is called (index == 0), API 2: when categories are called.
    if (categoryTagCtr.selectedMainCatIndex.value == 0) {
      print('products1, show ALL');
      products1.value = await _apiProvider.getAllProducts(
          offset: 0, limit: 6);
    } else {
      print('products1 , show categories');
      products1.value = await _apiProvider.getProductsWithCat(
          categoryId: categoryTagCtr.selectedMainCatIndex.value,
          offset: 0,
          limit: 6);
    }
    if (categoryTagCtr.selectedMainCatIndex.value == 0) {
      print('products2 show ALL');
      products2.value = await _apiProvider.getAllProducts(
          offset: 6, limit: 8);
    } else {
      print('products2 , show categories');
      products2.value = await _apiProvider.getProductsWithCat(
          categoryId: categoryTagCtr.selectedMainCatIndex.value,
          offset: 6,
          limit: 8);
    }
    if (categoryTagCtr.selectedMainCatIndex.value == 0) {
      print('products3, show ALL');
      products3.value = await _apiProvider.getAllProducts(
          offset: 14, limit: 4);
    } else {
      print('products3 , show categories');
      products3.value = await _apiProvider.getProductsWithCat(
          categoryId: categoryTagCtr.selectedMainCatIndex.value,
          offset: 14,
          limit: 4);
    }
    if (categoryTagCtr.selectedMainCatIndex.value == 0) {
      print('products4, show ALL');
      products4.value = await _apiProvider.getAllProducts(
          offset: 18, limit: 12);
    } else {
      print('products4 , show categories');
      products4.value = await _apiProvider.getProductsWithCat(
          categoryId: categoryTagCtr.selectedMainCatIndex.value,
          offset: 18,
          limit: 12);
    }
    if (categoryTagCtr.selectedMainCatIndex.value == 0) {
      print('products5, show ALL');
      products5.value = await _apiProvider.getAllProducts(
          offset: 18, limit: 12);
    } else {
      print('products5 , show categories');
      products5.value = await _apiProvider.getProductsWithCat(
          categoryId: categoryTagCtr.selectedMainCatIndex.value,
          offset: offset,
          limit: mConst.limit);
    }
    isLoading.value=false;
    if (products5.length < mConst.limit) {
      allowCallAPI.value = false;
    }

  }

  addDataToList() async {
    List<Product> tempProducts = [];
    if (categoryTagCtr.selectedMainCatIndex.value == 0) {
      print('index 0, show ALL');
      tempProducts = await _apiProvider.getAllProducts(
          offset: offset, limit: mConst.limit);
    } else {
      print('index > 0 , show categories');
      tempProducts = await _apiProvider.getProductsWithCat(
          categoryId: categoryTagCtr.selectedMainCatIndex.value,
          offset: offset,
          limit: mConst.limit);
    }
    products5.addAll(tempProducts);
    // check if last product from server.
    if (tempProducts.length == 0) {
      allowCallAPI.value = false;
    }
  }
}
