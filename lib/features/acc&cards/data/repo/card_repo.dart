import 'package:dio/dio.dart';
import 'package:ibank/core/model/card_model.dart';
import 'package:ibank/core/service/dio_provider.dart';
import 'package:ibank/core/service/local_helper.dart';
import 'package:ibank/features/acc&cards/data/models/request/card_request.dart';
import 'package:ibank/features/acc&cards/data/models/response/card_response/card_response.dart';
import 'package:ibank/features/acc&cards/data/models/response/get_cards_response/get_cards_response.dart';

class CardRepo {
  final String token = AppLocalStorage.getToken() ?? '';

  Future<CardResponse?> addCard({required CardModel card}) async {
    try {
      var response = await DioProvider.post(
        endpoint: 'cards/add_card',
        headers: {'Authorization': 'Bearer $token'},
        data:
            CardRequest(
              brand: card.type,
              cardNumber: card.cardnumber,
              cardHolderName: card.cardholdername,
              cvv: card.cvv,
              expiryDate: card.expirationdate,
            ).toJson(),
      );
      if (response.statusCode == 200) {
        return CardResponse.fromJson(response.data);
      } else {
        return null;
      }
    } on DioException catch (e) {
      throw e.response?.data['message'] ?? 'Something went wrong';
    } catch (e) {
      throw 'Unexpected error';
    }
  }

  Future<GetCardsResponse?> getCards() async {
    try {
      var response = await DioProvider.get(
        endpoint: 'cards/get_cards',
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        return GetCardsResponse.fromJson(response.data);
      } else {
        return null;
      }
    } on DioException catch (e) {
      throw e.response?.data['message'] ?? 'Something went wrong';
    } catch (e) {
      throw 'Unexpected error';
    }
  }

  Future<CardResponse?> deleteCard({required String cardID}) async {
    try {
      var response = await DioProvider.delete(
        endpoint: 'cards/delete_card/$cardID',
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        return CardResponse.fromJson(response.data);
      } else {
        return null;
      }
    } on DioException catch (e) {
      throw e.response?.data['message'] ?? 'Something went wrong';
    } catch (e) {
      throw 'Unexpected error';
    }
  }

  Future<CardResponse?> updateCard({
    required String cardID,
    required CardModel card,
    required String cvv,
  }) async {
    try {
      var response = await DioProvider.delete(
        endpoint: 'cards/delete_card/$cardID',
        headers: {'Authorization': 'Bearer $token'},
        data:
            CardRequest(
              brand: card.type,
              cardNumber: card.cardnumber,
              cardHolderName: card.cardholdername,
              cvv: cvv,
              expiryDate: card.expirationdate,
            ).toJson(),
      );
      if (response.statusCode == 200) {
        return CardResponse.fromJson(response.data);
      } else {
        return null;
      }
    } on DioException catch (e) {
      throw e.response?.data['message'] ?? 'Something went wrong';
    } catch (e) {
      throw 'Unexpected error';
    }
  }
}
