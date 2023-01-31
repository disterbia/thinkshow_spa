import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/constants/variables.dart';
import 'package:wholesaler_user/app/data/api_provider.dart';
import 'package:wholesaler_user/app/data/cache_provider.dart';
import 'package:wholesaler_user/app/models/cart1_orders_model/cart1_orders_model.dart';
import 'package:wholesaler_user/app/models/cart1_orders_model/order.dart';
import 'package:wholesaler_user/app/models/cart_model.dart';
import 'package:wholesaler_user/app/models/checkout_model/checkout_model.dart';
import 'package:wholesaler_user/app/models/product_model.dart';
import 'package:wholesaler_user/app/modules/auth/user_login_page/views/user_login_view.dart';
import 'package:wholesaler_user/app/modules/cart/views/cart2_payment_view.dart';
import 'package:wholesaler_user/app/widgets/dialog.dart';
import 'package:wholesaler_user/app/widgets/snackbar.dart';
import 'package:wholesaler_user/app/widgets/two_buttons.dart';
import 'package:wholesaler_user/app/constants/functions.dart';

class Cart1ShoppingBasketController extends GetxController {
  uApiProvider _apiProvider = uApiProvider();

  RxBool isSelectAllChecked = false.obs;
  RxList<Cart> cartItems = <Cart>[].obs;
  RxInt totalPaymentPrice = 0.obs;
  RxBool isLoading = false.obs;

  init() async {
    Future.delayed(Duration.zero,()=> isLoading.value = true);

    if (CacheProvider().getToken().isNotEmpty) {
      // WidgetsBinding.instance.addPostFrameCallback((_) {
      //   Get.to(() => User_LoginPageView());
      // });
      if (MyVars.isUserProject()) {
        bool result = await uApiProvider().chekToken();

        if (!result) {
          print('logout');
          mSnackbar(message: '로그인 세션이 만료되었습니다.');
          mFuctions.userLogout();
        } else {
          cartItems.value = await _apiProvider.getCart1ShoppintBasket();
          updateTotalPaymentPrice();
        }
      }
    } else {
      mFuctions.userLogout();
    }
    Future.delayed(Duration.zero,()=> isLoading.value = false);
  }

  /// returns total number of products in the cart
  int getNumberProducts() {
    int totalProductLength = 0;
    for (Cart cart in cartItems) {
      totalProductLength += cart.products.length;
    }
    return totalProductLength;
  }

  SelectAllCheckboxOnChanged(bool value) {
    isSelectAllChecked.value = value;
    for (Cart cart in cartItems) {
      for (Product product in cart.products) {
        product.isCheckboxSelected!.value = value;
      }
    }
    updateTotalPaymentPrice();
  }

  deleteSelectedProducts() {
    mDialog(
      title: '선택삭제',
      subtitle: '선택하셨던 상품을 삭제하시겠습니까?',
      twoButtons: TwoButtons(
        leftBtnText: '취소',
        rightBtnText: '삭제',
        lBtnOnPressed: () {
          Get.back();
        },
        rBtnOnPressed: () => callDeleteSelectedProductsAPI(),
      ),
    );
  }

  deleteAllProducts() {
    mDialog(
      title: '전체삭제',
      subtitle: '전체 상품을 삭제하시겠습니까?',
      twoButtons: TwoButtons(
        leftBtnText: '취소',
        rightBtnText: '삭제',
        lBtnOnPressed: () {
          Get.back();
        },
        rBtnOnPressed: () {
          callDeleteSelectedProductsAPI(isDeleteAll: true);
          SelectAllCheckboxOnChanged(false);
        },
      ),
    );
  }

  callDeleteSelectedProductsAPI({bool isDeleteAll = false,bool isIcon = false, int? cartId}) async {
    List<int> cart_id_list = [];

    for (Cart cart in cartItems) {
      for (Product product in cart.products) {
        if (product.isCheckboxSelected!.value || isDeleteAll) {
          cart_id_list.add(product.cartId!);
        }
        if (isIcon) {
          cart_id_list.add(cartId!);
          isIcon=false;
        }
      }
    }

    bool isSuccess = await _apiProvider.deleteProductsFromCart(cart_id_list);

    if (isSuccess) {
      //전체선택 해제 필요

      mSnackbar(message: '정상적으로 삭제되었습니다.');
      // update the cart items
      cartItems.value = await _apiProvider.getCart1ShoppintBasket();
      updateTotalPaymentPrice();
      Get.back();
    }
  }

  int getTotalSelectedProducts() {
    int totalSelectedProducts = 0;
    for (Cart cart in cartItems) {
      for (Product product in cart.products) {
        if (product.isCheckboxSelected!.value) {
          totalSelectedProducts += 1;
        }
      }
    }
    return totalSelectedProducts;
  }

  updateTotalPaymentPrice() {
    int totalSelectedPrice = 0;
    for (Cart cart in cartItems) {
      for (Product product in cart.products) {
        if (product.isCheckboxSelected!.value) {
          // calculate total price of selected products
          totalSelectedPrice +=
              (product.price! + product.selectedOptionAddPrice!) *
                  product.quantity!.value;
        }
      }
    }
    totalPaymentPrice.value = totalSelectedPrice;
  }

  postOrderCheckout() async {
    List<Order> orders = [];
    Cart1OrdersModel cart1OrdersModel = Cart1OrdersModel();

    for (Cart cart in cartItems) {
      for (Product product in cart.products) {
        if (product.isCheckboxSelected!.value) {
          Order order = Order();
          order.productOptionId = product.selectedOptionId;
          order.qty = product.quantity!.value;
          orders.add(order);
        }
      }
    }

    cart1OrdersModel.orders = orders;

    Cart2CheckoutModel cart2checkoutModel =
        await _apiProvider.postOrderCheckout(cart1OrdersModel);

    Get.to(() => Cart2PaymentView(cart2checkoutModel));
  }

  quantityPlusMinusOnPressed(
      {required bool value, required int cartId, required int qty}) async {
    int newQty = value ? qty + 1 : qty - 1;
    bool isSuccess =
        await _apiProvider.changeQuantityInBasket(qty: newQty, cartId: cartId);

    if (isSuccess) {
      init();
      // for (Cart cart in cartItems) {
      //   for (Product product in cart.products) {
      //     if (product.cartId == cartId) {
      //       print('found product with cartId: $cartId');
      //       product.quantity!.value = newQty;
      //     }
      //   }
      // }
    }
  }
}
