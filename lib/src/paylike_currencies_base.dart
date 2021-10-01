import 'package:paylike_currencies/paylike_currencies.dart';

class PaylikeCurrency {
  String code;
  String currency;
  int numeric;
  int exponent;
  PaylikeCurrency(this.code, this.currency, this.numeric, this.exponent);
  PaylikeCurrency.fromJSON(Map<String, dynamic> json)
      : code = json['code'],
        currency = json['currency'],
        numeric = int.parse(json['numeric']),
        exponent = json['exponent'];
}

class PaylikeCurrencies {
  PaylikeCurrency byCode(CurrencyCode code) {
    var element = PaylikeCurrencyCollection.currencies[code];
    if (element == null) {
      throw Exception('Code generation error');
    }
    return element;
  }
}
