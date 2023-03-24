import 'package:cimat/app/core/models/caution_model.dart';
import 'package:cimat/app/view/controllers/caution/receiver/caution_receiver_controller.dart';
import 'package:cimat/app/view/pages/caution/receiver/dialog_description.dart';
import 'package:cimat/app/view/pages/utils/app_photo_show.dart';
import 'package:cimat/app/view/pages/utils/app_text_title_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CautionReceiverCard extends StatefulWidget {
  final _cautionReceiverController = Get.find<CautionReceiverController>();
  final CautionModel cautionModel;
  CautionReceiverCard({Key? key, required this.cautionModel}) : super(key: key);

  @override
  State<CautionReceiverCard> createState() => _CautionReceiverCardState();
}

class _CautionReceiverCardState extends State<CautionReceiverCard> {
  @override
  Widget build(BuildContext context) {
    // final dateFormat = DateFormat('dd/MM/y HH:mm');
    return Card(
      child: Column(
        children: [
          AppTextTitleValue(
            title: 'Id: ',
            value: widget.cautionModel.id,
          ),
          Wrap(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppImageShow(
                photoUrl: widget.cautionModel.deliveryUserProfile!.photo,
                height: 125,
                // width: 150,
              ),
              AppImageShow(
                photoUrl: widget.cautionModel.item!.image?.url,
                height: 125,
                width: 300,
              ),
            ],
          ),
          Text(
            '${widget.cautionModel.item!.description}',
            style: const TextStyle(fontSize: 18),
          ),
          Text(
            '${widget.cautionModel.item!.serie == null || widget.cautionModel.item!.serie!.isEmpty ? '...' : widget.cautionModel.item!.serie} | ${widget.cautionModel.item!.lote == null || widget.cautionModel.item!.lote!.isEmpty ? '...' : widget.cautionModel.item!.lote}',
            style: const TextStyle(fontSize: 22),
          ),
          // AppTextTitleValue(
          //   title: 'Item: ',
          //   value: widget.cautionModel.item!.description,
          // ),
          // AppTextTitleValue(
          //   title: 'Entregue por: ',
          //   value: widget.cautionModel.deliveryUserProfile!.nickname!,
          // ),
          // AppTextTitleValue(
          //   title: 'Entregue em: ',
          //   value: dateFormat.format(widget.cautionModel.deliveryDt!),
          // ),
          AppTextTitleValue(
            title: 'Observações para cautela: ',
            value: widget.cautionModel.item!.obsCaution,
            inColumn: true,
          ),
          // AppTextTitleValue(
          //   title: 'Cautelado a: ',
          //   value: widget.cautionModel.receiverUserProfile!.nickname!,
          // ),
          // AppTextTitleValue(
          //   title: 'Situação da análise ? ',
          //   value: widget.cautionModel.receiverIsAnalyzingItem == null
          //       ? 'Analisando'
          //       : widget.cautionModel.receiverIsAnalyzingItem == true
          //           ? 'Aceito'
          //           : 'Recusado',
          // ),
          // AppTextTitleValue(
          //   title: 'Analisado em: ',
          //   value: widget.cautionModel.receiverAnalyzedItemDt == null
          //       ? '...'
          //       : dateFormat
          //           .format(widget.cautionModel.receiverAnalyzedItemDt!),
          // ),
          // AppTextTitleValue(
          //   title: 'Em item permanente ? ',
          //   value: widget.cautionModel.receiverIsPermanentItem == false
          //       ? 'Não'
          //       : 'Sim',
          // ),
          // AppTextTitleValue(
          //   title: 'Situação da devolução ? ',
          //   value: widget.cautionModel.receiverIsStartGiveback == null
          //       ? 'Analisando'
          //       : widget.cautionModel.receiverIsStartGiveback == false
          //           ? 'Nao devolver. Em uso.'
          //           : 'Devolução iniciada',
          // ),
          // AppTextTitleValue(
          //   title: 'Devolvido em: ',
          //   value: widget.cautionModel.receiverGivebackItemDt == null
          //       ? '...'
          //       : dateFormat
          //           .format(widget.cautionModel.receiverGivebackItemDt!),
          // ),
          // AppTextTitleValue(
          //   title: 'Descrição da devolução: ',
          //   value: widget.cautionModel.receiverGivebackDescription,
          //   inColumn: true,
          // ),
          // AppTextTitleValue(
          //   title: 'Recebido por: ',
          //   value: widget.cautionModel.givebackUserProfile?.nickname,
          // ),
          // AppTextTitleValue(
          //   title: 'Situação da recebimento ? ',
          //   value: widget.cautionModel.receiverIsStartGiveback != true
          //       ? '...'
          //       : widget.cautionModel.givebackIsAnalyzingItem == null
          //           ? 'Analisando'
          //           : widget.cautionModel.givebackIsAnalyzingItem == false
          //               ? 'Com observações.'
          //               : 'Normal',
          // ),
          // AppTextTitleValue(
          //   title: 'Recebido em: ',
          //   value: widget.cautionModel.givebackAnalyzedItemDt == null
          //       ? '...'
          //       : dateFormat
          //           .format(widget.cautionModel.givebackAnalyzedItemDt!),
          // ),
          // AppTextTitleValue(
          //   title: 'Descrição do recebimento: ',
          //   value: widget.cautionModel.givebackDescription,
          // ),
          Wrap(
            children: [
              if (widget.cautionModel.receiverIsAnalyzingItem == null)
                IconButton(
                  onPressed: () async {
                    await widget._cautionReceiverController
                        .updatereceiverIsAnalyzingItemWithRefused(
                            widget.cautionModel);
                    String? res = await showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (_) {
                        return const DialogDescription(
                          title: 'Descrição',
                          formFieldLabel: '',
                        );
                      },
                    );
                    if (res != null) {
                      widget._cautionReceiverController
                          .updatereceiverIsStartGiveback(
                              widget.cautionModel, res);
                    }
                    // setState(() {});
                  },
                  icon: const Icon(
                    Icons.not_interested,
                  ),
                ),
              if (widget.cautionModel.receiverIsAnalyzingItem == null)
                IconButton(
                  onPressed: () {
                    // Get.toNamed(Routes.itemAddEdit, arguments: cautionModel);
                    widget._cautionReceiverController
                        .updatereceiverIsAnalyzingItemWithAccepted(
                            widget.cautionModel);
                  },
                  icon: const Icon(
                    Icons.check_outlined,
                  ),
                ),
              if (widget.cautionModel.receiverIsStartGiveback == false)
                IconButton(
                  onPressed: () async {
                    String? res = await showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) {
                        return const DialogDescription(
                          title: 'Descrição',
                          formFieldLabel: '',
                        );
                      },
                    );
                    if (res != null) {
                      widget._cautionReceiverController
                          .updatereceiverIsStartGiveback(
                              widget.cautionModel, res);
                    }
                    // setState(() {});
                  },
                  icon: const Icon(
                    Icons.assignment_return,
                  ),
                ),
              if (widget.cautionModel.receiverIsPermanentItem == false &&
                  widget.cautionModel.receiverIsAnalyzingItem == true)
                IconButton(
                  onPressed: () {
                    // Get.toNamed(Routes.itemAddEdit, arguments: cautionModel);
                    widget._cautionReceiverController
                        .updateReceiverIsPermanentItem(
                            widget.cautionModel, true);
                  },
                  icon: const Icon(
                    Icons.person,
                  ),
                ),
              if (widget.cautionModel.receiverIsPermanentItem == true &&
                  widget.cautionModel.receiverIsAnalyzingItem == true)
                IconButton(
                  onPressed: () {
                    // Get.toNamed(Routes.itemAddEdit, arguments: cautionModel);
                    widget._cautionReceiverController
                        .updateReceiverIsPermanentItem(
                            widget.cautionModel, false);
                  },
                  icon: const Icon(
                    Icons.person_off,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  copy(String text) async {
    Get.snackbar(text, 'Id copiado.',
        margin: const EdgeInsets.all(10), duration: const Duration(seconds: 1));
    await Clipboard.setData(ClipboardData(text: text));
  }
}
