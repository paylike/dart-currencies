// PaylikeCurrency describes a single currency in the collection
class PaylikeCurrency {
  String code;
  String currency;
  int numeric;
  int exponent;
  bool funding;
  bool deprecated;
  // Creates a PaylikeCurrency instance
  PaylikeCurrency(this.code, this.currency, this.numeric, this.exponent,
      this.funding, this.deprecated);
  // Creates a PaylikeCurrency instance using JSON
  PaylikeCurrency.fromJSON(Map<String, dynamic> json)
      : code = json['code'],
        currency = json['currency'],
        numeric = int.parse(json['numeric']),
        exponent = json['exponent'],
        funding = json['funding'] != null,
        deprecated = json['deprecated'] != null;
}
