import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/data/api_provider.dart';
import 'package:wholesaler_partner/app/modules/ad/tab1_ad_status/controller/tab1_ad_status_controller.dart';
import 'package:wholesaler_user/app/Constants/constants.dart';
import 'package:wholesaler_user/app/models/product_model.dart';
import 'package:wholesaler_user/app/models/status_model.dart';
import 'package:wholesaler_user/app/models/store_model.dart';
import 'package:wholesaler_user/app/widgets/snackbar.dart';

class ProductMgmtController extends GetxController {
  RxBool isSelectAll = false.obs;
  RxBool isBottomNavbar = false.obs;
  RxBool isAdding = false.obs;
  final pApiProvider _apiProvider = pApiProvider();
  List<int> productsId = [];
  int applicationId = -1;
  // String? searchContent;
  TextEditingController searchController = TextEditingController();

  Rx<ScrollController> scrollController = ScrollController().obs;
  int offset = 0;
  RxBool allowCallAPI = true.obs;

  @override
  void onClose() {
    // TODO: implement onClose
    print('ㅁㅁㅁㅁ');
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      applicationId = Get.arguments;
    }
    getProducts(isScrolling: false);

    scrollController.value.addListener(() {
      if (scrollController.value.position.pixels ==
          scrollController.value.position.maxScrollExtent) {
        offset += mConst.limit;
        getProducts(isScrolling: true);
        print("작동ㄴㄴ");
      }
    });
  }

  RxList<Product> products = <Product>[].obs;

  void selectAllCheckbox() {
    isSelectAll.toggle();
    isBottomNavbar.value = isSelectAll.value;

    // print products length
    print('products.length ${products.length}');

    productsId.clear();
    for (Product product in products) {
      product.isChecked!.value = isSelectAll.value;
      if (isSelectAll.isTrue) {
        productsId.add(product.id);
      }
    }
    print(
        'selectAllCheckbox ${productsId.length} productsId ${productsId}');
  }

  Future<void> getProducts(
      {String? startDate,
      String? endDate,
      List<int>? clothCatIds,
      required bool isScrolling}) async {
    if (!isScrolling) {
      offset = 0;
      products.clear();
    }
    print(startDate);
    dynamic raw = await _apiProvider.getProducts(
        searchContent: searchController.text,
        startDate: startDate,
        endDate: endDate,
        clothCatIds: clothCatIds,
        offset: offset,
        limit: mConst.limit);

    for (int i = 0; i < raw.length; i++) {
      Product tempProduct = Product(
        id: raw[i]['id'],
        title: raw[i]['product_name'],
        price: raw[i]['price'],
        imgUrl: raw[i]['thumbnail_image_url'],
        isTop10: (raw[i]['is_top_10'] as bool).obs,
        store: Store(id: -1),
        isChecked: false.obs,
        hasBellIconAndBorder: (raw[i]['is_privilege'] as bool).obs,
        isSoldout: raw[i]['is_sold_out'] == true ? true.obs : false.obs,
      );
      products.add(tempProduct);
    }

    if (raw.length < mConst.limit) {
      allowCallAPI.value = false;
    }
  }

  Future<void> deleteSelectedProducts() async {
    StatusModel statusModel = await _apiProvider.deleteProduct();
    log('deleteSelectedProducts finished. ${statusModel.message}');

    if (statusModel.statusCode == 200) {
      log('update state product mgmt');
      List<int> selectedProductIndexs = [];
      for (int i = 0; i < products.length; i++) {
        if (products[i].isChecked!.value) {
          selectedProductIndexs.add(i);
        }
      }
      selectedProductIndexs.sort();
      for (int i = 0; i < selectedProductIndexs.length; i++) {
        products.removeAt(selectedProductIndexs.reversed.elementAt(i));
      }
      productsId.clear();
      isSelectAll.value = false;
      getProducts(isScrolling: false);
    } else {
      mSnackbar(message: statusModel.message);
    }
  }

  void addOrRemoveTop10SelectedProducts() async {
    bool isTop10 = products
        .firstWhere((element) => productsId.first == element.id)
        .isTop10!
        .value;
    late StatusModel statusModel;
    if (isTop10) {
      statusModel =
          await _apiProvider.removeTop10(data: {"productIdList": productsId});
    } else {
      statusModel =
          await _apiProvider.addToTop10(data: {"productIdList": productsId});
    }
    log('top 10 . ${statusModel.message}');

    if (statusModel.statusCode == 200) {
      log('update state product mgmt');
      for (int i = 0; i < productsId.length; i++) {
        Product product =
            products.firstWhere((element) => productsId[i] == element.id);
        product.isTop10!.value = !isTop10;
        product.isChecked!.value = false;
      }
      productsId.clear();
      isSelectAll.value = false;
    } else {
      mSnackbar(message: statusModel.message);
    }
  }

  Future<void> soldOut() async {
    print('product ids ${productsId}');
    bool isSoldout = products
        .firstWhere((element) => productsId.first == element.id)
        .isSoldout!
        .value;

    StatusModel statusModel = await _apiProvider
        .soldOut(data: {"productIdList": productsId, "is_release": isSoldout});
    log('sold out . ${statusModel.message}');

    if (statusModel.statusCode == 200) {
      log('update state product mgmt');
      // change products soldout
      for (int i = 0; i < productsId.length; i++) {
        Product product =
            products.firstWhere((element) => productsId[i] == element.id);
        product.isSoldout!.value = !isSoldout;
        product.isChecked!.value = false;
      }
      productsId.clear();
      isSelectAll.value = false;
    } else {
      mSnackbar(message: statusModel.message);
    }
  }

  Future<void> addToDingDong() async {
    print('addToDingDong productsId ${productsId}');
    Product product =
        products.firstWhere((element) => productsId.first == element.id);
    bool isFirstProductHasBellIconAndBorder =
        product.hasBellIconAndBorder!.value;
    StatusModel statusModel = await _apiProvider.addToDingDong(data: {
      "productIdList": productsId,
      "is_release": product.hasBellIconAndBorder!.value
    });
    log('ding dong  . ${statusModel.message}');

    if (statusModel.statusCode == 200) {
      for (int i = 0; i < productsId.length; i++) {
        Product tempProduct =
            products.firstWhere((element) => productsId[i] == element.id);
        tempProduct.hasBellIconAndBorder!.value =
            !isFirstProductHasBellIconAndBorder;
        tempProduct.isChecked!.value = false;
      }
      productsId.clear();
      isSelectAll.value = false;
    } else {
      mSnackbar(message: statusModel.message);
    }
  }

  Future<void> addToTop10() async {
    isAdding.value = true;
    StatusModel statusModel =
        await _apiProvider.addToTop10(data: {"productIdList": productsId});

    isAdding.value = false;

    if (statusModel.statusCode == 200) {
      if (statusModel.message == '') {
        mSnackbar(message: '오류: 관리자에게 문의하세요.');
      }
      // for loop productsIds
      for (int i = 0; i < productsId.length; i++) {
        Product product =
            products.firstWhere((element) => productsId[i] == element.id);
        product.isTop10!.toggle();
        product.isChecked!.value = false;
      }
      productsId.clear();
      isSelectAll.value = false;

      mSnackbar(message: statusModel.message);
      log('update state product mgmt');
    } else {
      if (statusModel.message == '') {
        mSnackbar(message: '오류: 관리자에게 문의하세요.');
      } else {
        mSnackbar(message: statusModel.message);
      }
    }
    Get.back();
  }

  searchBtnPressed(String text) {
    // searchContent = text;
    searchController.text = text;
    getProducts(isScrolling: false);
  }

  void getProductsWithFilter(
      {String? startDate, String? endDate, List<int>? clothCatIds}) {
    getProducts(
        startDate: startDate,
        endDate: endDate,
        clothCatIds: clothCatIds,
        isScrolling: false);
  }
}
