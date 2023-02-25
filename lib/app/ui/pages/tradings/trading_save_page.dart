import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:principle_fe/app/controllers/global/global_controller.dart';
import 'package:principle_fe/app/controllers/tradings/trading_save_controller.dart';
import 'package:principle_fe/app/data/models/corps/corparation.dart';

class TradingSavePage extends GetView<TradingSaveController> {
  const TradingSavePage({super.key});

  double? getWidth(GlobalKey key) {
    final BuildContext? context = key.currentContext;
    if (context != null && context.findRenderObject() != null) {
      final RenderBox box = context.findRenderObject()! as RenderBox;
      return box.size.width;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: Container(
          padding: const EdgeInsets.all(16),
          child: GetX<TradingSaveController>(
            initState: (state) => TradingSaveController.to,
            builder: (controller) {
              final ttTarget = controller.tradingTrx;
              final List<Corparation> corpses =
                  GlobalController.to.corpses.sublist(0, 10);
              final TextEditingController corpController =
                  TextEditingController();

              final List<DropdownMenuEntry<Corparation>> corpEntries =
                  <DropdownMenuEntry<Corparation>>[];
              for (final Corparation corp in corpses) {
                corpEntries.add(DropdownMenuEntry<Corparation>(
                  value: corp,
                  label: corp.isuAbbrv ?? '',
                  // enabled: color.label != 'Grey'
                ));
              }

              return Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: DropdownMenu<Corparation>(
                          // initialSelection: ColorLabel.green,
                          controller: corpController,
                          label: const Text('Corp'),
                          leadingIcon: const Icon(Icons.search),
                          dropdownMenuEntries: corpEntries,
                          width: getWidth(controller.formKey),
                          menuHeight: 500,
                          // onSelected: (Corparation? color) {
                          //   setState(() {
                          //     selectedColor = color;
                          //   });
                          // },
                        ),
                      ),
                      // DropdownButton(items: items, onChanged: onChanged)
                      // DropdownButtonFormField(items: items, onChanged: onChanged)
                      TextFormField(
                        initialValue: '',
                        decoration: const InputDecoration(labelText: '종목'),
                        validator: (value) {
                          return null;
                        },
                        onSaved: (newValue) {
                          ttTarget.isuSrtCd = newValue;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        initialValue: '',
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: const InputDecoration(labelText: '매수가'),
                        validator: (value) {
                          return null;
                        },
                        onSaved: (newValue) {
                          ttTarget.price = int.parse(newValue ?? '0');
                        },
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                          onPressed: controller.handlePressedSave,
                          child: const Text(
                            '저장',
                            style: TextStyle(fontSize: 20),
                          ))
                    ],
                  ));
            },
          ),
        ));
  }
}
