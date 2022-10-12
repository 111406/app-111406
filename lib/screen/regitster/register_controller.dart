import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:sport_app/enum/gender.dart';

class RegisterController extends GetxController {
  bool hypertension = false, hyperglycemia = false, hyperlipidemia = false;
  bool exerciseHabits = false;
  Gender gender = Gender.male;

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
    //TODO gender
    update();
  }
}
