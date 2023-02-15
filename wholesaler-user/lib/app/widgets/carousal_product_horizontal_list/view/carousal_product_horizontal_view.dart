import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/widgets/loading_widget.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/enum.dart';
import 'package:wholesaler_user/app/models/product_model.dart';
import 'package:wholesaler_user/app/models/product_number_model.dart';
import 'package:wholesaler_user/app/modules/product_detail/controller/product_detail_controller.dart';
import 'package:wholesaler_user/app/modules/product_detail/views/Product_detail_view.dart';
import 'package:wholesaler_user/app/widgets/carousal_product_horizontal_list/controller/carousal_product_horizontal_controller.dart';
import 'package:wholesaler_user/app/widgets/product/product_item_vertical_widget.dart';

class CarousalProductHorizontalView extends GetView<CarousalProductHorizontalController> {
  CarousalProductHorizontalController ctr = Get.put(CarousalProductHorizontalController());
  CarouselController? carouselController;
  int? index;

  CarousalProductHorizontalView(this.carouselController,this.index);
  RxList<Product>? products;
  RxInt? sliderIndex = 0.obs;
  int repeatCount=0;

  @override
  Widget build(BuildContext context) {

    switch (index){
      case 0:
        {
          products = ctr.adProducts;
          sliderIndex=ctr.sliderIndex1;
        }
        break;
      case 1:
        {
          products = ctr.exhibitProducts1;
          sliderIndex=ctr.sliderIndex1;
        }
        break;
      case 2:
        {
          products = ctr.exhibitProducts2;
          sliderIndex=ctr.sliderIndex2;
        }
        break;
      case 3:
        {
          products = ctr.exhibitProducts3;
          sliderIndex=ctr.sliderIndex3;
        }
        break;
      case 4:
        {
          products = ctr.exhibitProducts4;
          sliderIndex=ctr.sliderIndex4;
        }
        break;
    }

    List<Widget> productList=[];
    List<List<Widget>> rowList=[];

    for(var i=0;i<products!.length;i++){
        productList.add(Expanded(
          child: GestureDetector(
            onTap: () => Get.to(() => ProductDetailView(), arguments: products![i].id),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: ProductItemVertical(
                product: products![i],
              ),
            ),
          ),
        ));
    }

    int productLengthFloor=(productList.length/3).floor();
    int productLength =productList.length;



    for(var i =0; i<productLengthFloor;i++){
        rowList.add(productList.sublist(i*3,(i+1)*3));
        if(i == productLengthFloor-1 && productLength%3 != 0){
          List<Widget> temp = [];
          for(var j = 0; j<productLength%3;j++){
            temp.add(productList[productList.length-j-1]);
            if(productLength%3==1) {
            temp.add(Expanded(child: Container()));
            temp.add(Expanded(child: Container()));
            }else if(j==1&&productLength%3==2){
              temp.add(Expanded(child: Container()));
            }
        }
          rowList.add(temp);
        }
    }

    RxList<Widget> result=<Widget>[].obs;
    if(productList.length<=3){
      if(productLength%3==1) {
        productList.add(Expanded(child: Container()));
        productList.add(Expanded(child: Container()));
      }else if(productLength%3==2){
        productList.add(Expanded(child: Container()));
      }
      result.add(Row(mainAxisAlignment:MainAxisAlignment.spaceAround,children:productList));
    }else
    for(var rowProduct in rowList){
      result.add(Row(mainAxisAlignment:MainAxisAlignment.spaceAround,children:rowProduct));
    }

    return Column(children: [
       Obx(
        ()=>CarouselSlider(
            carouselController: carouselController,
            options: CarouselOptions(
                enableInfiniteScroll: false,padEnds: false,
                height: 250,
                autoPlay: false,
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  sliderIndex!.value = index;
                }),
            items:result
          ),
       ),

      Obx(
        () => _indicator(result),
      ),
    ]);
  }

  Widget _indicator(List<Widget> imgList) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: imgList.asMap().entries.map((entry) {
          return GestureDetector(
              // onTap: () => ctr.indicatorSliderController.animateToPage(entry.key),
              child: Container(
            width: 10.0,
            height: 10.0,
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
            decoration: BoxDecoration(shape: BoxShape.circle, color: MyColors.primary.withOpacity(sliderIndex == entry.key ? 0.9 : 0.4)),
          ));
        }).toList(),
      ),
    );
  }

// return Obx(
//   ()
//   {
//     if(ctr.isLoading.value) return SizedBox(height:240,child: LoadingWidget());
//     return
//     SizedBox(
//       height: 240,
//       child: ListView.separated(
//         scrollDirection: Axis.horizontal,
//         shrinkWrap: true,
//         itemCount: ctr.products.length,
//         separatorBuilder: (BuildContext context, int index) =>
//             SizedBox(width: 14),
//         itemBuilder: (BuildContext context, int index) {
//           return SizedBox(
//             width: 110,
//             child: ProductItemVertical(
//               product: ctr.products[index],
//               // productNumber: ProductNumber(
//               //   number: index + 1,
//               //   backgroundColor:
//               //   MyColors.numberColors.length > index
//               //       ? MyColors.numberColors[index]
//               //       : MyColors.numberColors[0],
//               // ),
//             ),
//           );
//         },
//       ),
//     );
//   },
// );
}
