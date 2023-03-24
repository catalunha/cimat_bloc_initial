import 'package:cimat/app/view/controllers/caution/receiver/caution_receiver_controller.dart';
import 'package:cimat/app/view/pages/caution/receiver/caution_receiver_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CautionReceiverPage extends StatefulWidget {
  final _cautionReceiverController = Get.find<CautionReceiverController>();

  CautionReceiverPage({super.key});

  @override
  State<CautionReceiverPage> createState() => _CautionReceiverPageState();
}

class _CautionReceiverPageState extends State<CautionReceiverPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
              'Itens temporários: ${widget._cautionReceiverController.cautionList.length}'),
        ),
      ),
      body: FutureBuilder(
          future: widget._cautionReceiverController.getCurrentCautions(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              // UserProfileModel userProfileModel = snapshot.data!;

              return Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 600,
                        child: Obx(
                          () => ListView.builder(
                            itemCount: widget
                                ._cautionReceiverController.cautionList.length,
                            itemBuilder: (context, index) {
                              final cautionModel = widget
                                  ._cautionReceiverController
                                  .cautionList[index];
                              return CautionReceiverCard(
                                cautionModel: cautionModel,
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          }),

      // body: SingleChildScrollView(
      //   child: Column(
      //     children: [
      //       SizedBox(
      //         height: 600,
      //         child: Obx(
      //           () => ListView.builder(
      //             itemCount:
      //                 widget._cautionReceiverController.cautionList.length,
      //             itemBuilder: (context, index) {
      //               final cautionModel =
      //                   widget._cautionReceiverController.cautionList[index];
      //               return CautionReceiverCard(
      //                 cautionModel: cautionModel,
      //               );
      //             },
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
