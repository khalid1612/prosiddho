enum PaymentGetway {
  cash_on_delivery,
  bkash,
  rocket,
  sure_cash,
  nogod,
  dbbl_card,
  debit_credit_card,
}

extension normalize on PaymentGetway {
  String get value {
    return this.toString().split('.').last;
  }
}
