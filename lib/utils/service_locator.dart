import 'package:get_it/get_it.dart';
import '../network/api_url.dart';
import '../network/network.dart';
import '../screens/service/dashboard_service.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<ApiClient>(ApiClient(ApiUrl.baseUrl));
  getIt.registerSingleton<DashBoardService>(DashBoardService());
}
