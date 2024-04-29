import '../../../utils/type_def.dart';

abstract class DashBoardRepo {
  ReturnDataFromApi getDashBoardData(Map<String,dynamic> body);
}
