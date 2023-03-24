abstract class CautionSearchEvent {}

class UserProfileSearchEventNextPage extends CautionSearchEvent {}

class CautionSearchEventPreviousPage extends CautionSearchEvent {}

class CautionSearchEventFormSubmitted extends CautionSearchEvent {
  final bool deliveryDtSelected;
  final DateTime deliveryDtValue;
  CautionSearchEventFormSubmitted({
    required this.deliveryDtSelected,
    required this.deliveryDtValue,
  });
}
