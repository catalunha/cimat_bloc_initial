import 'package:cimat_bloc/app/core/models/caution_model.dart';
import 'package:cimat_bloc/app/core/models/user_profile_model.dart';

abstract class CautionReceiverEvent {}

class CautionReceiverEventGetCautions extends CautionReceiverEvent {
  final UserProfileModel userProfileModel;
  CautionReceiverEventGetCautions({
    required this.userProfileModel,
  });
}

class CautionReceiverEventUpdateIsAnalyzingItemWithRefused
    extends CautionReceiverEvent {
  final CautionModel cautionModel;

  CautionReceiverEventUpdateIsAnalyzingItemWithRefused(this.cautionModel);
}

class CautionReceiverEventUpdateIsAnalyzingItemWithAccepted
    extends CautionReceiverEvent {
  final CautionModel cautionModel;

  CautionReceiverEventUpdateIsAnalyzingItemWithAccepted(this.cautionModel);
}

class CautionReceiverEventUpdateIsStartGiveback extends CautionReceiverEvent {
  final CautionModel cautionModel;
  final String description;

  CautionReceiverEventUpdateIsStartGiveback(
      this.cautionModel, this.description);
}

class CautionReceiverEventUpdateIsPermanentItem extends CautionReceiverEvent {
  final CautionModel cautionModel;
  final bool value;
  CautionReceiverEventUpdateIsPermanentItem({
    required this.cautionModel,
    required this.value,
  });
}
