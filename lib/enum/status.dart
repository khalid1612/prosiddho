enum Status {
  Active,
  Review,
  Banned,
}

extension normalize on Status {
  String get value {
    return this.toString().split('.').last;
  }
}
