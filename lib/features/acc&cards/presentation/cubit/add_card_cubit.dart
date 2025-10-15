import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibank/features/acc&cards/presentation/acc_cards_const.dart';
import 'package:ibank/features/acc&cards/data/models/request/card_request.dart';
import 'package:ibank/features/acc&cards/data/repo/card_repo.dart';
import 'package:ibank/features/acc&cards/presentation/cubit/add_card_states.dart';

class AddCardCubit extends Cubit<AddCardStates> {
  AddCardCubit() : super(AddCardInitialState());

  Future<void> addCard(CardRequest card) async {
    emit(AddCardLoadingState());
    try {
      final value = await CardRepo().addCard(card: card);
      if (value?.data != null) {
        emit(AddCardSuccessState(message: value!.message!));
      } else {
        emit(AddCardErrorState(error: AccCardsConst.addCardUnknownError));
      }
    } catch (e) {
      emit(AddCardErrorState(error: e.toString()));
    }
  }
}
