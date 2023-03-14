import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/widgets/loading_widget.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/modules/page5_my_page/company_intro_page/view/controller/company_intro_controller.dart';
import 'package:wholesaler_user/app/widgets/custom_appbar.dart';

class CompanyIntroPageView extends GetView<CompanyIntroController> {
  CompanyIntroController ctr = Get.put(CompanyIntroController());
  CompanyIntroPageView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(isBackEnable: true, title: '회사 소개'),
      body: Obx(

            ()=>ctr.isLoading.value?LoadingWidget(): SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 상호
                SizedBox(height: 10),
                _titleBuilder('상호'),
                SizedBox(height: 10),
                _contentBuilder(ctr.c.value.name!),
                SizedBox(height: 10),
                Divider(),
                // 대표
                SizedBox(height: 10),
                _titleBuilder('대표'),
                SizedBox(height: 10),
                _contentBuilder(ctr.c.value.owner!),
                SizedBox(height: 10),
                Divider(),
                // 주소
                SizedBox(height: 10),
                _titleBuilder('주소'),
                SizedBox(height: 10),
                _contentBuilder(ctr.c.value.addr!),
                SizedBox(height: 10),
                Divider(),
                // 사업자 등록번호, 158-86-02714
                SizedBox(height: 10),
                _titleBuilder('사업자 등록번호'),
                SizedBox(height: 10),
                _contentBuilder(ctr.c.value.companyNum!),
                SizedBox(height: 10),
                Divider(),
                // 통신판태등록번호, 제 2022-서울중구-1366 호
                SizedBox(height: 10),
                _titleBuilder('통신판매업 등록번호'),
                SizedBox(height: 10),
                _contentBuilder(ctr.c.value.companyLawNum!),
                SizedBox(height: 10),
                Divider(),
                // 유선번호, 010-4453-3289
                SizedBox(height: 10),
                _titleBuilder('유선번호'),
                SizedBox(height: 10),
                _contentBuilder(ctr.c.value.callNum!),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _titleBuilder(String title) {
    return Text(
      title,
      style: MyTextStyles.f12.copyWith(color: MyColors.black3),
    );
  }

  Widget _contentBuilder(String content) {
    return Text(
      content,
      style: MyTextStyles.f14.copyWith(color: MyColors.black3),
    );
  }
}
