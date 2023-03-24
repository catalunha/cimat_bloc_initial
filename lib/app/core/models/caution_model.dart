import 'dart:convert';

import 'item_model.dart';
import 'user_profile_model.dart';

class CautionModel {
  final String? id;

  UserProfileModel? deliveryUserProfile;
  final DateTime? deliveryDt;

  ItemModel? item;

  UserProfileModel? receiverUserProfile;

  // (item.isBlockedOperator=true)

  // Null: analisando item.
  // False: item recusado.
  // True: item aceito.
  final bool? receiverIsAnalyzingItem;
  final DateTime? receiverAnalyzedItemDt;
  final bool? receiverIsPermanentItem;

  // Null: ainda nao analisado.
  // False: operador de posse do item recebido e aceito.
  // True: iniciar devolução.
  final bool? receiverIsStartGiveback;
  final DateTime? receiverGivebackItemDt;
  final String? receiverGivebackDescription;

  UserProfileModel? givebackUserProfile;
  // Null: analisando item.
  // False: item deve atualizar doc (item.isBlockedOperator=false,item.isBlockedDoc=true).
  // True: item aceito sem obs em doc (item.isBlockedOperator=false)
  final bool? givebackIsAnalyzingItem;
  final DateTime? givebackAnalyzedItemDt;
  final String? givebackDescription;

  CautionModel({
    this.id,
    this.deliveryUserProfile,
    this.deliveryDt,
    this.item,
    this.receiverUserProfile,
    this.receiverIsAnalyzingItem,
    this.receiverAnalyzedItemDt,
    this.receiverIsPermanentItem,
    this.receiverIsStartGiveback,
    this.receiverGivebackItemDt,
    this.receiverGivebackDescription,
    this.givebackUserProfile,
    this.givebackIsAnalyzingItem,
    this.givebackAnalyzedItemDt,
    this.givebackDescription,
  });

  CautionModel copyWith({
    String? id,
    UserProfileModel? deliveryUserProfile,
    DateTime? deliveryDt,
    ItemModel? item,
    UserProfileModel? receiverUserProfile,
    bool? receiverIsAnalyzingItem,
    DateTime? receiverAnalyzedItemDt,
    bool? receiverIsPermanentItem,
    bool? receiverIsStartGiveback,
    DateTime? receiverGivebackItemDt,
    String? receiverGivebackDescription,
    UserProfileModel? givebackUserProfile,
    bool? givebackIsAnalyzingItem,
    DateTime? givebackAnalyzedItemDt,
    String? givebackDescription,
  }) {
    return CautionModel(
      id: id ?? this.id,
      deliveryUserProfile: deliveryUserProfile ?? this.deliveryUserProfile,
      deliveryDt: deliveryDt ?? this.deliveryDt,
      item: item ?? this.item,
      receiverUserProfile: receiverUserProfile ?? this.receiverUserProfile,
      receiverIsAnalyzingItem:
          receiverIsAnalyzingItem ?? this.receiverIsAnalyzingItem,
      receiverAnalyzedItemDt:
          receiverAnalyzedItemDt ?? this.receiverAnalyzedItemDt,
      receiverIsPermanentItem:
          receiverIsPermanentItem ?? this.receiverIsPermanentItem,
      receiverIsStartGiveback:
          receiverIsStartGiveback ?? this.receiverIsStartGiveback,
      receiverGivebackItemDt:
          receiverGivebackItemDt ?? this.receiverGivebackItemDt,
      receiverGivebackDescription:
          receiverGivebackDescription ?? this.receiverGivebackDescription,
      givebackUserProfile: givebackUserProfile ?? this.givebackUserProfile,
      givebackIsAnalyzingItem:
          givebackIsAnalyzingItem ?? this.givebackIsAnalyzingItem,
      givebackAnalyzedItemDt:
          givebackAnalyzedItemDt ?? this.givebackAnalyzedItemDt,
      givebackDescription: givebackDescription ?? this.givebackDescription,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (deliveryUserProfile != null) {
      result.addAll({'deliveryUserProfile': deliveryUserProfile!.toMap()});
    }
    if (deliveryDt != null) {
      result.addAll({'deliveryDt': deliveryDt!.millisecondsSinceEpoch});
    }
    if (item != null) {
      result.addAll({'item': item!.toMap()});
    }
    if (receiverUserProfile != null) {
      result.addAll({'receiverUserProfile': receiverUserProfile!.toMap()});
    }
    if (receiverIsAnalyzingItem != null) {
      result.addAll({'receiverIsAnalyzingItem': receiverIsAnalyzingItem});
    }
    if (receiverAnalyzedItemDt != null) {
      result.addAll({
        'receiverAnalyzedItemDt': receiverAnalyzedItemDt!.millisecondsSinceEpoch
      });
    }
    if (receiverIsPermanentItem != null) {
      result.addAll({'receiverIsPermanentItem': receiverIsPermanentItem});
    }
    if (receiverIsStartGiveback != null) {
      result.addAll({'receiverIsStartGiveback': receiverIsStartGiveback});
    }
    if (receiverGivebackItemDt != null) {
      result.addAll({
        'receiverGivebackItemDt': receiverGivebackItemDt!.millisecondsSinceEpoch
      });
    }
    if (receiverGivebackDescription != null) {
      result
          .addAll({'receiverGivebackDescription': receiverGivebackDescription});
    }
    if (givebackUserProfile != null) {
      result.addAll({'givebackUserProfile': givebackUserProfile!.toMap()});
    }
    if (givebackIsAnalyzingItem != null) {
      result.addAll({'givebackIsAnalyzingItem': givebackIsAnalyzingItem});
    }
    if (givebackAnalyzedItemDt != null) {
      result.addAll({
        'givebackAnalyzedItemDt': givebackAnalyzedItemDt!.millisecondsSinceEpoch
      });
    }
    if (givebackDescription != null) {
      result.addAll({'givebackDescription': givebackDescription});
    }

    return result;
  }

  factory CautionModel.fromMap(Map<String, dynamic> map) {
    return CautionModel(
      id: map['id'],
      deliveryUserProfile: map['deliveryUserProfile'] != null
          ? UserProfileModel.fromMap(map['deliveryUserProfile'])
          : null,
      deliveryDt: map['deliveryDt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['deliveryDt'])
          : null,
      item: map['item'] != null ? ItemModel.fromMap(map['item']) : null,
      receiverUserProfile: map['receiverUserProfile'] != null
          ? UserProfileModel.fromMap(map['receiverUserProfile'])
          : null,
      receiverIsAnalyzingItem: map['receiverIsAnalyzingItem'],
      receiverAnalyzedItemDt: map['receiverAnalyzedItemDt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['receiverAnalyzedItemDt'])
          : null,
      receiverIsPermanentItem: map['receiverIsPermanentItem'],
      receiverIsStartGiveback: map['receiverIsStartGiveback'],
      receiverGivebackItemDt: map['receiverGivebackItemDt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['receiverGivebackItemDt'])
          : null,
      receiverGivebackDescription: map['receiverGivebackDescription'],
      givebackUserProfile: map['givebackUserProfile'] != null
          ? UserProfileModel.fromMap(map['givebackUserProfile'])
          : null,
      givebackIsAnalyzingItem: map['givebackIsAnalyzingItem'],
      givebackAnalyzedItemDt: map['givebackAnalyzedItemDt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['givebackAnalyzedItemDt'])
          : null,
      givebackDescription: map['givebackDescription'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CautionModel.fromJson(String source) =>
      CautionModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CautionModel(id: $id, deliveryUserProfile: $deliveryUserProfile, deliveryDt: $deliveryDt, item: $item, receiverUserProfile: $receiverUserProfile, receiverIsAnalyzingItem: $receiverIsAnalyzingItem, receiverAnalyzedItemDt: $receiverAnalyzedItemDt, receiverIsPermanentItem: $receiverIsPermanentItem, receiverIsStartGiveback: $receiverIsStartGiveback, receiverGivebackItemDt: $receiverGivebackItemDt, receiverGivebackDescription: $receiverGivebackDescription, givebackUserProfile: $givebackUserProfile, givebackIsAnalyzingItem: $givebackIsAnalyzingItem, givebackAnalyzedItemDt: $givebackAnalyzedItemDt, givebackDescription: $givebackDescription)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CautionModel &&
        other.id == id &&
        other.deliveryUserProfile == deliveryUserProfile &&
        other.deliveryDt == deliveryDt &&
        other.item == item &&
        other.receiverUserProfile == receiverUserProfile &&
        other.receiverIsAnalyzingItem == receiverIsAnalyzingItem &&
        other.receiverAnalyzedItemDt == receiverAnalyzedItemDt &&
        other.receiverIsPermanentItem == receiverIsPermanentItem &&
        other.receiverIsStartGiveback == receiverIsStartGiveback &&
        other.receiverGivebackItemDt == receiverGivebackItemDt &&
        other.receiverGivebackDescription == receiverGivebackDescription &&
        other.givebackUserProfile == givebackUserProfile &&
        other.givebackIsAnalyzingItem == givebackIsAnalyzingItem &&
        other.givebackAnalyzedItemDt == givebackAnalyzedItemDt &&
        other.givebackDescription == givebackDescription;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        deliveryUserProfile.hashCode ^
        deliveryDt.hashCode ^
        item.hashCode ^
        receiverUserProfile.hashCode ^
        receiverIsAnalyzingItem.hashCode ^
        receiverAnalyzedItemDt.hashCode ^
        receiverIsPermanentItem.hashCode ^
        receiverIsStartGiveback.hashCode ^
        receiverGivebackItemDt.hashCode ^
        receiverGivebackDescription.hashCode ^
        givebackUserProfile.hashCode ^
        givebackIsAnalyzingItem.hashCode ^
        givebackAnalyzedItemDt.hashCode ^
        givebackDescription.hashCode;
  }
}
