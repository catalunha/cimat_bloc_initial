abstract class CautionDeliveryEvent {}

class CautionDeliveryEventItemSubmitted extends CautionDeliveryEvent {
  final String serie;
  final String lote;
  CautionDeliveryEventItemSubmitted({
    required this.serie,
    required this.lote,
  });
}

class CautionDeliveryEventQuantitySubmitted extends CautionDeliveryEvent {
  final String quantity;
  CautionDeliveryEventQuantitySubmitted({
    required this.quantity,
  });
}

class CautionDeliveryEventUserProfileSubmitted extends CautionDeliveryEvent {
  final String userProfileRegister;
  CautionDeliveryEventUserProfileSubmitted({
    required this.userProfileRegister,
  });
}

class CautionDeliveryEventSendOrder extends CautionDeliveryEvent {}
