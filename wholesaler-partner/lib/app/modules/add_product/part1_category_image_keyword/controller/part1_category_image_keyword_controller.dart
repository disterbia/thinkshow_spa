import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wholesaler_partner/app/data/api_provider.dart';
import 'package:wholesaler_user/app/data/cache_provider.dart';
import 'package:wholesaler_user/app/models/product_image_model.dart';
import 'package:wholesaler_user/app/widgets/snackbar.dart';

class AP_Part1Controller extends GetxController
    with GetSingleTickerProviderStateMixin {
  final pApiProvider _apiProvider = pApiProvider();
  RxBool isPrevilage = false.obs;
  RxList<XFile> pickedImage1 = <XFile>[].obs;
  // RxList<XFile>? _pickedImage1;
  RxList<dynamic> imageUrl1 = <dynamic>[].obs;
  RxList<dynamic> imagePath1 = <dynamic>[].obs;
  RxBool isUploadLoading1 = false.obs;

  RxList<XFile> pickedImage2 = <XFile>[].obs;
  // RxList<XFile>? _pickedImage2;
  RxList<dynamic> imageUrl2 = <dynamic>[].obs;
  RxList<dynamic> imagePath2 = <dynamic>[].obs;
  RxBool isUploadLoading2 = false.obs;

  XFile? pickedImage3;
  RxString imageUrl3 = ''.obs;
  RxString imagePath3 = ''.obs;
  RxBool isUploadLoading3 = false.obs;

  TextEditingController categoryController = TextEditingController();
  TextEditingController keywordsController = TextEditingController();
  TextEditingController colorsController = TextEditingController();

  late TabController selectImgController;

  RxBool isDingdongDeliveryActive = false.obs;

  final List<Tab> imageTabs = <Tab>[
    Tab(text: 'representative_image'.tr),
    Tab(text: '상세 이미지'.tr),
    // Tab(text: 'detail_cut'.tr)
  ];

  @override
  void onInit() {
    super.onInit();
    isPrevilage.value = CacheProvider().isPrivilege();
    selectImgController = TabController(vsync: this, length: imageTabs.length);
  }

  @override
  void onClose() {
    selectImgController.dispose();
    super.onClose();
  }

  Future<void> uploadImageBtnPressed() async {
    pickedImage1.value = await ImagePicker().pickMultiImage();
    if (pickedImage1.value.length == 3) {
      uploadImage();
    } else {
      return mSnackbar(message: "대표이미지는 반드시 3장이어야 합니다.");
    }
  }

  Future<void> uploadImage() async {
    if (pickedImage1 != null) {
      isUploadLoading1.value = true;
      List<File> temp = [];
      for (int i = 0; i < pickedImage1!.length; i++) {
        temp.add(File(pickedImage1![i].path));
      }
      ProductImageModel2 productImageModel =
          await _apiProvider.uploadProductImage(pickedImage: temp);
      isUploadLoading1.value = false;
      mSnackbar(message: productImageModel.message);

      if (productImageModel.statusCode == 200) {
        imageUrl1.value = productImageModel.url;
        imagePath1.value = productImageModel.path;
        print("---------${imageUrl1.value}");
        print("---------${imagePath1.value}");
      }
    }
  }

  Future<void> uploadImageBtnPressed3(int index) async {
    XFile? temp = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (temp != null) {
      imageUrl1.removeAt(index);
      imagePath1.removeAt(index);
      pickedImage1.add(temp);
      uploadImage3(index);
    } else {
      return mSnackbar(message: "대표이미지는 반드시 3장이어야 합니다.");
    }
  }

  Future<void> uploadImage3(int index) async {
    isUploadLoading3.value = true;
    ProductImageModel productImageModel = await _apiProvider
        .uploadProductImage3(pickedImage: File(pickedImage1[0].path));
    isUploadLoading3.value = false;
    pickedImage1.clear();
    mSnackbar(message: "이미지가 등록되었습니다.");

    if (productImageModel.statusCode == 200) {
      if (index == 2) {
        imagePath1.add(productImageModel.path);
        imageUrl1.add(productImageModel.url);
      } else {
        imagePath1.insert(index, productImageModel.path);
        imageUrl1.insert(index, productImageModel.url);
      }
    }
  }

  Future<void> uploadImageBtnPressed2() async {
    pickedImage2.value = await ImagePicker().pickMultiImage();
    print(pickedImage2.value);
    if (pickedImage2.value.length < 30 && pickedImage2.value.isNotEmpty) {
      uploadImage2();
    } else if (pickedImage2.value.isEmpty) {
      return mSnackbar(message: "상세이미지는 반드시 1장 이상 업로드 해야합니다.");
    } else {
      return mSnackbar(message: "상세이미지는 30장 이상 업로드 할 수 없습니다.");
    }
  }

  Future<void> updateImageBtnPressed() async {
    pickedImage2.value = await ImagePicker().pickMultiImage();

    if (pickedImage2.length + imagePath2.length < 30) {
      updateImage();
    } else {
      return mSnackbar(message: "상세이미지는 30장 이상 업로드 할 수 없습니다.");
    }
  }

  Future<void> updateImage() async {
    if (pickedImage2.length != null) {
      isUploadLoading2.value = true;
      List<File> temp = [];

      for (int i = 0; i < pickedImage2.length; i++) {
        temp.add(File(pickedImage2[i].path));
        print(pickedImage2[i].path);
      }

      ProductImageModel2 productImageModel =
          await _apiProvider.uploadProductImage(pickedImage: temp);

      if (productImageModel.statusCode == 200) {
        imageUrl2.value += productImageModel.url;
        imagePath2.value += productImageModel.path;
        print(imageUrl2.value);
        print(imagePath2.value);
      }
      isUploadLoading2.value = false;
    }
  }

  Future<void> uploadImage2() async {
    if (pickedImage2 != null) {
      isUploadLoading2.value = true;
      List<File> temp = [];
      for (int i = 0; i < pickedImage2.length; i++) {
        temp.add(File(pickedImage2[i].path));
      }
      ProductImageModel2 productImageModel =
          await _apiProvider.uploadProductImage(pickedImage: temp);
      isUploadLoading2.value = false;
      mSnackbar(message: productImageModel.message);

      if (productImageModel.statusCode == 200) {
        imageUrl2.value = productImageModel.url;
        imagePath2.value = productImageModel.path;
        print(imageUrl2.value);
        print(imagePath2.value);
      }
    }
  }

  // Future<void> uploadImageBtnPressed3() async {
  //   _pickedImage3 = await pickImage();
  //   uploadImage3();
  // }

  // Future<XFile?> pickImage3() async {
  //   return await ImagePicker()
  //       .pickImage(source: ImageSource.gallery, imageQuality: 50);
  // }
  //
  // Future<void> uploadImage3() async {
  //   if (_pickedImage3 != null) {
  //     isUploadLoading3.value = true;
  //     ProductImageModel productImageModel = await _apiProvider
  //         .uploadProductImage(pickedImage: File(_pickedImage3!.path));
  //     isUploadLoading3.value = false;
  //     mSnackbar(message: productImageModel.message);
  //
  //     if (productImageModel.statusCode == 200) {
  //       imageUrl3.value = productImageModel.url;
  //       imagePath3.value = productImageModel.path;
  //     }
  //   }
  // }
}
