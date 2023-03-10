import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/data/api_provider.dart';
import 'package:wholesaler_user/app/widgets/category_tags/cloth_category2.dart';

class CategoryTagController6 extends GetxController {
  RxInt selectedMainCatIndex = 0.obs;
  // RxInt selectedSubCatIndex = 0.obs;
  RxBool isDingDongTab =
      false.obs; // For Dingdong tab: show "인기", for all other pages, show "ALL"

  Rx<TextEditingController> startDateController = TextEditingController().obs;
  Rx<TextEditingController> endDateController = TextEditingController().obs;
}
