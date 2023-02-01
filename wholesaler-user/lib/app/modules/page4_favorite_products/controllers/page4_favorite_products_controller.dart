import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wholesaler_user/app/data/api_provider.dart';
import 'package:wholesaler_user/app/data/cache_provider.dart';
import 'package:wholesaler_user/app/models/product_model.dart';
import 'package:wholesaler_user/app/widgets/snackbar.dart';
import 'package:wholesaler_user/app/constants/functions.dart';

class Page4Favorite_RecentlyViewedController extends GetxController {
  bool isRecentSeenProduct = false;
  uApiProvider _apiProvider = uApiProvider();
  CacheProvider _cacheProvider = CacheProvider();
  RxBool isLoading = false.obs;

  RxList<Product> products = <Product>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  updateProducts() async {
    isLoading.value = true;

    bool result = await uApiProvider().chekToken();

    if (!result) {
      print('logout');
      mSnackbar(message: '로그인 세션이 만료되었습니다.');
      mFuctions.userLogout();
    } else {
      products.clear();

      if (isRecentSeenProduct) {
        // Recently Seen Products
        List productIds = _cacheProvider.getAllRecentlyViewedProducts();
        // print('productIds ${productIds}');
        if (productIds.isNotEmpty) {
          products.value =
              await _apiProvider.getRecentlySeenProducts(productIds);
        }
      } else {
        // Favorite Products
        products.value = await _apiProvider.getFavoriteProducts();
      }
      isLoading.value = false;
    }
  }

  getRecentlyProducts() async {
    isLoading.value = true;
    bool result = await uApiProvider().chekToken();

    if (!result) {
      print('logout');
      mSnackbar(message: '로그인 세션이 만료되었습니다.');
      mFuctions.userLogout();
    } else {
      products.clear();

      List productIds = _cacheProvider.getAllRecentlyViewedProducts();
      // print('productIds ${productIds}');
      if (productIds.isNotEmpty) {
        products.value = await _apiProvider.getRecentlySeenProducts(productIds);
      }
      isLoading.value = false;
    }
  }
}
