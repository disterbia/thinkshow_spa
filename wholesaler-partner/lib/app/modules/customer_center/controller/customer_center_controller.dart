import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:wholesaler_partner/app/data/api_provider.dart';
import 'package:wholesaler_partner/app/models/service_center_model.dart';
import 'package:wholesaler_user/app/widgets/dialog.dart';
import 'package:wholesaler_user/app/widgets/two_buttons.dart';

class CustomerCenterController extends GetxController {
  // partner apiprovider
  pApiProvider _apiProvider = pApiProvider();
  Rx<ServiceCenterModel> s = ServiceCenterModel().obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getServiceCenterInfo();
  }
  Future<void> getServiceCenterInfo() async{
    isLoading.value=true;
    s.value=await _apiProvider.getServiceCenter();
    isLoading.value=false;
  }
  withdrawAccount() {
    // show dialog
    mDialog(
      title: '탈퇴 요청',
      subtitle: '탈퇴 요청하시겠습니까?',
      twoButtons: TwoButtons(
          leftBtnText: '취소',
          rightBtnText: '탈퇴',
          lBtnOnPressed: () {
            Get.back();
          },
          rBtnOnPressed: () {
            _apiProvider.withdrawAccount();
          }),
    );
  }
}
