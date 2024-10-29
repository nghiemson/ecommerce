import 'package:freezed_annotation/freezed_annotation.dart';

part 'bank.g.dart';
part 'bank.freezed.dart';

@freezed
class Bank with _$Bank {
  const Bank._();
  const factory Bank({
    required String shortName,
    required String bankLogoUrl,
  }) = _Bank;

  factory Bank.fromJson(Map<String, dynamic> json) => _$BankFromJson(json);
}