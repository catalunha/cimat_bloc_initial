import 'package:cimat/app/view/pages/utils/app_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogDescription extends StatefulWidget {
  final String title;
  final String formFieldLabel;
  const DialogDescription({
    Key? key,
    required this.title,
    required this.formFieldLabel,
  }) : super(key: key);

  @override
  State<DialogDescription> createState() => _DialogDescriptionState();
}

class _DialogDescriptionState extends State<DialogDescription> {
  final _formKey = GlobalKey<FormState>();
  final _objectIdTEC = TextEditingController();
  @override
  void initState() {
    super.initState();
    _objectIdTEC.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(widget.title),
                AppTextFormField(
                  label: widget.formFieldLabel,
                  controller: _objectIdTEC,
                  // validator:
                  //     Validatorless.required('Esta informação é necessária'),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancelar')),
                    const SizedBox(
                      width: 50,
                    ),
                    TextButton(
                        onPressed: () async {
                          final formValid =
                              _formKey.currentState?.validate() ?? false;
                          if (formValid) {
                            Get.back(result: _objectIdTEC.text);
                          }
                        },
                        child: const Text('Devolver')),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
