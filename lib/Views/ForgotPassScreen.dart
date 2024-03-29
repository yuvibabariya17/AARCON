import 'package:aarcon/Controllers/InternetController.dart';
import 'package:aarcon/Models/login_form_validation.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  final InternetController networkManager = Get.find<InternetController>();
  final resetpasskey = GlobalKey<FormState>();

  late FocusNode currentpassNode;
  late FocusNode newpassNode;
  late FocusNode confirmpassNode;

  late TextEditingController currentCtr;
  late TextEditingController newpassCtr;
  late TextEditingController confirmCtr;

  var currentPassModel = ValidationModel(null, null, isValidate: false).obs;
  var newPassModel = ValidationModel(null, null, isValidate: false).obs;
  var confirmPassModel = ValidationModel(null, null, isValidate: false).obs;

//  Rx<ScreenState> states = ScreenState.apiLoading.obs;
  RxString message = "".obs;
  RxString mobile = "".obs;

  RxBool isFormInvalidate = false.obs;
  RxBool isForgotPasswordValidate = false.obs;
  RxBool isObsecureText = true.obs;

  RxBool obsecureOldPasswordText = true.obs;
  RxBool obsecureNewPasswordText = true.obs;
  RxBool obsecureConfirmPasswordText = true.obs;

  @override
  void onInit() {
    currentpassNode = FocusNode();
    newpassNode = FocusNode();
    confirmpassNode = FocusNode();

    currentCtr = TextEditingController();
    newpassCtr = TextEditingController();
    confirmCtr = TextEditingController();

    super.onInit();
  }

  void validateCurrentPass(String? val) {
    currentPassModel.update((model) {
      if (val != null && val.toString().trim().isEmpty) {
        model!.error = "Enter Current Password";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validateNewPass(String? val) {
    newPassModel.update((model) {
      if (val != null && val.toString().trim().isEmpty) {
        model!.error = "Enter New Password";
        model.isValidate = false;
      } else if (val.toString().trim().length <= 7) {
        model!.error = "Enter Valid Password";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
      if (confirmCtr.text.toString().isNotEmpty) {
        if (val.toString().trim() != confirmCtr.text.toString().trim()) {
          confirmPassModel.update((model1) {
            model1!.error = "Password Not Match";
            model1.isValidate = false;
          });
        } else {
          confirmPassModel.update((model1) {
            model1!.error = null;
            model1.isValidate = true;
          });
        }
      }
    });

    enableSignUpButton();
  }

  void validateConfirmPass(String? val) {
    confirmPassModel.update((model) {
      if (val != null && val.toString().trim().isEmpty) {
        model!.error = "Enter Confirm Password";
        model.isValidate = false;
      } else if (val.toString().trim() != newpassCtr.text.toString().trim()) {
        model!.error = "Password Not Match";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validateNewPassword(String? val) {
    newPassModel.update((model) {
      if (val != null && val.toString().trim().isEmpty) {
        model!.error = "Enter New Password";
        model.isValidate = false;
      } else if (val.toString().trim().length <= 7) {
        model!.error = "Enter Valid Password";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });
    if (confirmCtr.text.toString().isNotEmpty) {
      if (val.toString().trim() != confirmCtr.text.toString().trim()) {
        confirmPassModel.update((model1) {
          model1!.error = "Password Not Match";
          model1.isValidate = false;
        });
      } else {
        confirmPassModel.update((model1) {
          model1!.error = null;
          model1.isValidate = true;
        });
      }
    }

    enableForgotButton();
  }

  void validateForgotPass(String? val) {
    confirmPassModel.update((model) {
      if (val != null && val.toString().trim().isEmpty) {
        model!.error = "Enter Confirm Password";
        model.isValidate = false;
      } else if (val.toString().trim() != newpassCtr.text.toString().trim()) {
        model!.error = "Password Not Match";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableForgotButton();
  }

  void enableSignUpButton() {
    if (currentPassModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (newPassModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (confirmPassModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else {
      isFormInvalidate.value = true;
    }
  }

  void enableForgotButton() {
    if (newPassModel.value.isValidate == false) {
      isForgotPasswordValidate.value = false;
    } else if (confirmPassModel.value.isValidate == false) {
      isForgotPasswordValidate.value = false;
    } else {
      isForgotPasswordValidate.value = true;
    }
  }

  // void ResetPassApi(context, bool fromProfile) async {
  //   var loadingIndicator = LoadingProgressDialog();
  //   loadingIndicator.show(context, 'RESET PASSWORD');

  //   try {
  //     if (networkManager.connectionType == 0) {
  //       loadingIndicator.hide(context);
  //       showDialogForScreen(context, Connection.noConnection, callback: () {});
  //       return;
  //     }
  //     logcat("CHANGE PASS", {
  //       "password": currentCtr.text.toString().trim(),
  //       "new_password": newpassCtr.text.toString().trim(),
  //       "confirm_password": confirmCtr.text.toString().trim()
  //     });

  //     var response = await Repository.post({
  //       "password": currentCtr.text.toString().trim(),
  //       "new_password": newpassCtr.text.toString().trim(),
  //       "confirm_password": confirmCtr.text.toString().trim()
  //     }, ApiUrl.resetpass, allowHeader: true);
  //     loadingIndicator.hide(context);
  //     logcat("PasswordResponse", response.body);
  //     var data = jsonDecode(response.body);

  //     if (response.statusCode == 200) {
  //       if (data['status'] == 1) {
  //         showDialogForScreen(context, data['message'].toString(),
  //             callback: () {
  //           if (fromProfile) {
  //             Get.back();
  //           } else {
  //             Get.to(dashboard());
  //           }
  //         });
  //       } else {
  //         showDialogForScreen(context, data['message'].toString(),
  //             callback: () {});
  //       }
  //     } else {
  //       states.value = ScreenState.apiError;
  //       showDialogForScreen(context, data['message'].toString(),
  //           callback: () {});
  //     }
  //   } catch (e) {
  //     logcat("Exception", e);
  //     loadingIndicator.hide(context);
  //     ResetPassApi(context, fromProfile);
  //   }
  // }

  void hideKeyboard(context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  // showDialogForScreen(context, String message, {Function? callback}) {
  //   showMessage(
  //       context: context,
  //       callback: () {
  //         if (callback != null) {
  //           callback();
  //         }
  //         return true;
  //       },
  //       message: message,
  //       title: ScreenTitle.changePassTitle,
  //       negativeButton: '',
  //       positiveButton: CommonConstant.continuebtn);
  // }
}
