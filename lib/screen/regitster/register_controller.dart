import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class RegisterController extends GetxController {
  bool hypertension = false, // 高血壓
      hyperglycemia = false, // 高血糖
      hyperlipidemia = false; // 高血脂
  bool exerciseHabits = false;
  bool gender = false;

  void setHypertension(bool _hypertension) {
    hypertension = _hypertension;
    update();
  }

  void setHyperglycemia(bool _hyperglycemia) {
    hyperglycemia = _hyperglycemia;
    update();
  }

  void setHyperlipidemia(bool _hyperlipidemia) {
    hyperlipidemia = _hyperlipidemia;
    update();
  }

  void setExerciseHabits(bool _exerciseHabits) {
    exerciseHabits = _exerciseHabits;
    update();
  }

  void setGender(bool _gender) {
    gender = _gender;
    update();
  }
}
