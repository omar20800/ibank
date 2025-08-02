import 'package:ibank/features/acc&cards/data/models/response/get_cards_response/datum.dart';

class AccCardStates {}

class AccCardInitialState extends AccCardStates {}

class AccCardLoadingState extends AccCardStates {}

class DeleteCardSuccessState extends AccCardStates {
  final String message;
  DeleteCardSuccessState({required this.message});
}

class DeleteCardErrorState extends AccCardStates {
  final String error;
  DeleteCardErrorState({required this.error});
  
}

class GetCardsSuccessState extends AccCardStates {
  final List<Datum> cards;
  GetCardsSuccessState({required this.cards});
}

class GetCardsErrorState extends AccCardStates {
  final String error;
  GetCardsErrorState({required this.error});
}
