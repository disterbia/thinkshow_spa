import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:wholesaler_user/app/constants/constants.dart';
import 'package:wholesaler_user/app/constants/enum.dart';
import 'package:wholesaler_user/app/data/api_provider.dart';
import 'package:wholesaler_user/app/models/order_model.dart';
import 'package:wholesaler_user/app/widgets/category_tags/category_tag_controller.dart';
import 'package:wholesaler_user/app/widgets/category_tags/category_tag_controller6.dart';
import 'package:wholesaler_user/app/widgets/category_tags/category_tags6.dart';
import 'package:wholesaler_user/app/widgets/range_date_picker/range_date_picker_controller.dart';
import 'package:wholesaler_user/app/widgets/snackbar.dart';
import 'package:wholesaler_user/app/widgets/two_buttons.dart';

class OrderInquiryAndReviewController extends GetxController {
  CategoryTagController6 categoryTagCtr = Get.put(CategoryTagController6());
  uApiProvider _apiProvider = uApiProvider();
  bool? isReviewPage;

  RxList<OrderOrReview> items = <OrderOrReview>[].obs;

  Rx<ScrollController> scrollController = ScrollController().obs;
  int offset = 0;
  RxBool allowCallAPI = true.obs;

  RxList<String> category = ["3개월", "1개월", "선택"].obs;

  @override
  Future<void> onInit() async {
    isReviewPage = Get.arguments;
    // print('OrderInquiryAndReviewController onInit isReviewPage ${isReviewPage}');
    if (isReviewPage!) {
      // print('REVIEW PAGE');
      items.value = await _apiProvider.getUserWaitReviews();
      allowCallAPI.value = false;
    } else {
      //print('ORDER INQUIRY PAGE');
      getInquiryData();

      scrollController.value.addListener(() {
        if (scrollController.value.position.pixels ==
                scrollController.value.position.maxScrollExtent &&
            allowCallAPI.isTrue) {
          offset += mConst.limit;
          updateProduct(isScrolling: true, period: getPeriodText());
        }
      });
    }
    super.onInit();
  }

  getInquiryData() async {
    items.value = await _apiProvider.getOrderInquiry(
        period: OrderInquiryPeriod.total, offset: offset, limit: mConst.limit);

    if (items.length < mConst.limit) {
      allowCallAPI.value = false;
    }
  }

  periodChipPressed() async {
    offset = 0;
    allowCallAPI.value = true;

    if (categoryTagCtr.selectedMainCatIndex.value == 3) {
      //선택 다이얼로그
      showDatePickerDialog();
    } else {
      category[2] = '선택';
      categoryTagCtr.startDateController.value.text = '';
      categoryTagCtr.endDateController.value.text = '';
      updateProduct(isScrolling: false, period: getPeriodText());
    }
  }

  RangeDatePickerController dateCtr = Get.put(RangeDatePickerController());

  void showDatePickerDialog() {
    showDialog(
      barrierDismissible: false,
      context: Get.context!,
      builder: (BuildContext context) => Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 30),
            SfDateRangePicker(
              onSelectionChanged: dateCtr.onSelectionChanged,
              selectionMode: DateRangePickerSelectionMode.range,
              initialSelectedRange:
                  categoryTagCtr.startDateController.value.text.isNotEmpty
                      ? PickerDateRange(
                          DateTime.parse(
                              categoryTagCtr.startDateController.value.text),
                          DateTime.parse(
                              categoryTagCtr.endDateController.value.text))
                      : null,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TwoButtons(
                leftBtnText: 'cancel'.tr,
                rightBtnText: 'ok'.tr,
                lBtnOnPressed: () {
                  Get.back();
                },
                rBtnOnPressed: () {
                  categoryTagCtr.startDateController.value.text =
                      DateFormat('yyyy-MM-dd').format(dateCtr.tempStartDate);
                  categoryTagCtr.endDateController.value.text =
                      DateFormat("yyyy-MM-dd").format(dateCtr.tempEndDate);

                  category[2] = categoryTagCtr.startDateController.value.text +
                      ' - ' +
                      categoryTagCtr.endDateController.value.text;

                  updateProduct(
                      isScrolling: false,
                      period: getPeriodText(),
                      startDate: categoryTagCtr.startDateController.value.text,
                      endDate: categoryTagCtr.endDateController.value.text);

                  Get.back();
                },
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Future<void> updateProduct(
      {required bool isScrolling,
      required String period,
      String startDate = '',
      String endDate = ''}) async {
    if (!isScrolling) {
      offset = 0;
      items.clear();
      allowCallAPI.value = true;
    }
    List<OrderOrReview> tempItems = await _apiProvider.getOrderInquiry(
        period: period,
        offset: offset,
        limit: mConst.limit,
        startDate: startDate,
        endDate: endDate);

    items.addAll(tempItems);

    if (tempItems.length < mConst.limit) {
      allowCallAPI.value = false;
    }
  }

  getPeriodText() {
    String period;
    if (categoryTagCtr.selectedMainCatIndex == 0) {
      period = OrderInquiryPeriod.total;
    } else if (categoryTagCtr.selectedMainCatIndex == 1) {
      period = OrderInquiryPeriod.threeMonth;
    } else if (categoryTagCtr.selectedMainCatIndex == 2) {
      period = OrderInquiryPeriod.oneMonth;
    } else if (categoryTagCtr.selectedMainCatIndex == 3) {
      period = OrderInquiryPeriod.during;
    } else {
      period = '';
    }
    return period;
  }

  // 구매확정 button pressed
  orderSettledBtnPressed(int orderDetailId) async {
    // print('orderSettledBtnPressed orderDetailId: $orderDetailId');
    bool isSuccess = await _apiProvider.orderSettled(orderDetailId);

    if (isSuccess) {
      mSnackbar(message: '구매확정 완료');
      getInquiryData();
    }
  }
}
