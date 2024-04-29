import 'package:dartz/dartz.dart';
import 'package:impero_practical_task/utils/type_def.dart';

import '../repo/dashboard_repo_imp.dart';

class DashBoardService {
  DashBoardService() {
    dashboardRepoImp = DashboardRepoImp();
  }

  late final DashboardRepoImp dashboardRepoImp;

  ReturnDataFromApi getDashBoardData(Map<String, dynamic> body) async {
    try {
      return dashboardRepoImp.getDashBoardData(body);
    } catch (e) {
      return const Right("Something went wrong");
    }
  }
}
