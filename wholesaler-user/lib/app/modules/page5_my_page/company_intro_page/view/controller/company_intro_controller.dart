import 'package:get/get.dart';
import 'package:wholesaler_user/app/data/api_provider.dart';
import 'package:wholesaler_user/app/models/company_info_model.dart';

class CompanyIntroController extends GetxController {
  uApiProvider p = uApiProvider();
  Rx<CompanyInfoModel> c = CompanyInfoModel().obs;
  RxBool isLoading=false.obs;
  @override
  void onInit() async{
    isLoading.value=true;
    c.value =await p.getCompanyInfo();
    isLoading.value=false;
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
