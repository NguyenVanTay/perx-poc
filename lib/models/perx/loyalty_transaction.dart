class LoyaltyTransaction {
  int? id;
  int? amount;
  String? identifier;
  int? loyaltyId;
  String? loyaltyName;
  String? name;
  Map<String, dynamic>? properties;
  int? ruleId;
  String? ruleName;
  int? transactedAmount;
  DateTime? transactedAt;
  int? transactedCents;
  String? transactedCurrency;
  TransactionDetails? transactionDetails;
  TransactionType? transactionType;

  LoyaltyTransaction(
      {this.id,
      this.amount,
      this.identifier,
      this.loyaltyId,
      this.loyaltyName,
      this.name,
      this.properties,
      this.ruleId,
      this.ruleName,
      this.transactedAmount,
      this.transactedAt,
      this.transactedCents,
      this.transactedCurrency,
      this.transactionDetails,
      this.transactionType});

  LoyaltyTransaction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    identifier = json['identifier'];
    loyaltyId = json['loyalty_id'];
    loyaltyName = json['loyalty_name'];
    name = json['name'];
    properties = json['properties'] != null ? Map<String, String>.from(json['properties']) : null;
    ruleId = json['rule_id'];
    ruleName = json['rule_name'];
    if (json['transacted_amount'] != null) {
      transactedAmount = double.parse(json['transacted_amount']).round();
    }
    if (json['transacted_at'] != null) {
      transactedAt = DateTime.parse(json['transacted_at']);
    }
    transactedCents = json['transacted_cents'];
    transactedCurrency = json['transacted_currency'];
    transactionDetails =
        json['transaction_details'] != null ? TransactionDetails.fromJson(json['transaction_details']) : null;
    transactionType = json['transaction_type'] != null
        ? TransactionType.values.firstWhere((e) => e.toString() == json['transaction_type'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['amount'] = amount;
    data['identifier'] = identifier;
    data['loyalty_id'] = loyaltyId;
    data['loyalty_name'] = loyaltyName;
    data['name'] = name;
    data['properties'] = properties;
    data['rule_id'] = ruleId;
    data['rule_name'] = ruleName;
    data['transacted_amount'] = transactedAmount;
    data['transacted_at'] = transactedAt;
    data['transacted_cents'] = transactedCents;
    data['transacted_currency'] = transactedCurrency;
    if (transactionDetails != null) data['transaction_details'] = transactionDetails!.toJson();
    data['transaction_type'] = transactionType;
    return data;
  }
}

class TransactionDetails {
  String? type;
  TransactionData? data;

  TransactionDetails({this.type, this.data});

  TransactionDetails.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    data = json['data'] != null ? TransactionData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    if (this.data != null) data['data'] = this.data!.toJson();
    return data;
  }
}

class TransactionData {
  int? id;
  String? name;
  String? outcomeId;
  String? outcomeType;

  TransactionData({this.id, this.name, this.outcomeId, this.outcomeType});

  TransactionData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    outcomeId = json['outcome_id'];
    outcomeType = json['outcome_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['outcome_id'] = outcomeId;
    data['outcome_type'] = outcomeType;
    return data;
  }
}

enum TransactionType { earn, burn }
