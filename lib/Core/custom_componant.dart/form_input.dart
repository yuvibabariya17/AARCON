import 'package:aarcon/Core/custom_componant.dart/custom_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

enum FieldType { Email, Mobile, Text, DropDownl }

Widget getReactiveFormField(
    {required node,
    required controller,
    required hintLabel,
    required void Function(String? val) onChanged,
    String? errorText,
    List<TextInputFormatter>? inputFormatters,
    required TextInputType inputType,
    FieldType? formType,
    Function? onVerifyButtonClick,
    bool? isVerified,
    bool? wantSuffix,
    bool? time,
    bool? isPhoto,
    bool? isDropdown,
    bool? isReadOnly,
    bool? isDataValidated,
    Function? onAddBtn,
    bool? isdown,
    bool? isCalender,
    bool? isPassword,
    bool? isAdd,
    Function? onTap,
    bool isExpand = false,
    String? fromObsecureText,
    bool isFromAddStory = false,
    bool isFromIntro = false,
    final String? index,
    bool isEnable = true}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 1.2.h),
    child: CustomFormField(
        hintText: hintLabel,
        errorText: errorText,
        node: node,
        isExpand: isExpand,
        inputFormatters: inputFormatters,
        onChanged: onChanged,
        inputType: inputType,
        formType: formType,
        controller: controller,
        onVerifiyButtonClick: onVerifyButtonClick,
        isVerified: isVerified,
        time: time,
        isDropdown: isDropdown,
        isCalender: isCalender,
        wantSuffix: wantSuffix,
        isReadOnly: isReadOnly,
        isPassword: isPassword,
        isAdd: isAdd,
        onTap: onTap,
        isdown: isdown,
        index: index,
        onAddBtn: onAddBtn,
        fromObsecureText: fromObsecureText,
        isFromAddStory: isFromAddStory,
        isEnable: isEnable),
  );
}
