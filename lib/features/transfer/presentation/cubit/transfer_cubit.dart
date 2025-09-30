import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibank/features/transfer/data/repo/transfer_repo.dart';
import 'package:ibank/features/transfer/presentation/cubit/transfer_states.dart';

class TransferCubit extends Cubit<TransferStates> {
  TransferCubit() : super(TransferInitial());
  Future<void> transferMoney({
    required String receiverEmail,
    required double amount,
    required bool usebalance,
    String? cardId,
  }) async {
    emit(TransferLoading());
    try {
      final value = await TransferRepo().transferMoney(
        receiverEmail: receiverEmail,
        amount: amount,
        usebalance: usebalance,
        cardId: cardId,
      );
      if (value?.status == true) {
        emit(TransferSuccess());
      } else {
        emit(TransferError(errorMessage: value?.message ?? 'Transfer failed'));
      }
    } catch (e) {
      emit(TransferError(errorMessage: e.toString()));
    }
  }
}
