import 'package:bank_sha/models/operator_card_model.dart';
import 'package:bank_sha/shared/theme.dart';
import 'package:flutter/material.dart';

class DataProviderItem extends StatelessWidget {
  // final String iconUrl;
  // final String nameProvider;
  // final String available;
  final OperatorCardModel operatorCard;
  final bool isSelected;

  const DataProviderItem({
    super.key,
    // required this.iconUrl,
    // required this.nameProvider,
    // required this.available,
    required this.operatorCard,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 87,
      margin: const EdgeInsets.only(
        bottom: 18,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: whiteColor,
          border: Border.all(
            width: 2,
            color: isSelected
                ? blueColor
                : whiteColor, // kondisikan jika isSelected
          )),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 22,
          vertical: 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.network(
              operatorCard.thumbnail.toString(),
              height:
                  30, // samakan berdasarkan tinggi saja karna lebarnya beda2
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  operatorCard.name.toString(),
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: medium,
                  ),
                ),
                Text(
                  operatorCard.status.toString(),
                  style: greyTextStyle.copyWith(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
