import 'package:flutter/foundation.dart';

import '../../../../core/models/caution_model.dart';

enum CautionReceiverStateStatus { initial, loading, success, error }

class CautionReceiverState {
  final CautionReceiverStateStatus status;
  final String? error;
  final List<CautionModel> cautionModelListTemporary;
  final List<CautionModel> cautionModelListPermanent;
  final CautionModel? cautionModel;
  CautionReceiverState({
    required this.status,
    this.error,
    required this.cautionModelListTemporary,
    required this.cautionModelListPermanent,
    this.cautionModel,
  });
  CautionReceiverState.initial()
      : status = CautionReceiverStateStatus.initial,
        error = '',
        cautionModelListTemporary = [],
        cautionModelListPermanent = [],
        cautionModel = null;
  CautionReceiverState copyWith({
    CautionReceiverStateStatus? status,
    String? error,
    List<CautionModel>? cautionModelListTemporary,
    List<CautionModel>? cautionModelListPermanent,
    CautionModel? cautionModel,
  }) {
    return CautionReceiverState(
      status: status ?? this.status,
      error: error ?? this.error,
      cautionModelListTemporary:
          cautionModelListTemporary ?? this.cautionModelListTemporary,
      cautionModelListPermanent:
          cautionModelListPermanent ?? this.cautionModelListPermanent,
      cautionModel: cautionModel ?? this.cautionModel,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CautionReceiverState &&
        other.status == status &&
        other.error == error &&
        listEquals(
            other.cautionModelListTemporary, cautionModelListTemporary) &&
        listEquals(
            other.cautionModelListPermanent, cautionModelListPermanent) &&
        other.cautionModel == cautionModel;
  }

  @override
  int get hashCode {
    return status.hashCode ^
        error.hashCode ^
        cautionModelListTemporary.hashCode ^
        cautionModelListPermanent.hashCode ^
        cautionModel.hashCode;
  }
}
