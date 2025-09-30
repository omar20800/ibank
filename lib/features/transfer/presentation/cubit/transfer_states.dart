class TransferStates {}

class TransferInitial extends TransferStates {}

class TransferLoading extends TransferStates {}

class TransferSuccess extends TransferStates {}

class TransferError extends TransferStates {
  final String errorMessage;
  TransferError({required this.errorMessage});
}
