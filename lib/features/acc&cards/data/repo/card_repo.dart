import 'package:dio/dio.dart';
import 'package:ibank/core/constants/api_constants.dart';
import 'package:ibank/core/service/dio_provider.dart';
import 'package:ibank/core/service/local_helper.dart';
import 'package:ibank/features/acc&cards/data/models/request/card_request.dart';
import 'package:ibank/features/acc&cards/data/models/response/card_response/card_response.dart';
import 'package:ibank/features/acc&cards/data/models/response/get_cards_response/get_cards_response.dart';

class CardRepo {
  final String token = AppLocalStorage.getToken() ?? '';

  bool _isSuccess(int? statusCode) =>
      statusCode != null && (statusCode >= 200 && statusCode < 300);

  Never _handleError(DioException e) {
    throw e.response?.data['message'] ?? 'Something went wrong';
  }

  Future<CardResponse?> addCard({required CardRequest card}) async {
    try {
      var response = await DioProvider.post(
        endpoint: ApiConstants.cardsroute + ApiConstants.addCard,
        headers: {'Authorization': 'Bearer $token'},
        data: card.toJson(),
      );
      if (_isSuccess(response.statusCode)) {
        return CardResponse.fromJson(response.data);
      }
      return null;
    } on DioException catch (e) {
      _handleError(e);
    }
  }

  Future<GetCardsResponse?> getCards() async {
    try {
      var response = await DioProvider.get(
        endpoint: ApiConstants.cardsroute + ApiConstants.getCards,
        headers: {'Authorization': 'Bearer $token'},
      );
      if (_isSuccess(response.statusCode)) {
        return GetCardsResponse.fromJson(response.data);
      }
      return null;
    } on DioException catch (e) {
      _handleError(e);
    }
  }

  Future<CardResponse?> deleteCard({required String cardID}) async {
    try {
      var response = await DioProvider.delete(
        endpoint: '${ApiConstants.cardsroute}${ApiConstants.deleteCard}/$cardID',
        headers: {'Authorization': 'Bearer $token'},
      );
      if (_isSuccess(response.statusCode)) {
        return CardResponse.fromJson(response.data);
      }
      return null;
    } on DioException catch (e) {
      _handleError(e);
    }
  }

  Future<CardResponse?> updateCard({
    required String cardID,
    required CardRequest card,
    required String cvv,
  }) async {
    try {
      var response = await DioProvider.update(
        endpoint: '${ApiConstants.cardsroute}${ApiConstants.updateCard}/$cardID',
        headers: {'Authorization': 'Bearer $token'},
        data: CardRequest(
          brand: card.brand,
          cardNumber: card.cardNumber,
          cardHolderName: card.cardHolderName,
          cvv: cvv,
          expiryDate: card.expiryDate,
        ).toJson(),
      );
      if (_isSuccess(response.statusCode)) {
        return CardResponse.fromJson(response.data);
      }
      return null;
    } on DioException catch (e) {
      _handleError(e);
    }
  }

  Future<CardResponse?> setDefaultCard({required String cardID}) async {
    try {
      var response = await DioProvider.update(
        endpoint:
            '${ApiConstants.cardsroute}${ApiConstants.changeDefaultCard}/$cardID',
        headers: {'Authorization': 'Bearer $token'},
      );
      if (_isSuccess(response.statusCode)) {
        return CardResponse.fromJson(response.data);
      }
      return null;
    } on DioException catch (e) {
      _handleError(e);
    }
  }
}