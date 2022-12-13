import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/data/api_provider.dart';
import 'package:wholesaler_user/app/models/faq_page_model/faq_page_model.dart';
import 'package:wholesaler_user/app/models/faq_question_model.dart';
import 'package:url_launcher/url_launcher.dart';

class FaqController extends GetxController {
  uApiProvider _apiProvider = uApiProvider();

  RxList<FaqPageModel> faqList = <FaqPageModel>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();

    faqList.value = await _apiProvider.getFaq();
  }
}
