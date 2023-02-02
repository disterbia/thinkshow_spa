import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/data/api_provider.dart';
import 'package:wholesaler_user/app/models/inquiries_cateroies_model.dart';
import 'package:wholesaler_user/app/models/inquiry_model.dart';
import 'package:wholesaler_user/app/models/product_model.dart';
import 'package:wholesaler_user/app/modules/product_detail/controller/product_detail_controller.dart';
import 'package:wholesaler_user/app/widgets/snackbar.dart';

class Tab3InquiryController extends GetxController {
  ProductDetailController productDetailController =
      Get.find<ProductDetailController>();
  uApiProvider _apiProvider = uApiProvider();
  RxBool isSecret = false.obs;
  TextEditingController contentController = TextEditingController();
  RxList<InquiryModel> inquires = <InquiryModel>[].obs;
  int productId = -1;
  late Product product;
  RxList<InquiriesCategoiesModel> inquiresCategoiesList =
      <InquiriesCategoiesModel>[].obs;

  Rx<int> inquiresCategoiesIndex = Rx<int>(-1);

  Future<void> init() async {
    productId = Get.arguments;
    product = productDetailController.product.value;
    callInquiryAPI();
    getInquiryCategory();
  }

  callInquiryAPI() async {
    inquires.value =
        await _apiProvider.getProductInquiries(productId: productId);
  }

  getInquiryCategory() async {
    inquiresCategoiesList.value = await _apiProvider.getInquiriesCategory();
    // inquiresCategoiesIndex.value = -1;
  }

  Future<void> submitInquiryPressed() async {
    int productId = productDetailController.productId;

    // print(
    //     'submitInquiryPressed productId $productId content ${contentController.text} isSecret $isSecret');

    if (inquiresCategoiesIndex.value == -1) {
      mSnackbar(message: '문의 유형을 선택해주세요');
      return;
    }

    if (contentController.text.isEmpty) {
      mSnackbar(message: '문의 사항을 입력해주세요');
      return;
    }

    bool isSuccess = await _apiProvider.postAddInquiry(
        productId: productId,
        content: contentController.text,
        cateoryId: inquiresCategoiesList[inquiresCategoiesIndex.value].id!,
        isSecret: isSecret.value);

    if (isSuccess) {
      contentController.clear();
      isSecret.value = false;
      inquiresCategoiesIndex.value = -1;
      callInquiryAPI();
      Get.back();
    }
  }
}
