import 'package:bank_sha/models/data_plan_model.dart';
import 'package:bank_sha/shared/theme.dart';
import 'package:flutter/material.dart';

import '../../shared/shared_method.dart';

class DataPackageItem extends StatelessWidget {
  // final int amount;
  // final int price;
  final DataPlanModel dataPlan;
  final bool isSelected;

  DataPackageItem({
    super.key,
    // required this.amount,
    // required this.price,
    required this.dataPlan,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 155,
      height: 171,
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 49,
      ),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(20),
        border: isSelected
            ? Border.all(
                strokeAlign: 2,
                color: blueColor,
              )
            : null,
      ),
      child: Column(
        children: [
          Text(
            dataPlan.name.toString(),
            style: blackTextStyle.copyWith(
              fontSize: 32,
              fontWeight: medium,
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Text(
            // default valuenya klo gaada itu 0
            formatCurrency(dataPlan.price ?? 0),
            style: greyTextStyle.copyWith(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
