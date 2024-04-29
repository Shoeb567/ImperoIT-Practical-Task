import 'package:get/get.dart';
import 'package:impero_practical_task/model/dashboard_model.dart';
import 'package:impero_practical_task/screens/service/dashboard_service.dart';

import '../../utils/service_locator.dart';


class DashBoardController extends GetxController {
  var isLoading = false.obs;
  DashBoardModel? dashBoardModel;
  late final DashBoardService dashBoardService;

  @override
  Future<void> onInit() async {
    super.onInit();
    dashBoardService = getIt.get<DashBoardService>();
    getDashBoardData();
  }

  /// fetching dash-board data
  void getDashBoardData() async {
    Map<String, dynamic> body = {};
    body['CategoryId'] = 0;
    body['DeviceManufacturer'] = 'Google';
    body['DeviceModel'] = 'Android SDK built for x86';
    body['DeviceToken'] = '';
    body['PageIndex'] = 1;
    isLoading(true);
    final data = await dashBoardService.getDashBoardData(body);
    data.fold((l) {
      dashBoardModel = DashBoardModel.fromJson(l);
      isLoading(false);
    }, (r) {
      isLoading(false);
    });
  }
}
