import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibank/core/model/card_model.dart';
import 'package:ibank/core/service/local_helper.dart';
import 'package:ibank/features/acc&cards/presentation/cubit/acc_card_states.dart';

class AccCardCubit extends Cubit<AccCardStates> {
  AccCardCubit() : super(AccCardInitialState());

  getCards() async {}

  addCard(CardModel card) async {}

  deleteCard(CardModel card) async {}
}
