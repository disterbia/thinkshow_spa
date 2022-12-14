import 'package:carousel_slider/carousel_controller.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/constants/enum.dart';
import 'package:wholesaler_user/app/data/api_provider.dart';
import 'package:wholesaler_user/app/models/product_model.dart';

class CarousalProductHorizontalController extends GetxController {
  CarouselController indicatorSliderController = CarouselController();
  RxInt sliderIndex = 0.obs;

  uApiProvider _apiProvider = uApiProvider();

  RxList<Product> products = <Product>[].obs;

  init(currentTab) async {
    print('CarousalProductHorizontalController init currentTab $currentTab');
    // products.clear();
    products.value = await _apiProvider.getAdProducts(currentTab);
  }
}
