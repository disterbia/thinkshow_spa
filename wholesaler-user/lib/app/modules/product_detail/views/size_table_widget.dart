import 'package:cross_scroll/cross_scroll.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/Constants/enum.dart';
import 'package:wholesaler_user/app/models/product_sizes_model.dart';
import 'package:wholesaler_user/app/modules/product_detail/controller/product_detail_controller.dart';

class SizeTableWidget extends StatelessWidget {
  ProductDetailController ctr = Get.put(ProductDetailController());
  SizeTableWidget();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Container(
        // width: 200,
        height: 170,
        child: CrossScroll(
          horizontalBar: CrossScrollBar(thickness: 4, hoverThickness: 4),
          verticalBar: CrossScrollBar(thickness: 0),
          child: DataTable(
            columns: DataColumnBuilder(),
            rows: <DataRow>[
              ...ctr.product.value.sizes!.map((size) {
                print('size');
                print(ctr.product.value.sizes!.length);
                return DataRow(
                  cells: DataCellBuilder(size),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  DataColumnBuilder() {
    return <DataColumn>[
      DataColumn(
        label: Text('CM'),
      ),
      if (ctr.product.value.sizes!
          .any((element) => element.shoulderCrossLength != null))
        DataColumn(
          label: Text(ProductSizeType.shoulder_cross_length),
        ),
      if (ctr.product.value.sizes!
          .any((element) => element.chestCrossLength != null))
        DataColumn(
          label: Text(ProductSizeType.chest_cross_length),
        ),
      if (ctr.product.value.sizes!.any((element) => element.armhole != null))
        DataColumn(
          label: Text(ProductSizeType.armhole),
        ),
      if (ctr.product.value.sizes!
          .any((element) => element.armStraightLength != null))
        DataColumn(
          label: Text(ProductSizeType.arm_straight_length),
        ),
      if (ctr.product.value.sizes!
          .any((element) => element.armCrossLength != null))
        DataColumn(
          label: Text(ProductSizeType.arm_cross_length),
        ),
      if (ctr.product.value.sizes!
          .any((element) => element.sleeveCrossLength != null))
        DataColumn(
          label: Text(ProductSizeType.sleeve_cross_length),
        ),
      if (ctr.product.value.sizes!
          .any((element) => element.bottomCrossLength != null))
        DataColumn(
          label: Text(ProductSizeType.bottom_cross_length),
        ),
      if (ctr.product.value.sizes!.any((element) => element.strap != null))
        DataColumn(
          label: Text(ProductSizeType.strap),
        ),
      if (ctr.product.value.sizes!
          .any((element) => element.totalEntryLength != null))
        DataColumn(
          label: Text(ProductSizeType.total_entry_length),
        ),
      if (ctr.product.value.sizes!
          .any((element) => element.waistCrossLength != null))
        DataColumn(
          label: Text(ProductSizeType.waist_cross_length),
        ),
      if (ctr.product.value.sizes!
          .any((element) => element.hipCrossLength != null))
        DataColumn(
          label: Text(ProductSizeType.hip_cross_length),
        ),
      if (ctr.product.value.sizes!
          .any((element) => element.bottomTopCrossLength != null))
        DataColumn(
          label: Text(ProductSizeType.bottom_top_cross_length),
        ),
      if (ctr.product.value.sizes!
          .any((element) => element.thighCrossLength != null))
        DataColumn(
          label: Text(ProductSizeType.thigh_cross_length),
        ),
      if (ctr.product.value.sizes!.any((element) => element.open != null))
        DataColumn(
          label: Text(ProductSizeType.open),
        ),
      if (ctr.product.value.sizes!.any((element) => element.lining != null))
        DataColumn(
          label: Text(ProductSizeType.lining),
        ),

      //추가
      if (ctr.product.value.sizes!
          .any((element) => element.entrance_cross_length != null))
        DataColumn(
          label: Text(ProductSizeType.entrance_cross_length),
        ),
      if (ctr.product.value.sizes!.any((element) => element.breadth != null))
        DataColumn(
          label: Text(ProductSizeType.breadth),
        ),
      if (ctr.product.value.sizes!.any((element) => element.diameter != null))
        DataColumn(
          label: Text(ProductSizeType.diameter),
        ),
      if (ctr.product.value.sizes!.any((element) => element.width != null))
        DataColumn(
          label: Text(ProductSizeType.width),
        ),
      if (ctr.product.value.sizes!.any((element) => element.height != null))
        DataColumn(
          label: Text(ProductSizeType.height),
        ),
      if (ctr.product.value.sizes!
          .any((element) => element.handle_height != null))
        DataColumn(
          label: Text(ProductSizeType.handle_height),
        ),
      if (ctr.product.value.sizes!
          .any((element) => element.handle_length != null))
        DataColumn(
          label: Text(ProductSizeType.handle_length),
        ),
      if (ctr.product.value.sizes!
          .any((element) => element.front_heel_height != null))
        DataColumn(
          label: Text(ProductSizeType.front_heel_height),
        ),
      if (ctr.product.value.sizes!
          .any((element) => element.back_heel_height != null))
        DataColumn(
          label: Text(ProductSizeType.back_heel_height),
        ),
      if (ctr.product.value.sizes!
          .any((element) => element.calf_cross_length != null))
        DataColumn(
          label: Text(ProductSizeType.calf_cross_length),
        ),
      if (ctr.product.value.sizes!.any((element) => element.weight != null))
        DataColumn(
          label: Text(ProductSizeType.weight),
        ),
      if (ctr.product.value.sizes!.any((element) => element.foot_width != null))
        DataColumn(
          label: Text(ProductSizeType.foot_width),
        ),
    ];
  }

  DataCellBuilder(ProductSizeModel size) {
    return <DataCell>[
      DataCell(
        Text('${size.size}'),
      ),
      if (size.shoulderCrossLength != null)
        DataCell(
          Text(size.shoulderCrossLength.toString()),
        ),
      if (size.chestCrossLength != null)
        DataCell(
          Text(size.chestCrossLength.toString()),
        ),
      if (size.armhole != null)
        DataCell(
          Text(size.armhole.toString()),
        ),
      if (size.armStraightLength != null)
        DataCell(
          Text(size.armStraightLength.toString()),
        ),
      if (size.armCrossLength != null)
        DataCell(
          Text(size.armCrossLength.toString()),
        ),
      if (size.sleeveCrossLength != null)
        DataCell(
          Text(size.sleeveCrossLength.toString()),
        ),
      if (size.bottomCrossLength != null)
        DataCell(
          Text(size.bottomCrossLength.toString()),
        ),
      if (size.strap != null)
        DataCell(
          Text(size.strap.toString()),
        ),
      if (size.totalEntryLength != null)
        DataCell(
          Text(size.totalEntryLength.toString()),
        ),
      if (size.waistCrossLength != null)
        DataCell(
          Text(size.waistCrossLength.toString()),
        ),
      if (size.hipCrossLength != null)
        DataCell(
          Text(size.hipCrossLength.toString()),
        ),
      if (size.bottomTopCrossLength != null)
        DataCell(
          Text(size.bottomTopCrossLength.toString()),
        ),
      if (size.thighCrossLength != null)
        DataCell(
          Text(size.thighCrossLength.toString()),
        ),
      if (size.open != null)
        DataCell(
          Text(size.open.toString()),
        ),
      if (size.lining != null)
        DataCell(
          Text(size.lining.toString()),
        ),
      if (size.entrance_cross_length != null)
        DataCell(
          Text(size.entrance_cross_length.toString()),
        ),
      if (size.breadth != null)
        DataCell(
          Text(size.breadth.toString()),
        ),
      if (size.diameter != null)
        DataCell(
          Text(size.diameter.toString()),
        ),
      if (size.width != null)
        DataCell(
          Text(size.width.toString()),
        ),
      if (size.height != null)
        DataCell(
          Text(size.height.toString()),
        ),
      if (size.handle_height != null)
        DataCell(
          Text(size.handle_height.toString()),
        ),
      if (size.handle_length != null)
        DataCell(
          Text(size.handle_length.toString()),
        ),
      if (size.front_heel_height != null)
        DataCell(
          Text(size.front_heel_height.toString()),
        ),
      if (size.back_heel_height != null)
        DataCell(
          Text(size.back_heel_height.toString()),
        ),
      if (size.calf_cross_length != null)
        DataCell(
          Text(size.calf_cross_length.toString()),
        ),
      if (size.weight != null)
        DataCell(
          Text(size.weight.toString()),
        ),
      if (size.foot_width != null)
        DataCell(
          Text(size.foot_width.toString()),
        ),
    ];
  }
}
