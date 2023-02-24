import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:principle_fe/app/data/models/commons/page_info.dart';
import 'package:principle_fe/app/data/models/errors/response_exception.dart';
import 'package:principle_fe/app/data/models/tradings/trading_info.dart';
import 'package:principle_fe/app/data/models/tradings/trading_mst.dart';
import 'package:principle_fe/app/data/repositories/tradings/trading_repository.dart';

class TradingController extends GetxController {
  static TradingController get to => Get.find<TradingController>();

  TradingController({required this.tradingRepo});

  final TradingRepository tradingRepo;
  final title = '매매관리'.obs;
  final tradingInfo =
      TradingInfo(list: [], pageInfo: PageInfo.defaultInstance).obs;

  List<TradingMst> get tradings {
    return tradingInfo.value.list;
  }

  @override
  void onReady() async {
    super.onReady();

    await getTradingInfos();
  }

  Future<void> getTradingInfos({bool refresh = false}) async {
    try {
      TradingInfo tiTarget = await tradingRepo.getTradingInfos();
      tradingInfo.value = tiTarget;
    } on ResponseException catch (er) {
      Fluttertoast.showToast(msg: er.message, toastLength: Toast.LENGTH_LONG);
    } catch (error) {
      Fluttertoast.showToast(msg: '${error.toString()}!!!');
    }
  }
}
