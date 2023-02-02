import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/constants/enum.dart';
import 'package:wholesaler_user/app/data/api_provider.dart';
import 'package:wholesaler_user/app/models/order_model.dart';

class ReviewController extends GetxController {
  uApiProvider _apiProvider = uApiProvider();

  RxList<OrderOrReview> items = <OrderOrReview>[].obs;

  // Rx<ScrollController> scrollController = ScrollController().obs;
  // RxBool allowCallAPI = true.obs;

  @override
  Future<void> onInit() async {
    getUserReview();
    super.onInit();
  }

  getUserReview() async {
    items.value = await _apiProvider.getUserReviews();
  }
}
