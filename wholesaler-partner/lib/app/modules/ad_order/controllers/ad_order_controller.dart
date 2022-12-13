import 'package:get/get.dart';
import 'package:wholesaler_partner/app/data/api_provider.dart';
import 'package:wholesaler_partner/app/models/ad_order_model/ad_order_model.dart';

class AdOrderController extends GetxController {
  Rx<AdOrderModel> adOrderModel = AdOrderModel(cost: -1).obs;
  pApiProvider _apiProvider = pApiProvider();
  @override
  Future<void> onInit() async {
    super.onInit();

    // print value of Get.arguments
    print('sajad Get.arguments: ${Get.arguments}');

    adOrderModel.value = await _apiProvider.getAdOrder(advertisementId: Get.arguments);
  }
}
