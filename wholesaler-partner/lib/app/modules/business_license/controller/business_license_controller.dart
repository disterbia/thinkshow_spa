import 'dart:developer';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wholesaler_user/app/widgets/snackbar.dart';

import '../../../data/api_provider.dart';

class BusinessLicenseController extends GetxController {
  final pApiProvider _apiProvider = pApiProvider();
  RxBool isLoading = false.obs;
  RxBool isUploading = false.obs;
  // String imagePath = '';
  String number = '';
  XFile? pickedImage;
  RxString uploadedImageURL = ''.obs;

  @override
  void onInit() async {
    await getLicenseImage();
  }

  Future<void> getLicenseImage() async {
    isLoading.value = true;
    var response = await _apiProvider.getBusinessLicense();

    uploadedImageURL.value = response['business_regist_image_url'];
    number = response['business_regist_number'];

    isLoading.value = false;
  }

  Future<XFile?> pickImage() async {
    return await ImagePicker().pickImage(source: ImageSource.gallery);
  }

  // Future<void> uploadImage() async {
  //   if (pickedImage != null) {
  //     isUploading.value = true;
  //     _apiProvider
  //         .postUploadBusinessRegisterImage(pickedImage: pickedImage!)
  //         .then((value) {
  //       isUploading.value = false;
  //       mSnackbar(message: 'image_uploaded'.tr);
  //       uploadedImageURL.value = value;
  //     }).onError((error, stackTrace) {
  //       mSnackbar(message: error.toString());
  //       isUploading.value = false;
  //       uploadedImageURL.value = '';
  //     });
  //     log('sajad uploadedImageURL $uploadedImageURL');
  //   }
  // }
}
