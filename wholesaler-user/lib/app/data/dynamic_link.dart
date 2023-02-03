import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get/get.dart';
import 'package:uni_links/uni_links.dart';
import 'package:wholesaler_user/app/modules/product_detail/controller/product_detail_controller.dart';
import 'package:wholesaler_user/app/modules/product_detail/views/Product_detail_view.dart';
import 'package:wholesaler_user/app/widgets/snackbar.dart';

class DynamicLink {
  Future<void> setup() async {
    await _getInitialDynamicLink();
    _addListener();
  }

  Future<void> _getInitialDynamicLink() async {
    String? deepLink;
    Future.delayed(Duration(seconds: 3),()async{
      deepLink = await getInitialLink();
      if (deepLink != null) {
        PendingDynamicLinkData? dynamicLinkData = await FirebaseDynamicLinks
            .instance
            .getDynamicLink(Uri.parse(deepLink!));

        if (dynamicLinkData != null) {
          _redirectScreen(dynamicLinkData);
        }
      }
    });
  }

  void _addListener() {
    FirebaseDynamicLinks.instance.onLink.listen((
        PendingDynamicLinkData dynamicLinkData,
        ) {
      _redirectScreen(dynamicLinkData);
    }).onError((error) {
      mSnackbar(message: "!@!@!@$error");
    });
  }

  void _redirectScreen(PendingDynamicLinkData dynamicLinkData) {
    if (dynamicLinkData.link.queryParameters.containsKey('id')) {
      String id = dynamicLinkData.link.queryParameters['id']!;
      Get.delete<ProductDetailController>();
      Future.delayed(Duration(milliseconds: 200),()=>Get.to(()=>ProductDetailView(),arguments: int.parse(id)));
    }
  }

  Future<String> getShortLink(String id) async {
    String dynamicLinkPrefix = 'https://thinksmk.page.link';
    final dynamicLinkParams = DynamicLinkParameters(
      uriPrefix: dynamicLinkPrefix,
      link: Uri.parse('$dynamicLinkPrefix?id=$id'),
      androidParameters: const AndroidParameters(
        packageName: "com.thinksmk.user",
        minimumVersion: 0,
      ),
      iosParameters: const IOSParameters(
        bundleId: "com.thinksmk.user",
        minimumVersion: '0',
      ),
    );
    final dynamicLink =
    await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);
    print("=======${dynamicLink.shortUrl.toString()}");
    return dynamicLink.shortUrl.toString();
  }
}