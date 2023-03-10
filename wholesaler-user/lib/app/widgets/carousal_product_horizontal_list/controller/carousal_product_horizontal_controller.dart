import 'package:carousel_slider/carousel_controller.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/constants/enum.dart';
import 'package:wholesaler_user/app/data/api_provider.dart';
import 'package:wholesaler_user/app/models/product_model.dart';

class CarousalProductHorizontalController extends GetxController {
  RxBool isLoading = false.obs;
  uApiProvider _apiProvider = uApiProvider();
  CarouselController indicatorSliderController1 = CarouselController();
  CarouselController indicatorSliderController2 = CarouselController();
  CarouselController indicatorSliderController3 = CarouselController();
  CarouselController indicatorSliderController4 = CarouselController();
  RxInt sliderIndex1 = 0.obs;
  RxInt sliderIndex2 = 0.obs;
  RxInt sliderIndex3 = 0.obs;
  RxInt sliderIndex4 = 0.obs;
  RxList<Product> adProducts = <Product>[].obs;
  RxList<Product> exhibitProducts1 = <Product>[].obs;
  RxList<Product> exhibitProducts2 = <Product>[].obs;
  RxList<Product> exhibitProducts3 = <Product>[].obs;
  RxList<Product> exhibitProducts4 = <Product>[].obs;
  RxString exhibitTitle1="".obs;
  RxString exhibitTitle2="".obs;
  RxString exhibitTitle3="".obs;
  RxString exhibitTitle4="".obs;
  RxString beltImage="".obs;


Future<void> init() async {
  isLoading.value=true;
  sliderIndex1.value=0;
  sliderIndex2.value=0;
  sliderIndex3.value=0;
  sliderIndex4.value=0;


  Map<String,dynamic> result1 =  await _apiProvider.getExhibitProducts(1);
  Map<String,dynamic> result2 =  await _apiProvider.getExhibitProducts(2);
  Map<String,dynamic> result3 =  await _apiProvider.getExhibitProducts(3);
  Map<String,dynamic> result4 =  await _apiProvider.getExhibitProducts(4);
  adProducts.value = await _apiProvider.getAdProducts(UserHomeTabs.home);
  beltImage.value = await _apiProvider.getBeltImage();

  exhibitProducts1.value = result1["products"] as List<Product>;
  exhibitProducts2.value = result2["products"] as List<Product>;
  exhibitProducts3.value = result3["products"] as List<Product>;
  exhibitProducts4.value =result4["products"] as List<Product>;

  exhibitTitle1.value= result1["title"] as String;
  exhibitTitle2.value=result2["title"] as String;
  exhibitTitle3.value=result3["title"] as String;
  exhibitTitle4.value=result4["title"] as String;

  isLoading.value=false;
}
}
