import 'package:dartz/dartz.dart';
import 'package:impero_practical_task/screens/repo/dashboard_repo.dart';

import '../../../network/api_url.dart';
import '../../../network/network.dart';
import '../../utils/service_locator.dart';
import '../../utils/type_def.dart';


class DashboardRepoImp extends DashBoardRepo {
  DashboardRepoImp() {
    _apiClient = getIt.get<ApiClient>();
  }

  late final ApiClient _apiClient;

  @override
  ReturnDataFromApi getDashBoardData(Map<String, dynamic> body) async {
    try {
      final response = await _apiClient.post(ApiUrl.getDashBoard, body: body);
      return Left(response);
    } catch (e) {
      return const Right("Something went wrong");
    }
  }
}
