import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../../core/repositories/caution_repository.dart';
import 'caution_receiver_event.dart';
import 'caution_receiver_state.dart';

class CautionReceiverBloc
    extends Bloc<CautionReceiverEvent, CautionReceiverState> {
  final CautionRepository _cautionRepository;

  CautionReceiverBloc({required CautionRepository cautionRepository})
      : _cautionRepository = cautionRepository,
        super(CautionReceiverState.initial()) {
    on<CautionReceiverEventGetCautions>(_onCautionReceiverEventGetCautions);
    on<CautionReceiverEventUpdateIsAnalyzingItemWithRefused>(
        _onCautionReceiverEventUpdateIsAnalyzingItemWithRefused);
    on<CautionReceiverEventUpdateIsAnalyzingItemWithAccepted>(
        _onCautionReceiverEventUpdateIsAnalyzingItemWithAccepted);
    on<CautionReceiverEventUpdateIsStartGiveback>(
        _onCautionReceiverEventUpdateIsStartGiveback);
    on<CautionReceiverEventUpdateIsPermanentItem>(
        _onCautionReceiverEventUpdateIsPermanentItem);
  }

  FutureOr<void> _onCautionReceiverEventGetCautions(
      CautionReceiverEventGetCautions event,
      Emitter<CautionReceiverState> emit) {}

  FutureOr<void> _onCautionReceiverEventUpdateIsAnalyzingItemWithRefused(
      CautionReceiverEventUpdateIsAnalyzingItemWithRefused event,
      Emitter<CautionReceiverState> emit) {}

  FutureOr<void> _onCautionReceiverEventUpdateIsAnalyzingItemWithAccepted(
      CautionReceiverEventUpdateIsAnalyzingItemWithAccepted event,
      Emitter<CautionReceiverState> emit) {}

  FutureOr<void> _onCautionReceiverEventUpdateIsStartGiveback(
      CautionReceiverEventUpdateIsStartGiveback event,
      Emitter<CautionReceiverState> emit) {}

  FutureOr<void> _onCautionReceiverEventUpdateIsPermanentItem(
      CautionReceiverEventUpdateIsPermanentItem event,
      Emitter<CautionReceiverState> emit) {}
}
