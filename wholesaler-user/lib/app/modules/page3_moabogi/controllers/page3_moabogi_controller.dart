import 'dart:developer';

import 'package:get/get.dart';
import 'package:wholesaler_user/app/data/api_provider.dart';
import 'package:wholesaler_user/app/modules/page1_home/models/image_banner_model.dart';
import 'package:wholesaler_user/app/modules/page3_product_category_page/view/product_category_page_view.dart';

class Page3MoabogiController extends GetxController {
  uApiProvider _apiProvider = uApiProvider();

  RxList<ImageBannerModel> imageBanners = <ImageBannerModel>[].obs;

  getBannerData() async {
    imageBanners.value = await _apiProvider.getBannerImageList();
  }

  void chipPressed(int index) {
    print('sajad tapped main category index $index');
    Get.to(() => ProductCategoryPageView(index));
  }
}
