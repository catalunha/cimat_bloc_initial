import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cimat_bloc/app/core/repositories/caution_repository.dart';
import 'package:cimat_bloc/app/core/repositories/item_repository.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../../../../core/models/item_model.dart';
import '../../../../core/repositories/user_profile_repository.dart';
import '../../../../data/b4a/entity/item_entity.dart';
import 'caution_delivery_event.dart';
import 'caution_delivery_state.dart';

class CautionDeliveryBloc
    extends Bloc<CautionDeliveryEvent, CautionDeliveryState> {
  final ItemRepository _itemRepository;
  final UserProfileRepository _userProfileRepository;
  final CautionRepository _cautionRepository;
  CautionDeliveryBloc(
      {required ItemRepository itemRepository,
      required UserProfileRepository userProfileRepository,
      required CautionRepository cautionRepository})
      : _itemRepository = itemRepository,
        _userProfileRepository = userProfileRepository,
        _cautionRepository = cautionRepository,
        super(CautionDeliveryState.initial()) {
    on<CautionDeliveryEventItemSubmitted>(_onCautionDeliveryEventItemSubmitted);
    on<CautionDeliveryEventQuantitySubmitted>(
        _onCautionDeliveryEventQuantitySubmitted);
    on<CautionDeliveryEventUserProfileSubmitted>(
        _onCautionDeliveryEventUserProfileSubmitted);
  }

  FutureOr<void> _onCautionDeliveryEventItemSubmitted(
      CautionDeliveryEventItemSubmitted event,
      Emitter<CautionDeliveryState> emit) async {
    emit(state.copyWith(
      status: CautionDeliveryStateStatus.loading,
      itemList: [],
      quantity: 0,
    ));
    try {
      QueryBuilder<ParseObject> query =
          QueryBuilder<ParseObject>(ParseObject(ItemEntity.className));
      if (event.serie.isNotEmpty) {
        ItemModel? itemModel = await _itemRepository.readBySerie(event.serie);
        if (itemModel != null) {
          emit(state.copyWith(
              status: CautionDeliveryStateStatus.success,
              itemList: [itemModel],
              quantity: 1));
        }
      } else if (event.lote.isNotEmpty) {
        List<ItemModel> itemList = await _itemRepository.readByLote(event.lote);
        emit(state.copyWith(
          status: CautionDeliveryStateStatus.success,
          itemList: itemList,
          quantity: 1,
        ));
      } else {
        throw Exception();
      }
    } catch (_) {
      emit(state.copyWith(
          status: CautionDeliveryStateStatus.error,
          error: 'Erro em buscar item',
          quantity: 0));
    }
  }

  FutureOr<void> _onCautionDeliveryEventQuantitySubmitted(
      CautionDeliveryEventQuantitySubmitted event,
      Emitter<CautionDeliveryState> emit) {}

  FutureOr<void> _onCautionDeliveryEventUserProfileSubmitted(
      CautionDeliveryEventUserProfileSubmitted event,
      Emitter<CautionDeliveryState> emit) {}
}
