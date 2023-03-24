import 'package:flutter/foundation.dart';

import 'package:cimat_bloc/app/core/models/item_model.dart';
import 'package:cimat_bloc/app/core/models/user_profile_model.dart';

enum CautionDeliveryStateStatus { initial, loading, success, error }

class CautionDeliveryState {
  final CautionDeliveryStateStatus status;
  final String? error;
  final List<ItemModel> itemList;
  final UserProfileModel? userProfile;
  final int quantity;

  int get quantityMax => itemList.length;

  CautionDeliveryState({
    required this.status,
    this.error,
    required this.itemList,
    this.userProfile,
    required this.quantity,
  });
  CautionDeliveryState.initial()
      : status = CautionDeliveryStateStatus.initial,
        error = '',
        itemList = [],
        userProfile = null,
        quantity = 0;

  CautionDeliveryState copyWith({
    CautionDeliveryStateStatus? status,
    String? error,
    List<ItemModel>? itemList,
    UserProfileModel? userProfile,
    int? quantity,
  }) {
    return CautionDeliveryState(
      status: status ?? this.status,
      error: error ?? this.error,
      itemList: itemList ?? this.itemList,
      userProfile: userProfile ?? this.userProfile,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CautionDeliveryState &&
        other.status == status &&
        other.error == error &&
        listEquals(other.itemList, itemList) &&
        other.userProfile == userProfile &&
        other.quantity == quantity;
  }

  @override
  int get hashCode {
    return status.hashCode ^
        error.hashCode ^
        itemList.hashCode ^
        userProfile.hashCode ^
        quantity.hashCode;
  }
}
