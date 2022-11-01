import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:sport_app/model/record.dart';

class TestResultController extends GetxController {
  Record currentRecord = Record();
  String currentState = "up";

  void setCurrentRecord(String state, Record record) {
    currentState = state;
    currentRecord = record;
    update();
  }

  bool checkCurrentState(String state) {
    return currentState == state;
  }
}
