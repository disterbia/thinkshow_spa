import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:wholesaler_partner/app/modules/customer_center/controller/customer_center_controller.dart';
import 'package:wholesaler_partner/app/widgets/loading_widget.dart';
import 'package:wholesaler_user/app/modules/faq/views/faq_view.dart';
import 'package:wholesaler_user/app/widgets/custom_appbar.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class CustomerCenterView extends GetView<CustomerCenterController> {
  CustomerCenterController ctr = Get.put(CustomerCenterController());
  bool isWithdrawPage;
  CustomerCenterView({required this.isWithdrawPage});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
          isBackEnable: true, title: isWithdrawPage ? '탈퇴 안내' : '고객센터'),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Obx(
              ()=>ctr.isLoading.value?LoadingWidget(): Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 탈퇴
              isWithdrawPage ? _withdrawAccountBuilder() : Container(),
              Text(
                '고객센터',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                    fontSize: 18),
              ),
              SizedBox(height: 15),
              Text(ctr.s.value.number!),
              SizedBox(height: 30),
              Text(
                "상담시간 안내",
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                    fontSize: 18),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('전화 상담'),
                  Expanded(
                      child: Center(
                        child: Text(ctr.s.value.telephoneConsultationTime!),
                      )),
                  GetPlatform.isMobile?IconButton(
                      onPressed: () {
                        UrlLauncher.launch("tel://${ctr.s.value.number}");
                      },
                      icon: Icon(Icons.call)):Container()
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('채팅 상담'),
                  Expanded(
                    child: Center(
                      child: Text(ctr.s.value.chatConsultationTime!),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      UrlLauncher.launch(ctr.s.value.kakaoLink!);
                    },
                    icon: Image.asset('assets/icons/ic_kakao_channel.png'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _withdrawAccountBuilder() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '탈퇴 요청 방법',
          textAlign: TextAlign.left,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w800, fontSize: 18),
        ),
        SizedBox(height: 15),
        Text('1. 탈퇴 요청'),
        SizedBox(height: 5),
        Text('2. 관리자 검토 및 잔여 포인트 정산 후 탈퇴 처리'),
        SizedBox(height: 5),
        ElevatedButton(
          onPressed: () => ctr.withdrawAccount(),
          child: Text('탈퇴 요청'),
        ),
        SizedBox(height: 30),
      ],
    );
  }
}
