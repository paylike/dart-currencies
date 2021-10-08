import 'package:paylike_currencies/paylike_currencies.dart';

void main() {
  var currencies = PaylikeCurrencies();
  var eur = currencies.byCode(CurrencyCode.EUR);
  print(eur.code);

  var all = currencies.list();
  for (var currency in all) {
    print(currency);
  }

  CurrencyCode? current;
  try {
    current = currencies.getCurrencyCode('USD');
    var usd = currencies.byCode(current);
  } on MissingCurrencyException catch (e) {
    print('${e.cause}, ${e.code}, ${e.numeric}, ${e.requestCode}');
  }
}
