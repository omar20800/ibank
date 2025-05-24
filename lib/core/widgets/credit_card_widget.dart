import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibank/core/model/card_model.dart';
import 'package:ibank/core/utils/appcolour.dart';
import 'package:ibank/core/utils/text_style.dart';
import 'package:ibank/features/home/presentation/widgets/serial_number_widget.dart';

class CreditCardWidget extends StatelessWidget {
  const CreditCardWidget({super.key, this.card});
  final CardModel? card;

  @override
  Widget build(BuildContext context) {
    if (card != null) {
      return Container(
        width: double.infinity,
        height: 250.h,
        padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 35.w),
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/${card?.type}.png'),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                card!.cardholdername,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: getTitle2TextStyle(color: AppColours.naturalColor6),
              ),
            ),
            Text(
              '${card!.type?.toUpperCase()}',
              style: getBody1TextStyle(color: AppColours.naturalColor6),
            ),
            SizedBox(height: 20.h),
            SerialNumberWidget(serialNumber: card!.cardnumber),
            SizedBox(height: 10.h),
            Text(
              card!.expirationdate,
              style: getTitle2TextStyle(color: AppColours.naturalColor6),
            ),
          ],
        ),
      );
    } else {
      return Container(
        width: double.infinity,
        height: 250.h,
        padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 35.w),
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fitWidth,
            image: AssetImage('assets/images/empty.png'),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'No Cards Available',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: getTitle2TextStyle(color: AppColours.naturalColor6),
            ),
          ],
        ),
      );
    }
  }
}
