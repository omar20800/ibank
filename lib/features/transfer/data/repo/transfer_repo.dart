import 'package:dio/dio.dart';
import 'package:ibank/core/constants/api_constants.dart';
import 'package:ibank/core/service/dio_provider.dart';
import 'package:ibank/core/service/local_helper.dart';
import 'package:ibank/features/transfer/data/model/request/transfer_request.dart';
import 'package:ibank/features/transfer/data/model/response/transfer_response.dart';

class TransferRepo {
  final String token = AppLocalStorage.getToken() ?? '';

  bool _isSuccess(int? statusCode) =>
      statusCode != null && (statusCode >= 200 && statusCode < 300);

  Never _handleError(DioException e) {
    throw e.response?.data['message'] ?? 'Something went wrong';
  }

  Future<TransferResponse?> transferMoney({
    required String receiverEmail,
    required int amount,
    required bool usebalance,
    String? cardId,
  }) async {
    try {
      var response = await DioProvider.post(
        endpoint: ApiConstants.transactionsroute + ApiConstants.transferMoney,
        headers: {ApiConstants.authorizationHeader : ApiConstants.bearerToken + token},
        data: TransferRequest(
          receiverEmail: receiverEmail,
          amount: amount,
          usebalance: usebalance,
          cardId: cardId,
        ).toJson(),
      );

      if (_isSuccess(response.statusCode)) {
        return TransferResponse.fromJson(response.data);
      }
      return null;
    } on DioException catch (e) {
      _handleError(e);
    }
  }
}