import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/Constants/constants.dart';
import 'package:wholesaler_user/app/data/api_provider.dart';
import 'package:wholesaler_user/app/models/product_model.dart';

class Tab5DingPickController extends GetxController {
  RxList<Product> products = <Product>[].obs;
  uApiProvider _apiProvider = uApiProvider();

  Rx<ScrollController> scrollController = ScrollController().obs;
  int offset = 0;
  RxBool allowCallAPI = true.obs;
  RxBool isLoading = false.obs;
  @override
  onInit() async {
    scrollController.value.addListener(() {
      if (scrollController.value.position.pixels ==
              scrollController.value.position.maxScrollExtent) {
        offset += mConst.limit;
        addDataToList();
      }
    });
    super.onInit();
  }

  Future<void> init() async {
    offset=0;
    isLoading.value = true;
    products.value =
        await _apiProvider.getDingsPick(offset: 0, limit: mConst.limit);
    isLoading.value = false;
  }

  addDataToList() async {
    List<Product> tempProducts =
        await _apiProvider.getDingsPick(offset: offset, limit: mConst.limit);

    products.addAll(tempProducts);
    // check if last product from server.
    if (tempProducts.length == 0) {
      allowCallAPI.value = false;
    }
  }
}
