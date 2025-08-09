class AddCardStates {}

class AddCardInitialState extends AddCardStates {}

class AddCardLoadingState extends AddCardStates {}

class AddCardSuccessState extends AddCardStates {
  final String message;
  AddCardSuccessState({required this.message});
}

class AddCardErrorState extends AddCardStates {
  final String error;
  AddCardErrorState({required this.error});
}
