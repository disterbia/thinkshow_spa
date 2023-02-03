import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/constants/enum.dart';
import 'package:wholesaler_user/app/data/api_provider.dart';
import 'package:wholesaler_user/app/models/order_model.dart';
import 'package:wholesaler_user/app/models/review_mdoel2.dart';

class ReviewController extends GetxController {
  uApiProvider _apiProvider = uApiProvider();

  RxList<OrderOrReview> items = <OrderOrReview>[].obs;

  // Rx<ScrollController> scrollController = ScrollController().obs;
  // RxBool allowCallAPI = true.obs;

  RxList<ReviewModel2> myItems = <ReviewModel2>[].obs;

  @override
  Future<void> onInit() async {
    getUserWaitReview();
    getUserAlreadyReview();
    super.onInit();
  }

  getUserWaitReview() async {
    items.value = await _apiProvider.getUserWaitReviews();
  }

  getUserAlreadyReview() async {
    myItems.value = await _apiProvider.getUserAlreadyReviews();
  }
}
