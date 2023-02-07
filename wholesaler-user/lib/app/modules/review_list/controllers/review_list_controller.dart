import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wholesaler_partner/app/data/api_provider.dart';
import 'package:wholesaler_user/app/constants/variables.dart';
import 'package:wholesaler_user/app/models/review.dart';

import '../../../constants/enum.dart';
import '../../../models/product_model.dart';
import '../../../models/review_model.dart';
import '../../../models/store_model.dart';
import '../../../utils/utils.dart';

class ReviewListController extends GetxController {
  pApiProvider apiProvider = pApiProvider();
  RxBool isLoading = false.obs;
  RxList<ReviewModel> reviewsResponse = <ReviewModel>[].obs;
  List<Review> reviews = [];
  String maxPrice = '';

  @override
  void onInit() async {
    super.onInit();
    await getReviews();
  }

  Future<void> getReviews() async {
    isLoading.value = true;

    await apiProvider.getStoreReviews().then((response) {
      dynamic dynamicList = response;
      for (var i = 0; i < dynamicList.length; i++) {
        reviews.add(Review(
            id: dynamicList[i]['id'],
            writer: dynamicList[i]['writer'],
            createdAt: dynamicList[i]['created_at'],
            images: dynamicList[i]['review_image_url']?.cast<String>(),
            content: dynamicList[i]['content'],
            rating: double.parse(dynamicList[i]['star'].toString()),
            ratingType: ProductRatingType.star,
            category_color_name: dynamicList[i]['category_color_name'],
            category_fit_name: dynamicList[i]['category_fit_name'],
            category_quality_name: dynamicList[i]['category_quality_name'],
            date: DateFormat("yyyy-MM-dd").parse(dynamicList[i]['created_at']),
            product: Product(
                title: dynamicList[i]['product_info']['name'],
                store: Store(id: -1),
                OLD_option: dynamicList[i]['product_info']['option_name'],
                id: dynamicList[i]['id'],
                imgUrl: dynamicList[i]['product_info']['thumbnail_image_url'],
                price: dynamicList[i]['product_info']['price'],
                normalPrice: dynamicList[i]['product_info']['normal_price'],
                priceDiscountPercent: 0,
                quantity: (dynamicList[i]['product_info']['qty'] as int).obs,
                selectedOptionAddPrice: dynamicList[i]['product_info']
                    ['add_price'])));
      }

      isLoading.value = false;
      // print('hello world ${reviews}');
    });
  }
}
