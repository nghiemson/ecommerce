import 'package:freezed_annotation/freezed_annotation.dart';

import 'bank.dart';

part 'banks_ressponse.g.dart';
part 'banks_ressponse.freezed.dart';

@freezed
class BanksResponse with _$BanksResponse {
  const factory BanksResponse({
    required Map<String, Bank> banks,
  }) = _BanksResponse;

  factory BanksResponse.fromJson(Map<String, dynamic> json) =>
      _$BanksResponseFromJson(json);
}
