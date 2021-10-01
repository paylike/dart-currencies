import 'package:paylike_currencies/paylike_currencies.dart';
import 'dart:math';

// Describes that a given currency the user is looking for
// is missing from the collection
class MissingCurrency implements Exception {
  final String cause = 'Currency is missing';
  CurrencyCode? code;
  int? numeric;
  MissingCurrency.fromNumeric(this.numeric);
  MissingCurrency.fromCode(this.code);
}

// PaylikeCurrency describes a single currency in the collection
class PaylikeCurrency {
  String code;
  String currency;
  int numeric;
  int exponent;
  bool funding;
  // Creates a PaylikeCurrency instance
  PaylikeCurrency(
      this.code, this.currency, this.numeric, this.exponent, this.funding);
  // Creates a PaylikeCurrency instance using JSON
  PaylikeCurrency.fromJSON(Map<String, dynamic> json)
      : code = json['code'],
        currency = json['currency'],
        numeric = int.parse(json['numeric']),
        exponent = json['exponent'],
        funding = json['funding'] != null;
}

// PaylikeCurrencies is responsible for currency related operations
class PaylikeCurrencies {
  // Provides a [PaylikeCurrency] based on [code]
  PaylikeCurrency byCode(CurrencyCode code) {
    var element = PaylikeCurrencyCollection.currencies[code];
    if (element == null) {
      throw MissingCurrency.fromCode(code);
    }
    return element;
  }

  // Lists all available currencies
  List<PaylikeCurrency> list() => List.from(
      PaylikeCurrencyCollection.currencies.entries.map((e) => e.value));

// Provides a [PaylikeCurrency] based on [numeric]
  PaylikeCurrency byNumeric(int numeric) {
    var element = PaylikeCurrencyCollection.currencies.entries.firstWhere(
        (element) => element.value.numeric == numeric,
        orElse: () => throw MissingCurrency.fromNumeric(numeric));
    return element.value;
  }

  // Converts a currency to minor value using its exponent
  // e.g: 1 USD to cents
  num toMinor(CurrencyCode code, num major) =>
      (major * pow(10, byCode(code).exponent)).round();

  // Converts a currency to major value using its exponent
  // e.g: 100 cents to 1 USD
  num toMajor(CurrencyCode code, num minor) =>
      minor / pow(10, byCode(code).exponent);
}
