import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibank/core/model/user_model.dart';
import 'package:ibank/core/service/dialogs.dart';
import 'package:ibank/core/utils/appcolour.dart';
import 'package:ibank/core/utils/text_style.dart';
import 'package:ibank/core/widgets/picture_widget.dart';
import 'package:ibank/core/widgets/credit_card_widget.dart';
import 'package:ibank/features/acc&cards/presentation/screens/accountcard_screen.dart';
import 'package:ibank/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:ibank/features/auth/presentation/cubit/auth_states.dart';
import 'package:ibank/features/home/presentation/widgets/home_tile_widget.dart';
import 'package:ibank/features/transfer/presentation/screens/transfer_money_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  UserModel? user;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (context) => AuthCubit()..getUser(),
      child: Scaffold(
        backgroundColor: AppColours.primaryColor1,
        body: BlocConsumer<AuthCubit, AuthStates>(
          listener: (context, state) {
            if (state is GetUserDataSuccess) {
              user = state.user;
            } else if (state is GetUserDataError) {
              Dialogs.showErrorDialog(context, state.errorMessage);
            }
          },
          builder: (context, state) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<AuthCubit>().getUser();
              },
              child: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    child: SafeArea(
                      child: Center(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 20,
                                right: 20,
                                top: 10,
                              ),
                              child: Row(
                                children: [
                                  PictureWidget(imageURL: user?.imageUrl),
                                  SizedBox(width: 20.w),
                                  Text(
                                    'Hi, ${user?.name}',
                                    style: getBody1TextStyle(
                                      color: AppColours.naturalColor6,
                                    ),
                                  ),
                                  Spacer(),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.notifications),
                                    color: AppColours.naturalColor6,
                                    iconSize: 30.sp,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20.h),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(
                                  left: 10.w,
                                  right: 10.w,
                                  top: 10.h,
                                  bottom: 20.h,
                                ),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30.r),
                                    topRight: Radius.circular(30.r),
                                  ),
                                  color: AppColours.naturalColor6,
                                ),
                                child: Column(
                                  children: [
                                    state is GetUserDataLoading
                                        ? Column(
                                          children: [
                                            const CircularProgressIndicator(
                                              color: AppColours.primaryColor1,
                                            ),
                                            SizedBox(height: 20.h),
                                            Text(
                                              'Loading user data...',
                                              style: getBody1TextStyle(
                                                color: AppColours.primaryColor1,
                                              ),
                                            ),
                                          ],
                                        )
                                        : CreditCardWidget(
                                          card: user?.defaultCard,
                                        ),
                                    Expanded(
                                      child: Row(
                                        spacing: 15.w,
                                        children: [
                                          HomeTileWidget(
                                            iconPath:
                                                'assets/icons/wallet_icon.svg',
                                            title: 'Account and Cards',
                                            destination: AccountcardScreen(),
                                          ),
                                          HomeTileWidget(
                                            title: 'Transfer',
                                            iconPath:
                                                'assets/icons/transfer.svg',
                                            destination: TransferMoney(),
                                          ),
                                          HomeTileWidget(
                                            title: 'Withdraw',
                                            iconPath:
                                                'assets/icons/credit-card.svg',
                                            destination: null,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 20.h),
                                    Expanded(
                                      child: Row(
                                        spacing: 15.w,
                                        children: [
                                          HomeTileWidget(
                                            iconPath:
                                                'assets/icons/mobile-banking.svg',
                                            title: 'Mobile prepaid',
                                            destination: null,
                                          ),
                                          HomeTileWidget(
                                            title: 'Pay the bill',
                                            iconPath:
                                                'assets/icons/receipt-list.svg',
                                            destination: null,
                                          ),
                                          HomeTileWidget(
                                            title: 'Save online',
                                            iconPath: 'assets/icons/pig.svg',
                                            destination: null,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 20.h),
                                    Expanded(
                                      child: Row(
                                        spacing: 15.w,
                                        children: [
                                          HomeTileWidget(
                                            iconPath:
                                                'assets/icons/credit-card 2.svg',
                                            title: 'Credit card',
                                            destination: null,
                                          ),
                                          HomeTileWidget(
                                            title: 'Transaction report',
                                            iconPath:
                                                'assets/icons/file-paragraph.svg',
                                            destination: null,
                                          ),
                                          HomeTileWidget(
                                            title: 'Beneficiary',
                                            iconPath:
                                                'assets/icons/contacts.svg',
                                            destination: null,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
