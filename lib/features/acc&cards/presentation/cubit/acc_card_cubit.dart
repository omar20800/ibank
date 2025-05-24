import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibank/core/model/card_model.dart';
import 'package:ibank/core/service/local_helper.dart';
import 'package:ibank/features/acc&cards/presentation/cubit/acc_card_states.dart';

class AccCardCubit extends Cubit<AccCardStates> {
  AccCardCubit() : super(AccCardInitialState());

  getCards() async {
    emit(AccCardLoadingState());
    try {
      final String? userId = AppLocalStorage.getUser()?.uid;
      if (userId == null) {
        emit(
          GetCardsErrorState(error: "User not logged in or UID is missing."),
        );
        return;
      }
      List<CardModel> cards = [];
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance
              .collection('Users')
              .doc(userId)
              .collection('Cards')
              .get();
      if (snapshot.docs.isNotEmpty) {
        cards =
            snapshot.docs.map((doc) {
              return CardModel.fromJson(doc.data() as Map<String, dynamic>)
                ..id = doc.id;
            }).toList();
      } else {
        cards = [];
      }
      emit(GetCardsSuccessState(cards: cards));
    } catch (e) {
      emit(GetCardsErrorState(error: e.toString()));
    }
  }

  addCard(CardModel card) async {
    emit(AccCardLoadingState());
    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(AppLocalStorage.getUser()?.uid)
          .collection('Cards')
          .add(card.toJson());
      emit(AddCardSuccessState(message: 'Card added successfully.'));
    } catch (e) {
      emit(AddCardErrorState(error: e.toString()));
    }
  }

  deleteCard(CardModel card) async {
    emit(AccCardLoadingState());
    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(AppLocalStorage.getUser()?.uid)
          .collection('Cards')
          .doc(card.id)
          .delete();
      getCards();
    } catch (e) {
      emit(GetCardsErrorState(error: e.toString()));
    }
  }
}
