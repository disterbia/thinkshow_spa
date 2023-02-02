// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:launch_review/launch_review.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:wholesaler_partner/app/widgets/loading_widget.dart';
import 'package:wholesaler_user/app/Constants/enum.dart';
import 'package:wholesaler_user/app/Constants/functions.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/dimens.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/modules/auth/register_privacy_terms/views/register_privacy_terms_view.dart';
import 'package:wholesaler_user/app/modules/bulletin_list/views/bulletin_list_view.dart';
import 'package:wholesaler_user/app/modules/faq/views/faq_view.dart';
import 'package:wholesaler_user/app/modules/order_inquiry_and_review/controllers/orders_inquiry_review_controller.dart';
import 'package:wholesaler_user/app/modules/order_inquiry_and_review/views/order_inquiry_and_review_view.dart';
import 'package:wholesaler_user/app/modules/order_inquiry_and_review/views/review_view.dart';
import 'package:wholesaler_user/app/modules/page4_favorite_products/controllers/page4_favorite_products_controller.dart';
import 'package:wholesaler_user/app/modules/page4_favorite_products/views/page4_favorite_products_view.dart';
import 'package:wholesaler_user/app/modules/page5_my_page/company_intro_page/view/company_intro_view.dart';
import 'package:wholesaler_user/app/modules/page5_my_page/controllers/page5_my_page_controller.dart';
import 'package:wholesaler_user/app/modules/page5_my_page/inquiries_page/view/inquiries_page_view.dart';
import 'package:wholesaler_user/app/modules/page5_my_page/widgets/top_user_id_name_widget.dart';
import 'package:wholesaler_user/app/modules/point_mgmt/views/point_mgmt_view.dart';
import 'package:wholesaler_user/app/utils/utils.dart';
import 'package:wholesaler_user/app/widgets/custom_appbar.dart';
import 'package:wholesaler_user/app/widgets/product/product_item_vertical_widget.dart';

class Page5MyPageView extends GetView<Page5MyPageController> {
  late Page5MyPageController ctr;
  Page5MyPageView();

  Page4Favorite_RecentlyViewedController ctr2 =
      Get.put(Page4Favorite_RecentlyViewedController());

  late String version;

  init() async {
    ctr = Get.put(Page5MyPageController());
    ctr.init();

    ctr2.getRecentlyProducts();

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
  }

  @override
  Widget build(BuildContext context) {
    // print('inside Page5MyPageView build');
    init();
    return Scaffold(
      appBar: CustomAppbar(isBackEnable: false, title: '마이페이지'),
      body: Obx(() => ctr.isLoading.value ? LoadingWidget() : _body()),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _userIdUsername(),
          _topThreeVerticalBoxs(),
          SizedBox(height: 25),
          Divider(thickness: 6, color: MyColors.grey3),
          ctr2.products.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _recentlyView('최근 본 상품', () {
                      Get.delete<Page4Favorite_RecentlyViewedController>();
                      Get.to(() =>
                          Page4FavoriteProductsView(isRecentSeenProduct: true));
                    }),
                    _recentlyProduct(),
                    Divider(
                      color: MyColors.grey1,
                      indent: 15,
                      endIndent: 15,
                    ),
                  ],
                )
              : SizedBox.shrink(),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              '고객센터',
              style: MyTextStyles.f12.copyWith(color: MyColors.grey10),
            ),
          ),
          _settingOption('문의내역', () {
            Get.to(() => InquiriesPageView());
          }),
          _settingOption('FAQ', () {
            Get.to(() => FaqView());
          }),
          _settingOption('공지사항', () {
            Get.to(() => BulletinListView());
          }),
          _settingOption('회사 소개', () {
            Get.to(() => CompanyIntroPageView());
          }),
          Divider(
            color: MyColors.grey1,
            indent: 15,
            endIndent: 15,
          ),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              '시스템',
              style: MyTextStyles.f12.copyWith(color: MyColors.grey10),
            ),
          ),
          // _settingOption('알림 설정', () {}),
          _alarmSwitchOption('알림 설정'),
          _settingOption('이용약관', () {
            Get.to(() => User_RegisterPrivacyTermsView(),
                arguments: PrivacyOrTerms.terms);
          }),
          _settingOption('개인정보처리방침', () {
            Get.to(() => User_RegisterPrivacyTermsView(),
                arguments: PrivacyOrTerms.privacy);
          }),
          // _settingOption('버전 정보 $version', () {}),
          _versionOption('버전 정보 $version', () {
            LaunchReview.launch();
          }),
          Divider(
            color: MyColors.grey1,
            indent: 15,
            endIndent: 15,
          ),
          // Divider(color: MyColors.grey3),
          // _settingOption('로그아웃', () {
          //   mFuctions.userLogout();
          // }),
        ],
      ),
    );
  }

  Widget _alarmSwitchOption(String title) {
    return Container(
      padding: EdgeInsets.all(15),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: MyTextStyles.f16.copyWith(
                color: MyColors.black3, fontWeight: FontWeight.w500),
          ),
          Container(
            height: 10,
            width: 50,
            child: Switch(
                activeColor: MyColors.primary,
                value: ctr.user.value.isAgreeNotificaiton!.value,
                onChanged: (value) => ctr.notificationToggled(value)),
          )
        ],
      ),
    );
  }

  Widget _userIdUsername() {
    return Padding(
        padding: const EdgeInsets.only(left: 15.0, top: 15.0, right: 15.0),
        child: Obx(
          () => TopUserIDUserNameSettings(
            user: ctr.user.value,
            showSettingsIcon: true,
          ),
        ));
  }

  Widget _topThreeVerticalBoxs() {
    return Obx(
      () => Row(
        children: [
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: Card(
              shadowColor: MyColors.grey1,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
                // side: BorderSide(
                //   color: Colors.grey,
                //   width: 0.01,
                // ),
              ),
              // child: Container(
              //   height: 100,
              //   child: Text('asdf'),
              // ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.delete<OrderInquiryAndReviewController>();

                          Get.to(
                              () => OrderInquiryAndReviewView(
                                  isBackEnable: true, hasHomeButton: false),
                              arguments: false);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/icons/myico_01.png',
                                height: 40,
                              ),
                              Text(
                                '주문 · 배송',
                                style: MyTextStyles.f14
                                    .copyWith(color: MyColors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 60,
                      child: VerticalDivider(
                        thickness: 0.5,
                        // width: 10,
                        color: Color.fromARGB(151, 164, 164, 164),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.delete<OrderInquiryAndReviewController>();
                          // Get.to(
                          //     () => OrderInquiryAndReviewView(
                          //         isBackEnable: true, hasHomeButton: false),
                          //     arguments: true);
                          Get.to(() => ReviewView());
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/icons/myico_02.png',
                                height: 40,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '리뷰',
                                    style: MyTextStyles.f14
                                        .copyWith(color: MyColors.black),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Flexible(
                                    child: Text(
                                      ctr.user.value.waitingReviewCount != null
                                          ? ctr.user.value.waitingReviewCount
                                              .toString()
                                          : '0',
                                      style: MyTextStyles.f14.copyWith(
                                          color: MyColors.primary,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    // ctr.user.value.points != null
                    //     ? SizedBox(
                    //         height: 60,
                    //         child: VerticalDivider(
                    //           thickness: 0.5,
                    //           // width: 10,
                    //           color: Color.fromARGB(151, 164, 164, 164),
                    //         ),
                    //       )
                    //     : SizedBox.shrink(),
                    // ctr.user.value.points != null
                    //     ? Expanded(
                    //         child: InkWell(
                    //           onTap: () {
                    //             Get.to(
                    //               () => PointMgmtView(),
                    //             );
                    //           },
                    //           child: Container(
                    //             padding: EdgeInsets.symmetric(vertical: 10),
                    //             child: Column(
                    //               children: [
                    //                 Image.asset(
                    //                   'assets/icons/myico_03.png',
                    //                   height: 40,
                    //                 ),
                    //                 Row(
                    //                   mainAxisAlignment:
                    //                       MainAxisAlignment.center,
                    //                   children: [
                    //                     Text(
                    //                       '포인트',
                    //                       style: MyTextStyles.f14
                    //                           .copyWith(color: MyColors.black),
                    //                     ),
                    //                     SizedBox(
                    //                       width: 5,
                    //                     ),
                    //                     Flexible(
                    //                       child: Text(
                    //                         Utils.numberFormat(
                    //                             number: ctr
                    //                                 .user.value.points!.value),
                    //                         style: MyTextStyles.f12.copyWith(
                    //                             color: MyColors.primary,
                    //                             fontWeight: FontWeight.bold),
                    //                       ),
                    //                     ),
                    //                   ],
                    //                 )
                    //               ],
                    //             ),
                    //           ),
                    //         ),
                    //       )
                    //     : SizedBox.shrink(),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: 15,
          ),
        ],
      ),
    );
  }

  Widget _settingOption(String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(15),
        width: double.infinity,
        child: Text(
          title,
          style: MyTextStyles.f16
              .copyWith(color: MyColors.black3, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Widget _versionOption(String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(15),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: MyTextStyles.f16.copyWith(
                  color: MyColors.black3, fontWeight: FontWeight.w500),
            ),
            Text(
              "업데이트 하기",
              style: MyTextStyles.f14.copyWith(
                  color: MyColors.primary, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  Widget _recentlyProduct() {
    return Container(
      height: 170,
      padding: EdgeInsets.symmetric(horizontal: 15),
      // alignment : Alignment.center,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: ctr2.products.length,
        separatorBuilder: (BuildContext context, int index) =>
            SizedBox(width: 14),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: 110,
            child: Center(
              child: ProductItemVertical(
                product: ctr2.products[index],
                onlyPhoto: true,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _recentlyView(String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(top: 15, left: 15, right: 15),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: MyTextStyles.f16.copyWith(
                  color: MyColors.black3, fontWeight: FontWeight.w500),
            ),
            Image.asset(
              'assets/icons/ico_arrow02.png',
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  Widget _settingBox(String label, String? value, Function() onTap) {
    return Flexible(
      flex: 1,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 80,
          decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.all(Radius.circular(MyDimensions.radius)),
              border: Border.all(color: MyColors.grey1)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: Text(
                label,
                style: MyTextStyles.f16,
              )),
              value != null
                  ? Center(
                      child: Text(
                        value,
                        style: MyTextStyles.f16,
                      ),
                    )
                  : SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }
}
