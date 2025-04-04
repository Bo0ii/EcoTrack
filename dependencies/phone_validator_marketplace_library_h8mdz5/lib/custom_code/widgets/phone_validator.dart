// Automatic FlutterFlow imports
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:intl_phone_number_input/intl_phone_number_input.dart'
    as intl_phone;
import 'package:dlibphonenumber/dlibphonenumber.dart' as dlib;

class PhoneValidator extends StatefulWidget {
  const PhoneValidator(
      {Key? key,
      this.width,
      this.height,
      this.borderColor,
      this.fillColor,
      this.errorBorderColor,
      this.selectedBorderColor,
      this.fontSize,
      this.fontColor,
      this.hintText,
      this.hintFontColor,
      required this.actionOnType,
      required this.actionOnValid,
      required this.actionOnInvalid,
      this.borderRadius,
      this.initialCountry,
      this.borderWidth})
      : super(key: key);

  final double? width;
  final double? height;
  final Color? borderColor;
  final Color? fillColor;
  final Color? errorBorderColor;
  final Color? selectedBorderColor;
  final double? fontSize;
  final Color? fontColor;
  final String? hintText;
  final Color? hintFontColor;
  final Future Function(String inputText) actionOnType;
  final Future Function() actionOnValid;
  final Future Function(String? errorMessage) actionOnInvalid;
  final double? borderRadius;
  final String? initialCountry;
  final double? borderWidth;

  @override
  State<PhoneValidator> createState() => _PhoneValidatorState();
}

class _PhoneValidatorState extends State<PhoneValidator> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();
  String initialCountry = 'US';
  intl_phone.PhoneNumber number = intl_phone.PhoneNumber(isoCode: 'US');
  String? _phoneNumberError;
  final dlib.PhoneNumberUtil _phoneUtil = dlib.PhoneNumberUtil.instance;

  @override
  void initState() {
    super.initState();
    initialCountry = widget.initialCountry ?? 'US';
    number = intl_phone.PhoneNumber(isoCode: initialCountry);
  }

  void _validatePhoneNumber(intl_phone.PhoneNumber phoneNumber) async {
    if (phoneNumber.phoneNumber == null || phoneNumber.phoneNumber!.isEmpty) {
      setState(() {
        _phoneNumberError = 'Phone number is required';
      });
      await widget.actionOnInvalid(_phoneNumberError);
      return;
    }

    try {
      final parsedPhoneNumber =
          await _phoneUtil.parse(phoneNumber.phoneNumber!, phoneNumber.isoCode);

      // Call actionOnType with the current input (including area code)
      String currentInput = await _phoneUtil.format(
          parsedPhoneNumber, dlib.PhoneNumberFormat.e164);

      await widget.actionOnType(currentInput);

      final isValid = await _phoneUtil.isValidNumber(parsedPhoneNumber);
      setState(() {
        _phoneNumberError = isValid ? null : 'Invalid phone number';
      });

      if (isValid) {
        // Call actionOnValid when the number is valid
        await widget.actionOnValid();
      } else {
        await widget.actionOnInvalid(_phoneNumberError);
      }
    } catch (e) {
      setState(() {
        _phoneNumberError = 'Invalid phone number';
      });
      await widget.actionOnInvalid(_phoneNumberError);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: Form(
        key: formKey,
        child: intl_phone.InternationalPhoneNumberInput(
          onInputChanged: (intl_phone.PhoneNumber number) {
            _validatePhoneNumber(number);
          },
          selectorConfig: intl_phone.SelectorConfig(
            selectorType: intl_phone.PhoneInputSelectorType.DIALOG,
            showFlags: true,
          ),
          ignoreBlank: false,
          autoValidateMode: AutovalidateMode.disabled,
          selectorTextStyle: TextStyle(color: widget.fontColor ?? Colors.black),
          initialValue: number,
          textFieldController: controller,
          formatInput: false, // Disable asYouTypeFormatter
          keyboardType:
              TextInputType.numberWithOptions(signed: true, decimal: true),
          inputBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: widget.borderColor ?? Colors.grey,
              width: widget.borderWidth ?? 0.0,
            ),
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 0.0),
          ),
          inputDecoration: InputDecoration(
            hintText: widget.hintText ?? 'Phone Number',
            hintStyle: TextStyle(color: widget.hintFontColor ?? Colors.grey),
            fillColor: widget.fillColor ?? Colors.white,
            filled: true,
            errorText: _phoneNumberError,
            errorStyle: TextStyle(color: widget.errorBorderColor ?? Colors.red),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: widget.selectedBorderColor ?? Colors.blue,
                width: widget.borderWidth ?? 1.0,
              ),
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 0.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: widget.borderColor ?? Colors.grey,
                width: widget.borderWidth ?? 1.0,
              ),
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 0.0),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: widget.errorBorderColor ?? Colors.red,
                width: widget.borderWidth ?? 1.0,
              ),
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 0.0),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: widget.errorBorderColor ?? Colors.red,
                width: widget.borderWidth ?? 1.0,
              ),
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 0.0),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          ),
          textStyle: TextStyle(
            fontSize: widget.fontSize ?? 16.0,
            color: widget.fontColor ?? Colors.black,
          ),
          selectorButtonOnErrorPadding: 16,
          spaceBetweenSelectorAndTextField: 0,
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
