import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibank/features/acc&cards/presentation/acc_cards_const.dart';
import 'package:ibank/features/acc&cards/data/repo/card_repo.dart';
import 'package:ibank/features/acc&cards/presentation/cubit/acc_card_states.dart';

class AccCardCubit extends Cubit<AccCardStates> {
  AccCardCubit() : super(AccCardInitialState());
  Future<void> getCards() async {
    emit(AccCardLoadingState());
    try {
      final value = await CardRepo().getCards();
      if (value?.data != null) {
        emit(GetCardsSuccessState(cards: value!.data!));
      } else {
        emit(GetCardsErrorState(error: AccCardsConst.fetchCardsUnknownError));
      }
    } catch (e) {
      emit(GetCardsErrorState(error: e.toString()));
    }
  }

  Future<void> deleteCard(String cardID) async {
    emit(AccCardLoadingState());
    try {
      final value = await CardRepo().deleteCard(cardID: cardID);
      if (value?.status == true) {
        emit(DeleteCardSuccessState(message: value!.message!));
      } else {
        emit(DeleteCardErrorState(error: AccCardsConst.deleteCardUnknownError));
      }
    } catch (e) {
      emit(DeleteCardErrorState(error: e.toString()));
    }
  }

  Future<void> setDefaultCard(String cardID) async {
    emit(AccCardLoadingState());
    try {
      final value = await CardRepo().setDefaultCard(cardID: cardID);
      if (value?.status == true) {
        emit(SetDefaultCardSuccessState(message: value!.message!));
      } else {
        emit(
          SetDefaultCardErrorState(
            error: AccCardsConst.setDefaultCardUnknownError,
          ),
        );
      }
    } catch (e) {
      emit(SetDefaultCardErrorState(error: e.toString()));
    }
  }
}
