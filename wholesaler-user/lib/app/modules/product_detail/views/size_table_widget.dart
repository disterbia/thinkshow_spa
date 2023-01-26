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
    initDataCell();
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
                //한줄이다 이건

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

  initDataCell() {
    for (int k = 0; k < ctr.product.value.sizes!.length; k++) {
      if (ctr.product.value.sizes![k].shoulderCrossLength != null &&
          ctr.product.value.sizes![k].shoulderCrossLength != '') {
        for (int j = 0; j < ctr.product.value.sizes!.length; j++) {
          if (j == k) continue;
          ctr.product.value.sizes![j].shoulderCrossLength = '';
        }
      }

      if (ctr.product.value.sizes![k].chestCrossLength != null &&
          ctr.product.value.sizes![k].chestCrossLength != '') {
        for (int j = 0; j < ctr.product.value.sizes!.length; j++) {
          if (j == k) continue;
          ctr.product.value.sizes![j].chestCrossLength = '';
        }
      }

      if (ctr.product.value.sizes![k].armhole != null &&
          ctr.product.value.sizes![k].armhole != '') {
        for (int j = 0; j < ctr.product.value.sizes!.length; j++) {
          if (j == k) continue;
          ctr.product.value.sizes![j].armhole = '';
        }
      }

      if (ctr.product.value.sizes![k].armStraightLength != null &&
          ctr.product.value.sizes![k].armStraightLength != '') {
        for (int j = 0; j < ctr.product.value.sizes!.length; j++) {
          if (j == k) continue;
          ctr.product.value.sizes![j].armStraightLength = '';
        }
      }

      if (ctr.product.value.sizes![k].armCrossLength != null &&
          ctr.product.value.sizes![k].armCrossLength != '') {
        for (int j = 0; j < ctr.product.value.sizes!.length; j++) {
          if (j == k) continue;
          ctr.product.value.sizes![j].armCrossLength = '';
        }
      }

      if (ctr.product.value.sizes![k].sleeveCrossLength != null &&
          ctr.product.value.sizes![k].sleeveCrossLength != '') {
        for (int j = 0; j < ctr.product.value.sizes!.length; j++) {
          if (j == k) continue;
          ctr.product.value.sizes![j].sleeveCrossLength = '';
        }
      }

      if (ctr.product.value.sizes![k].bottomCrossLength != null &&
          ctr.product.value.sizes![k].bottomCrossLength != '') {
        for (int j = 0; j < ctr.product.value.sizes!.length; j++) {
          if (j == k) continue;
          ctr.product.value.sizes![j].bottomCrossLength = '';
        }
      }

      if (ctr.product.value.sizes![k].strap != null &&
          ctr.product.value.sizes![k].strap != '') {
        for (int j = 0; j < ctr.product.value.sizes!.length; j++) {
          if (j == k) continue;
          ctr.product.value.sizes![j].strap = '';
        }
      }

      if (ctr.product.value.sizes![k].totalEntryLength != null &&
          ctr.product.value.sizes![k].totalEntryLength != '') {
        for (int j = 0; j < ctr.product.value.sizes!.length; j++) {
          if (j == k) continue;
          ctr.product.value.sizes![j].totalEntryLength = '';
        }
      }

      if (ctr.product.value.sizes![k].waistCrossLength != null &&
          ctr.product.value.sizes![k].waistCrossLength != '') {
        for (int j = 0; j < ctr.product.value.sizes!.length; j++) {
          if (j == k) continue;
          ctr.product.value.sizes![j].waistCrossLength = '';
        }
      }

      if (ctr.product.value.sizes![k].hipCrossLength != null &&
          ctr.product.value.sizes![k].hipCrossLength != '') {
        for (int j = 0; j < ctr.product.value.sizes!.length; j++) {
          if (j == k) continue;
          ctr.product.value.sizes![j].hipCrossLength = '';
        }
      }

      if (ctr.product.value.sizes![k].bottomTopCrossLength != null &&
          ctr.product.value.sizes![k].bottomTopCrossLength != '') {
        for (int j = 0; j < ctr.product.value.sizes!.length; j++) {
          if (j == k) continue;
          ctr.product.value.sizes![j].bottomTopCrossLength = '';
        }
      }

      if (ctr.product.value.sizes![k].thighCrossLength != null &&
          ctr.product.value.sizes![k].thighCrossLength != '') {
        for (int j = 0; j < ctr.product.value.sizes!.length; j++) {
          if (j == k) continue;
          ctr.product.value.sizes![j].thighCrossLength = '';
        }
      }

      if (ctr.product.value.sizes![k].open != null &&
          ctr.product.value.sizes![k].open != '') {
        for (int j = 0; j < ctr.product.value.sizes!.length; j++) {
          if (j == k) continue;
          ctr.product.value.sizes![j].open = '';
        }
      }

      if (ctr.product.value.sizes![k].lining != null &&
          ctr.product.value.sizes![k].lining != '') {
        for (int j = 0; j < ctr.product.value.sizes!.length; j++) {
          if (j == k) continue;
          ctr.product.value.sizes![j].lining = '';
        }
      }

      if (ctr.product.value.sizes![k].entrance_cross_length != null &&
          ctr.product.value.sizes![k].entrance_cross_length != '') {
        for (int j = 0; j < ctr.product.value.sizes!.length; j++) {
          if (j == k) continue;
          ctr.product.value.sizes![j].entrance_cross_length = '';
        }
      }

      if (ctr.product.value.sizes![k].breadth != null &&
          ctr.product.value.sizes![k].breadth != '') {
        for (int j = 0; j < ctr.product.value.sizes!.length; j++) {
          if (j == k) continue;
          ctr.product.value.sizes![j].breadth = '';
        }
      }

      if (ctr.product.value.sizes![k].diameter != null &&
          ctr.product.value.sizes![k].diameter != '') {
        for (int j = 0; j < ctr.product.value.sizes!.length; j++) {
          if (j == k) continue;
          ctr.product.value.sizes![j].diameter = '';
        }
      }

      if (ctr.product.value.sizes![k].width != null &&
          ctr.product.value.sizes![k].width != '') {
        for (int j = 0; j < ctr.product.value.sizes!.length; j++) {
          if (j == k) continue;
          ctr.product.value.sizes![j].width = '';
        }
      }

      if (ctr.product.value.sizes![k].height != null &&
          ctr.product.value.sizes![k].height != '') {
        for (int j = 0; j < ctr.product.value.sizes!.length; j++) {
          if (j == k) continue;
          ctr.product.value.sizes![j].height = '';
        }
      }

      if (ctr.product.value.sizes![k].handle_height != null &&
          ctr.product.value.sizes![k].handle_height != '') {
        for (int j = 0; j < ctr.product.value.sizes!.length; j++) {
          if (j == k) continue;
          ctr.product.value.sizes![j].handle_height = '';
        }
      }

      if (ctr.product.value.sizes![k].handle_length != null &&
          ctr.product.value.sizes![k].handle_length != '') {
        for (int j = 0; j < ctr.product.value.sizes!.length; j++) {
          if (j == k) continue;
          ctr.product.value.sizes![j].handle_length = '';
        }
      }

      if (ctr.product.value.sizes![k].front_heel_height != null &&
          ctr.product.value.sizes![k].front_heel_height != '') {
        for (int j = 0; j < ctr.product.value.sizes!.length; j++) {
          if (j == k) continue;
          ctr.product.value.sizes![j].front_heel_height = '';
        }
      }

      if (ctr.product.value.sizes![k].back_heel_height != null &&
          ctr.product.value.sizes![k].back_heel_height != '') {
        for (int j = 0; j < ctr.product.value.sizes!.length; j++) {
          if (j == k) continue;
          ctr.product.value.sizes![j].back_heel_height = '';
        }
      }

      if (ctr.product.value.sizes![k].calf_cross_length != null &&
          ctr.product.value.sizes![k].calf_cross_length != '') {
        for (int j = 0; j < ctr.product.value.sizes!.length; j++) {
          if (j == k) continue;
          ctr.product.value.sizes![j].calf_cross_length = '';
        }
      }

      if (ctr.product.value.sizes![k].weight != null &&
          ctr.product.value.sizes![k].weight != '') {
        for (int j = 0; j < ctr.product.value.sizes!.length; j++) {
          if (j == k) continue;
          ctr.product.value.sizes![j].weight = '';
        }
      }

      if (ctr.product.value.sizes![k].foot_width != null &&
          ctr.product.value.sizes![k].foot_width != '') {
        for (int j = 0; j < ctr.product.value.sizes!.length; j++) {
          if (j == k) continue;
          ctr.product.value.sizes![j].foot_width = '';
        }
      }
    }
  }

  DataColumnBuilder() {
    return <DataColumn>[
      DataColumn(
        label: Text('Size'),
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
        Center(child: Text('${size.size}')),
      ),
      if (size.shoulderCrossLength != null)
        DataCell(
          Center(child: Text(size.shoulderCrossLength.toString())),
        ),
      if (size.chestCrossLength != null)
        DataCell(
          Center(child: Text(size.chestCrossLength.toString())),
        ),
      if (size.armhole != null)
        DataCell(
          Center(child: Text(size.armhole.toString())),
        ),
      if (size.armStraightLength != null)
        DataCell(
          Center(child: Text(size.armStraightLength.toString())),
        ),
      if (size.armCrossLength != null)
        DataCell(
          Center(child: Text(size.armCrossLength.toString())),
        ),
      if (size.sleeveCrossLength != null)
        DataCell(
          Center(child: Text(size.sleeveCrossLength.toString())),
        ),
      if (size.bottomCrossLength != null)
        DataCell(
          Center(child: Text(size.bottomCrossLength.toString())),
        ),
      if (size.strap != null)
        DataCell(
          Center(child: Text(size.strap.toString())),
        ),
      if (size.totalEntryLength != null)
        DataCell(
          Center(child: Text(size.totalEntryLength.toString())),
        ),
      if (size.waistCrossLength != null)
        DataCell(
          Center(child: Text(size.waistCrossLength.toString())),
        ),
      if (size.hipCrossLength != null)
        DataCell(
          Center(child: Text(size.hipCrossLength.toString())),
        ),
      if (size.bottomTopCrossLength != null)
        DataCell(
          Center(child: Text(size.bottomTopCrossLength.toString())),
        ),
      if (size.thighCrossLength != null)
        DataCell(
          Center(child: Text(size.thighCrossLength.toString())),
        ),
      if (size.open != null)
        DataCell(
          Center(child: Text(size.open.toString())),
        ),
      if (size.lining != null)
        DataCell(
          Center(child: Text(size.lining.toString())),
        ),
      if (size.entrance_cross_length != null)
        DataCell(
          Center(child: Text(size.entrance_cross_length.toString())),
        ),
      if (size.breadth != null)
        DataCell(
          Center(child: Text(size.breadth.toString())),
        ),
      if (size.diameter != null)
        DataCell(
          Center(child: Text(size.diameter.toString())),
        ),
      if (size.width != null)
        DataCell(
          Center(child: Text(size.width.toString())),
        ),
      if (size.height != null)
        DataCell(
          Center(child: Text(size.height.toString())),
        ),
      if (size.handle_height != null)
        DataCell(
          Center(child: Text(size.handle_height.toString())),
        ),
      if (size.handle_length != null)
        DataCell(
          Center(child: Text(size.handle_length.toString())),
        ),
      if (size.front_heel_height != null)
        DataCell(
          Center(child: Text(size.front_heel_height.toString())),
        ),
      if (size.back_heel_height != null)
        DataCell(
          Center(child: Text(size.back_heel_height.toString())),
        ),
      if (size.calf_cross_length != null)
        DataCell(
          Center(child: Text(size.calf_cross_length.toString())),
        ),
      if (size.weight != null)
        DataCell(
          Center(child: Text(size.weight.toString())),
        ),
      if (size.foot_width != null)
        DataCell(
          Center(child: Text(size.foot_width.toString())),
        ),
    ];
  }
}
