import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/data/api_provider.dart';
import 'package:wholesaler_user/app/models/review.dart';
import 'package:wholesaler_user/app/models/review_category.dart';
import 'package:wholesaler_user/app/models/review_info_model.dart';
import 'package:wholesaler_user/app/models/status_model.dart';
import 'package:wholesaler_user/app/modules/product_detail/controller/product_detail_controller.dart';
import 'package:wholesaler_user/app/widgets/snackbar.dart';

class Tab2ReviewProductDetailController extends GetxController {
  uApiProvider _apiProvider = uApiProvider();

  RxList<Review> reviews = <Review>[].obs;
  RxList<Review> photoReviews = <Review>[].obs;

  Rx<ReviewInfoModel> reviewInfoModel = ReviewInfoModel().obs;

  late RxList<int> sliderIndex;
  late RxList<CarouselController> indicatorSliderController;

  @override
  Future<void> onInit() async {
    super.onInit();

    int productId = Get.arguments ?? -1;

    //print('productId in Tab2ReviewProductDetailController $productId');
    // reviews.value = await _apiProvider.getProductReviews(
    //     productId: productId, offset: 0, limit: 20);
    await getProductReviews(productId: productId);
    await getProductReviewInfo(productId: productId);
    await getProductReviewOnlyPhoto(productId: productId);
  }

  getProductReviews({required int productId}) async {
    // print(productId);
    reviews.value = await _apiProvider.getProductReviews(
        productId: productId, offset: 0, limit: 20);

    sliderIndex = List.filled(reviews.length, 0).obs;
    
    indicatorSliderController =
        List.filled(reviews.length, CarouselController()).obs;
  }

  deleteReviewPressed(Review review) async {
    StatusModel status = await _apiProvider.deleteReview(reviewId: review.id);
    if (status.statusCode == 200) {
      getProductReviews(productId: Get.arguments);
      mSnackbar(message: '삭제 되었습니다.');
    } else {
      mSnackbar(message: '오류: ' + status.message);
    }
  }

  getProductReviewInfo({required int productId}) async {
    var json = await _apiProvider.getProductReviewInfo(productId: productId);

    if (json['avg_star'] != null) {
      reviewInfoModel.value = ReviewInfoModel.fromJson(json);
      reviewInfoModel.value.reviewCategoryModel!['quality_info'] =
          ReviewCategoryModel(
              id: json['quality_info']['id'],
              name: json['quality_info']['name'],
              percent: json['quality_info']['percent']);

      reviewInfoModel.value.reviewCategoryModel!['color_info'] =
          ReviewCategoryModel(
              id: json['color_info']['id'],
              name: json['color_info']['name'],
              percent: json['color_info']['percent']);

      reviewInfoModel.value.reviewCategoryModel!['fit_info'] =
          ReviewCategoryModel(
              id: json['fit_info']['id'],
              name: json['fit_info']['name'],
              percent: json['fit_info']['percent']);
    }
  }

  getProductReviewOnlyPhoto({required int productId}) async {
    photoReviews.value = await _apiProvider.getProductReviewOnlyPhoto(
        productId: productId, offset: 0, limit: 20);
  }
}
