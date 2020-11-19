enum Division {
  Dhaka,
  Chittagong,
  Khulna,
  Rangpur,
  Rajshahi,
  Barisal,
  Sylhet,
  Mymensingh,
}

extension normalize on Division {
  String get value {
    return this.toString().split('.').last;
  }
}
