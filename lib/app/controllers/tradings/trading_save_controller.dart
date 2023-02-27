import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:principle_fe/app/controllers/global/global_controller.dart';
import 'package:principle_fe/app/controllers/tradings/trading_controller.dart';
import 'package:principle_fe/app/data/models/corps/corparation.dart';
import 'package:principle_fe/app/data/models/errors/response_exception.dart';
import 'package:principle_fe/app/data/models/tradings/trading_info.dart';
import 'package:principle_fe/app/data/models/tradings/trading_trx.dart';
import 'package:principle_fe/app/data/repositories/tradings/trading_repository.dart';
import 'package:principle_fe/app/ui/components/dropdowns/dropdown_searchable.dart';
import 'package:principle_fe/utils/logs/logger.dart';

class TradingSaveController extends GetxController {
  static TradingSaveController get to => Get.find<TradingSaveController>();

  TradingSaveController({required this.tradingRepo});

  final TradingRepository tradingRepo;

  final formKey = GlobalKey<FormState>();
  final title = '매매입력'.obs;
  final corpController = TextEditingController();

  final _tradingTypeName = ''.obs;
  final _tradingTrx = TradingTrx().obs;
  final _corpEntries = <DropdownEntry<Corparation>>[].obs;

  TradingTrx get tradingTrx {
    return _tradingTrx.value;
  }

  String get tradingTypeName {
    return _tradingTypeName.value;
  }

  List<DropdownEntry<Corparation>> get corpEntries {
    return _corpEntries;
  }

  void _changeTextCorp() {
    logger.i('->${corpController.text}');
    try {
      final corpses = GlobalController.to.corpses
          .where((corp) => corp.isuAbbrv!.contains(corpController.text))
          .toList();
      final corpTarget =
          corpses.length <= 10 ? corpses : corpses.sublist(0, 10);

      final List<DropdownEntry<Corparation>> corpEntries =
          <DropdownEntry<Corparation>>[];
      for (final Corparation corp in corpTarget) {
        corpEntries.add(DropdownEntry<Corparation>(
          value: corp,
          label: corp.isuAbbrv ?? '',
          // enabled: color.label != 'Grey'
        ));
      }
      _corpEntries.value = corpEntries;
    } catch (e) {
      logger.e(e);
    }
  }

  void changeTradingType(tt) {
    tradingTrx.tradingTypeCd = tt.code;
    _tradingTypeName.value = tt.displayName;
  }

  @override
  void onInit() {
    super.onInit();
    corpController.addListener(_changeTextCorp);
  }

  @override
  void dispose() {
    super.dispose();
    corpController.removeListener(_changeTextCorp);
  }

  @override
  void onReady() async {
    super.onReady();
    final List<Corparation> corpses =
        GlobalController.to.corpses.sublist(0, 10);
    final List<DropdownEntry<Corparation>> corpEntries =
        <DropdownEntry<Corparation>>[];
    for (final Corparation corp in corpses) {
      corpEntries.add(DropdownEntry<Corparation>(
        value: corp,
        label: corp.isuAbbrv ?? '',
        // enabled: color.label != 'Grey'
      ));
    }
    _corpEntries.value = corpEntries;
  }

  void handlePressedSave() async {
    final form = formKey.currentState;
    if (form?.validate() == null) return;
    formKey.currentState?.save();
    tradingTrx.tradingAt =
        '${tradingTrx.tradingDate} ${tradingTrx.tradingTime}';

    await saveTradingTrx();
  }

  Future<void> saveTradingTrx() async {
    try {
      TradingInfo tiTarget =
          await tradingRepo.saveTradingTrx(_tradingTrx.value);
      TradingController.to.tradingInfo.value = tiTarget;
    } on ResponseException catch (er) {
      Fluttertoast.showToast(msg: er.message, toastLength: Toast.LENGTH_LONG);
    } catch (error) {
      Fluttertoast.showToast(msg: '${error.toString()}!!!');
    }
  }
}
