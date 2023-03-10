import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/data/api_provider.dart';
import 'package:wholesaler_user/app/models/product_image_model.dart';
import 'package:wholesaler_user/app/models/product_model.dart';
import 'package:wholesaler_user/app/models/review.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wholesaler_user/app/models/review_category.dart';
import 'package:wholesaler_user/app/modules/order_inquiry_and_review/controllers/orders_inquiry_review_controller.dart';
import 'package:wholesaler_user/app/modules/order_inquiry_and_review/views/order_inquiry_and_review_view.dart';
import 'package:wholesaler_user/app/modules/page5_my_page/controllers/page5_my_page_controller.dart';
import 'package:wholesaler_user/app/modules/product_detail/controller/tab_2_review_controller.dart';
import 'package:wholesaler_user/app/widgets/snackbar.dart';

import '../../main/view/user_main_view.dart';

class ReviewDetailController extends GetxController {
  TextEditingController contentController = TextEditingController();
  Tab2ReviewProductDetailController ctr =
      Get.put(Tab2ReviewProductDetailController());

  uApiProvider _apiProvider = uApiProvider();

  Rx<Review>? selectedReviw;
  Rx<String?> reviewImageUrl = ''.obs;
  ProductImageModel? productImageModel;
  RxInt price = (-1).obs;

  bool? isComingFromReviewListPage;

  RxList<ReviewCategoryModel> reviewFitCategoryList =
      <ReviewCategoryModel>[].obs;
  RxList<ReviewCategoryModel> reviewQualityCategoryList =
      <ReviewCategoryModel>[].obs;
  RxList<ReviewCategoryModel> reviewColorCategoryList =
      <ReviewCategoryModel>[].obs;

  RxInt selectFitCategoryIndex = 0.obs;
  RxInt selectColorCategoryIndex = 0.obs;
  RxInt selectQualityCategoryIndex = 0.obs;

  RxBool contentOK = false.obs;
  RxBool photoOK = false.obs;

  RxList<XFile> pickedImageList = <XFile>[].obs;
  RxBool isUploadLoading = false.obs;

  RxList<dynamic> urlList = <dynamic>[].obs;
  RxList<dynamic> pathList = <dynamic>[].obs;

  init(
      {required Review tempSelectedReviw,
      required bool isComingFromOrderInquiryPage}) {
    this.isComingFromReviewListPage = isComingFromOrderInquiryPage;
    // customize for UI

    price.value = tempSelectedReviw.product.price!;
    // selectedReviw = tempSelectedReviw.obs;
    selectedReviw = Review(
      id: tempSelectedReviw.id,
      content: tempSelectedReviw.content,
      rating: tempSelectedReviw.rating,
      ratingType: tempSelectedReviw.ratingType,
      date: tempSelectedReviw.date,
      writer: tempSelectedReviw.writer,
      // writableReviewInfoModel: tempSelectedReviw.writableReviewInfoModel,
      product: Product(
        id: tempSelectedReviw.product.id,
        title: tempSelectedReviw.product.title,
        imgUrl: tempSelectedReviw.product.imgUrl,
        store: tempSelectedReviw.product.store,
        price: tempSelectedReviw.product.price,
        quantity: tempSelectedReviw.product.quantity,
        imgHeight: tempSelectedReviw.product.imgHeight,
        imgWidth: tempSelectedReviw.product.imgWidth,
        OLD_option: tempSelectedReviw.product.OLD_option,
        selectedOptionAddPrice:
            tempSelectedReviw.product.selectedOptionAddPrice,
        orderDetailId: tempSelectedReviw.product.orderDetailId,
      ),
      createdAt: tempSelectedReviw.createdAt,
    ).obs;
    selectedReviw!.value.product.showQuantityPlusMinus = false;
    selectedReviw!.value.product.price = null;
    selectedReviw!.value.product.store.name = null;
    reviewImageUrl = tempSelectedReviw.reviewImageUrl.obs;
  }

  uploadReviewImagePressed() async {
    // hide keyboard
    FocusScope.of(Get.context!).requestFocus(new FocusNode());

    print('uploadReviewImagePressed');
    XFile? _pickedImage = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);

    // upload image
    if (_pickedImage != null) {
      productImageModel =
          await _apiProvider.postUploadReviewImage(pickedImage: _pickedImage);

      mSnackbar(message: "이미지가 등록되었습니다.");

      if (productImageModel!.statusCode == 200) {
        print('image uploaded productImageModel.url ${productImageModel!.url}');
        selectedReviw!.value.reviewImageUrl = productImageModel!.url;
        reviewImageUrl.value = productImageModel!.url;
      }
    }
  }

  uploadReviewImageMultiPressed() async {
    pickedImageList.value = await ImagePicker().pickMultiImage();
    if (pickedImageList.isNotEmpty) {
      if (pickedImageList.length > 5) {
        mSnackbar(message: '최대 5장까지 업로드 가능합니다.');
      } else {
        isUploadLoading.value = true;

        List<File> temp = [];
        for (int i = 0; i < pickedImageList.length; i++) {
          temp.add(File(pickedImageList[i].path));
        }

        var json =
            await _apiProvider.postUploadReviewImageMutli(pickedImage: temp);
        urlList.value = json['url'];
        pathList.value = json['file_path'];
        //업로드 하고
        photoOK.value = true;
        isUploadLoading.value = false;
      }
    }
  }

  getReviewCategory() async {
    var json = await _apiProvider.getReviewCategory();

    reviewFitCategoryList.value = json['category_fit_list']
        .map((i) => ReviewCategoryModel.fromJson(i))
        .toList()
        ?.cast<ReviewCategoryModel>();

    reviewColorCategoryList.value = json['category_color_list']
        .map((i) => ReviewCategoryModel.fromJson(i))
        .toList()
        ?.cast<ReviewCategoryModel>();

    reviewQualityCategoryList.value = json['category_quality_list']
        .map((i) => ReviewCategoryModel.fromJson(i))
        .toList()
        ?.cast<ReviewCategoryModel>();

    reviewFitCategoryList.sort((a, b) => b.id!.compareTo(a.id!));
    reviewColorCategoryList.sort((a, b) => b.id!.compareTo(a.id!));
    reviewQualityCategoryList.sort((a, b) => b.id!.compareTo(a.id!));
  }

  reviewEditPressed() async {
    print('reviewEditPressed');
    bool isSuccess = await _apiProvider.putReviewEdit(
        content: contentController.value.text,
        image: productImageModel,
        reviewId: selectedReviw!.value.id,
        star: selectedReviw!.value.rating);
    print('edit');
    if (isSuccess) {
      await ctr.getProductReviews(productId: selectedReviw!.value.product.id);
      mSnackbar(message: '수정이 완료되었습니다.');
      Get.back();
    }
  }

  reviewAddBtnPressed() async {
    print('reviewAddBtnPressed');
    // check if rating empty
    print('selectedReviw!.value.rating ${selectedReviw!.value.rating}');
    if (selectedReviw!.value.rating == 0) {
      mSnackbar(message: '별점을 선택해주세요.');
      return;
    }

    // check if content empty
    if (contentController.text.isEmpty) {
      mSnackbar(message: '내용을 입력해주세요.');
      return;
    }

    if (contentController.text.length < 20) {
      mSnackbar(message: '내용을 20자 이상입력해주세요.');
      return;
    }

    String path = '';
    if (urlList.isNotEmpty) {
      // pathList.forEach((element) {
      //   path += element+',';
      // });
      for (int i = 0; i < pathList.length; i++) {
        if (i != pathList.length - 1) {
          path += pathList[i] + ',';
        } else {
          path += pathList[i];
        }
      }
    }

    bool isSuccess = await _apiProvider.postReviewAdd(
      orderDetailId: selectedReviw!.value.product.orderDetailId!,
      content: contentController.value.text,
      // image_path:
      //     productImageModel != null && productImageModel!.statusCode == 200
      //         ? productImageModel!.path
      //         : null,
      category_fit_id: reviewFitCategoryList[selectFitCategoryIndex.value].id!,
      category_color_id:
          reviewColorCategoryList[selectColorCategoryIndex.value].id!,
      category_quality_id:
          reviewQualityCategoryList[selectQualityCategoryIndex.value].id!,

      image_path: path == '' ? null : path,
      star: selectedReviw!.value.rating,
    );

    if (isSuccess) {
      Get.delete<OrderInquiryAndReviewController>();
      Get.delete<Page5MyPageController>();

      print(
          'isComingFromReviewListPage $isComingFromReviewListPage go back to review list page');
      // Get.to(
      //     () => OrderInquiryAndReviewView(
      //         hasHomeButton: true, isBackEnable: false),
      //     arguments: isComingFromReviewListPage);

      // Get.back();
      Get.offAll(() => UserMainView());
    }
  }
}
