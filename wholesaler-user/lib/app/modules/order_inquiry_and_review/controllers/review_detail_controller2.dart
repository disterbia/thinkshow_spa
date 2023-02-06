import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/constants/enum.dart';
import 'package:wholesaler_user/app/data/api_provider.dart';
import 'package:wholesaler_user/app/models/order_model.dart';
import 'package:wholesaler_user/app/models/review_mdoel2.dart';

class ReviewDetailController2 extends GetxController {

  RxInt sliderIndex = 0.obs;
  CarouselController indicatorSliderController = CarouselController();

  @override
  Future<void> onInit() async {

    super.onInit();
  }


}
