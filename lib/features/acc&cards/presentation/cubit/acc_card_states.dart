import 'package:ibank/core/model/card_model.dart';

class AccCardStates {}

class AccCardInitialState extends AccCardStates {}

class AccCardLoadingState extends AccCardStates {}

class AddCardSuccessState extends AccCardStates {
  final String message;
  AddCardSuccessState({required this.message});
}

class AddCardErrorState extends AccCardStates {
  final String error;
  AddCardErrorState({required this.error});
}

class GetCardsSuccessState extends AccCardStates {
  final List<CardModel> cards;
  GetCardsSuccessState({required this.cards});
}

class GetCardsErrorState extends AccCardStates {
  final String error;
  GetCardsErrorState({required this.error});
}