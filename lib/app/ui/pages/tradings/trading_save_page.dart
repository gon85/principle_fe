import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:principle_fe/app/controllers/tradings/trading_save_controller.dart';
import 'package:principle_fe/app/data/models/corps/corparation.dart';
import 'package:principle_fe/app/data/models/tradings/trading_trx.dart';
import 'package:principle_fe/app/ui/components/formatters/datetime_formatters.dart';
import 'package:principle_fe/app/ui/components/formfields/dropdown_searchable_formfield.dart';
import 'package:principle_fe/utils/logs/logger.dart';

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
          title: Text('${controller.title}'),
        ),
        body: Container(
          padding: const EdgeInsets.all(16),
          child: GetX<TradingSaveController>(
            initState: (state) => TradingSaveController.to,
            builder: (controller) {
              final ttTarget = controller.tradingTrx;
              return Form(
                  key: controller.formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      DropdownSearchableFormField<Corparation>(
                        controller: controller.corpController,
                        label: const Text('종목'),
                        leadingIcon: const Icon(Icons.search),
                        dropdownMenuEntries: controller.corpEntries,
                        menuHeight: 500,
                        validator: (value) {
                          if (value == null) {
                            return '종목은 필수 값 입니다.';
                          }
                          return null;
                        },
                        onSaved: (newVal) {
                          controller.tradingTrx.isuSrtCd = newVal?.isuSrtCd;
                        },
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField(
                          decoration: const InputDecoration(
                              labelText: '매매구분', hintText: '매수/매도'),
                          items: TradingTypes.getDropdownMenuItems(),
                          onChanged: controller.changeTradingType),
                      const SizedBox(height: 10),
                      TextFormField(
                        initialValue: '',
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                            labelText: '${controller.tradingTypeName}가'),
                        validator: (value) {
                          if (value == null) {
                            return '필수 값 입니다.';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          ttTarget.price = int.parse(newValue ?? '0');
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        initialValue: '',
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: const InputDecoration(labelText: '수량'),
                        validator: (value) {
                          if (value == null) {
                            return '종목은 필수 값 입니다.';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          ttTarget.cnt = int.parse(newValue ?? '0');
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        initialValue: '',
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: '${controller.tradingTypeName}일'),
                        inputFormatters: [
                          DateFormatter(sample: 'YYYY-MM-DD', separator: '-')
                        ],
                        validator: (value) {
                          if (value == null) return null;
                          String chk = '2023-01-01'.substring(value.length);
                          try {
                            DateFormat('yyyy-MM-dd').parseStrict('$value$chk');
                          } catch (e) {
                            logger.e(e);
                            return '유효한 날짜형식이 아닙니다. (YYYY-MM-DD)';
                          }
                          return null;
                        },
                        onChanged: (value) {},
                        onSaved: (newValue) {
                          ttTarget.tradingDate = newValue;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        initialValue: '',
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText:
                                '${controller.tradingTypeName}시간(option)'),
                        inputFormatters: [
                          TimeFormatter(sample: 'hh:mm:ss', separator: ':')
                        ],
                        validator: (value) {
                          if (value == null) return null;
                          String chk = '00:00:00'.substring(value.length);
                          try {
                            logger.i('-->$value$chk');
                            DateFormat('hh:mm:ss').parseStrict('$value$chk');
                          } catch (e) {
                            logger.e(e);
                            return '유효한 시간형식이 아닙니다. (hh:mm:ss)';
                          }
                          return null;
                        },
                        onChanged: (value) {},
                        onSaved: (newValue) {
                          ttTarget.tradingTime = newValue;
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
