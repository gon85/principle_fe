import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:principle_fe/app/data/models/authentications/auth.dart';
import 'package:principle_fe/app/data/models/corps/corparation.dart';
import 'package:principle_fe/app/data/models/creterions/user_creterions_info.dart';
import 'package:principle_fe/app/data/models/errors/response_exception.dart';
import 'package:principle_fe/app/data/providers/rest_api.dart';
import 'package:principle_fe/app/data/repositories/auth/auth_repository.dart';
import 'package:principle_fe/app/data/repositories/corps/corps_repository.dart';
import 'package:principle_fe/app/data/repositories/creterions/creterion_repository.dart';
// import 'package:principle_fe/app/routes/app_pages.dart';
// import 'package:shared_preferences/shared_preferences.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class GlobalController extends GetxController {
  static GlobalController get to => Get.find<GlobalController>();

  GlobalController({required this.authRepo}) {
    _creterionRepo = CreterionRepository(restApi: RestApi());
    _corpsRepo = CorpsRepository(restApi: RestApi());
  }

  final AuthenticationRepository authRepo;
  late final CreterionRepository? _creterionRepo;
  late final CorpsRepository? _corpsRepo;

  final _authStatus = AuthenticationStatus.unknown.obs;
  final _creterionsInfo = UserCreterionsInfo().obs;
  final _corpsList = <Corparation>[].obs;

  AuthenticationStatus get authStatus => _authStatus.value;
  UserCreterionsInfo get creterionsInfo => _creterionsInfo.value;
  List<Corparation> get corpses => _corpsList;

  Future<void> authentificate({
    required String email,
    required String pw,
  }) async {
    try {
      AuthModel am = await authRepo.authentificate(email: email, pw: pw);
      _authStatus.value = AuthenticationStatus.authenticated;
      _creterionRepo?.restApi.accessToken = am.accessToken;
    } on ResponseException catch (er) {
      Fluttertoast.showToast(msg: er.message, toastLength: Toast.LENGTH_LONG);
    } catch (error) {
      Fluttertoast.showToast(msg: '${error.toString()}!!!');
    }
  }

  Future<void> hasToken([int delaySeconds = 0]) async {
    String? token = await authRepo.getToken(delaySeconds);
    if (token != null && token.isEmpty == false) {
      _authStatus.value = AuthenticationStatus.authenticated;
    } else {
      _authStatus.value = AuthenticationStatus.unauthenticated;
    }
  }

  Future<void> init() async {
    await getUserCreterionsInfo();
    await getCorparationInfos();
  }

  Future<void> getUserCreterionsInfo({bool refresh = false}) async {
    try {
      if (refresh || creterionsInfo.creterion == null) {
        UserCreterionsInfo uci = await _creterionRepo!.getUserCreterionsInfo();
        _creterionsInfo.value = uci;
      }
    } on ResponseException catch (er) {
      Fluttertoast.showToast(msg: er.message, toastLength: Toast.LENGTH_LONG);
    } catch (error) {
      Fluttertoast.showToast(msg: '${error.toString()}!!!');
    }
  }

  Future<void> getCorparationInfos({bool refresh = false}) async {
    try {
      if (refresh || corpses.isEmpty) {
        List<Corparation> corpses = await _corpsRepo!.getCorparationInfos();
        _corpsList.value = corpses;
      }
    } on ResponseException catch (er) {
      Fluttertoast.showToast(msg: er.message, toastLength: Toast.LENGTH_LONG);
    } catch (error) {
      Fluttertoast.showToast(msg: '${error.toString()}!!!');
    }
  }
}
