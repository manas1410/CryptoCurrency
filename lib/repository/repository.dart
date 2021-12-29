import 'package:crypto_tracker/models/big_data_model.dart';
import 'package:crypto_tracker/models/data_model.dart';
import 'package:dio/dio.dart';

class Repository {

  static String mainUrl = 'https://pro-api.coinmarketcap.com/v1/';
  final String apiKey = 'efe7563d-aa8a-4808-95a1-ad856772b0f0';
  var currencyListingAPI = '${mainUrl}cryptocurrency/listings/latest';
  Dio _dio = Dio();

  Future<BigDataModel> getCoins() async {
    try {
      _dio.options.headers["X-CMC_PRO_API_KEY"] = apiKey;
      Response response = await _dio.get(currencyListingAPI);
      print(response.data);
      return BigDataModel.fromJson(response.data);

    } catch (error, stacktrace){
      print("exception $error, dd $stacktrace");
      return BigDataModel.withError("error");
    }
  }
}