import 'dart:convert';

import 'package:get/get.dart';
import 'package:wholesaler_user/app/models/store_model.dart';
import 'package:wholesaler_user/app/widgets/snackbar.dart';

import '../../../data/api_provider.dart';

class Page3MyPageController extends GetxController {
  pApiProvider apiProvider = pApiProvider();
  RxBool isLoading = false.obs;
  Store store = Store(id: -1);
  bool isOwner = false;
  String accountId = '';

  @override
  void onInit() {
    super.onInit();
    print("onInit 실행");
    getUserInfo();
  }

  getUserInfo() async {
    isLoading.value = true;
    var response = await apiProvider.getUserInfo();
    isLoading.value = false;
    var json = jsonDecode(response.bodyString!);
    print("실행");
    isOwner = json['is_owner'] ?? false;
    bool isRegistBankInfo = json['is_regist_bank_info'] ?? false;
    accountId = json['account_id'];
    String storeName = json['store_name'];
    String storeThumbnailImageUrl = json['store_thumbnail_image_url'] ?? '';
    print(" 이름 : ${storeName}");
    String storeThumbnailImagePath = json['store_thumbnail_image_path'] ?? '';
    int point = json['point'];
    int productTotalCount = json['product_total_count'];
    int storeFavoriteCount = json['store_favorite_count'];
    store = Store(
      id: -1,
      name: storeName,
      imgUrl: storeThumbnailImageUrl.obs,
      totalProducts: productTotalCount,
      totalStoreLiked: storeFavoriteCount,
    );
  }
}
