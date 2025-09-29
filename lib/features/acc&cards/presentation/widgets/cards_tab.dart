import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibank/core/extentions/extenstions.dart';
import 'package:ibank/core/service/dialogs.dart';
import 'package:ibank/core/utils/appcolour.dart';
import 'package:ibank/core/widgets/credit_card_widget.dart';
import 'package:ibank/core/widgets/custom_button_widget.dart';
import 'package:ibank/features/acc&cards/data/models/response/get_cards_response/datum.dart';
import 'package:ibank/features/acc&cards/presentation/cubit/acc_card_cubit.dart';
import 'package:ibank/features/acc&cards/presentation/screens/add_card_screen.dart';

class CardsTab extends StatefulWidget {
  const CardsTab({super.key, required this.cards, required this.cubit});
  final List<Datum> cards;
  final AccCardCubit cubit;

  @override
  State<CardsTab> createState() => _CardsTabState();
}

class _CardsTabState extends State<CardsTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            itemCount: widget.cards.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: UniqueKey(),
                confirmDismiss: (direction) {
                  return Dialogs.showAlertDialog(
                    context,
                    'Card Delete',
                    'Are you sure you want to delete this card ?',
                    () {
                      Navigator.of(context).pop(true);
                    },
                    () {
                      Navigator.of(context).pop(false);
                    },
                    'Confirm',
                    'Cancel',
                  );
                },
                secondaryBackground: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: 20.w),
                  child: Icon(Icons.delete, color: Colors.white, size: 30),
                ),
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 20.w),
                  child: Icon(Icons.delete, color: Colors.white, size: 30),
                ),
                onDismissed: (direction) async {
                  final cardId = widget.cards[index].id!;
                  widget.cards.removeAt(index);
                  setState(() {});

                  await widget.cubit.deleteCard(cardId);
                },
                child: GestureDetector(
                  onLongPress: () {
                    Dialogs.showAlertDialog(
                      context,
                      'Default Card',
                      'Are you sure you want to set this card as default ?',
                      () {
                        Navigator.of(context).pop();
                        widget.cubit.setDefaultCard(widget.cards[index].id!);
                      },
                      () => Navigator.of(context).pop(),
                      'Yes',
                      'No',
                    );
                  },
                  child: CreditCardWidget(card: widget.cards[index]),
                ),
              );
            },
            separatorBuilder: (context, index) => SizedBox(height: 5.h),
          ),
        ),
        SizedBox(height: 20.h),
        CustomButtonWidget(
          height: 44.h,
          text: 'Add new card',
          bgcolor: AppColours.primaryColor1,
          textColor: AppColours.naturalColor6,
          onPressed: () async {
            context.pushTo(AddCardScreen());
          },
        ),
      ],
    );
  }
}
