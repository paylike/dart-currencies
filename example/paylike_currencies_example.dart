import 'package:paylike_currencies/paylike_currencies.dart';

void main() {
  var currencies = PaylikeCurrencies();
  var eur = currencies.byCode(CurrencyCode.EUR);
  print(eur.code);

  var all = currencies.list();
  for (var currency in all) {
    print(currency);
  }
}
