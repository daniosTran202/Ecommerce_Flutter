import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/api/api_service.dart';
import 'package:grocery_app/config.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  static final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool isAsyncCallProgress = false;

  String? fullName;
  String? email;
  String? password;
  String? confirmPassword;
  bool hidePassword = true;
  bool hideConfirmPassword = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ProgressHUD(
          inAsyncCall: isAsyncCallProgress,
          opacity: .3,
          key: UniqueKey(),
          child: Form(
            key: globalKey,
            child: _registerUI(context),
          ),
        ),
      ),
    );
  }

  Widget _registerUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/images/grocery-basket.png",
                  fit: BoxFit.contain,
                  width: 150,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Center(
                child: Text(
                  "Grocery App",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                  ),
                ),
              ),
            ],
          ),
          const Center(
            child: Text(
              "Register",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.deepOrangeAccent),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          FormHelper.inputFieldWidget(
            context,
            "fullName",
            "Full Name",
            (onValidateVal) {
              if (onValidateVal.isEmpty) {
                return "* Requied";
              }

              return null;
            },
            (onSavedVal) {
              fullName = onSavedVal.toString().trim();
            },
            showPrefixIcon: true,
            prefixIcon: const Icon(Icons.face),
            borderRadius: 10,
            contentPadding: 15,
            fontSize: 14,
            prefixIconPaddingLeft: 10,
            borderColor: Colors.grey.shade400,
            prefixIconColor: Colors.black,
            hintColor: Colors.black.withOpacity(.6),
            backgroundColor: Colors.grey.shade100,
            borderFocusColor: Colors.grey.shade200,
          ),
          const SizedBox(
            height: 10,
          ),
          FormHelper.inputFieldWidget(
            context,
            "email",
            "Email",
            (onValidateVal) {
              if (onValidateVal.isEmpty) {
                return "* Requied !";
              }
              bool emailValid = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(onValidateVal);
              if (!emailValid) {
                return "* @Email Format Requied !";
              }

              return null;
            },
            (onSavedVal) {
              email = onSavedVal.toString().trim();
            },
            showPrefixIcon: true,
            prefixIcon: const Icon(Icons.email_outlined),
            borderRadius: 10,
            contentPadding: 15,
            fontSize: 14,
            prefixIconPaddingLeft: 10,
            borderColor: Colors.grey.shade400,
            prefixIconColor: Colors.black,
            hintColor: Colors.black.withOpacity(.6),
            backgroundColor: Colors.grey.shade100,
            borderFocusColor: Colors.grey.shade200,
          ),
          const SizedBox(
            height: 10,
          ),
          FormHelper.inputFieldWidget(
            context,
            "password",
            "Password",
            (onValidateVal) {
              if (onValidateVal.isEmpty) {
                return "* Requied";
              }

              return null;
            },
            (onSavedVal) {
              password = onSavedVal.toString().trim();
            },
            showPrefixIcon: true,
            prefixIcon: const Icon(Icons.password_outlined),
            borderRadius: 10,
            contentPadding: 15,
            fontSize: 14,
            prefixIconPaddingLeft: 10,
            borderColor: Colors.grey.shade400,
            prefixIconColor: Colors.black,
            hintColor: Colors.black.withOpacity(.6),
            backgroundColor: Colors.grey.shade100,
            borderFocusColor: Colors.grey.shade200,
            obscureText: hidePassword,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  hidePassword = !hidePassword;
                });
              },
              color: Colors.redAccent,
              icon:
                  Icon(hidePassword ? Icons.visibility_off : Icons.visibility),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          FormHelper.inputFieldWidget(
            context,
            "confirmPassword",
            "Confirm Password",
            (onValidateVal) {
              if (onValidateVal.isEmpty) {
                return "* Requied";
              }
              // if (onValidateVal.toString().trim() !=
              //     password.toString().trim()) {
              //   return "* Required match to password";
              // }

              return null;
            },
            (onSavedVal) {
              confirmPassword = onSavedVal.toString().trim();
            },
            showPrefixIcon: true,
            prefixIcon: const Icon(Icons.password_outlined),
            borderRadius: 10,
            contentPadding: 15,
            fontSize: 14,
            prefixIconPaddingLeft: 10,
            borderColor: Colors.grey.shade400,
            prefixIconColor: Colors.black,
            hintColor: Colors.black.withOpacity(.6),
            backgroundColor: Colors.grey.shade100,
            borderFocusColor: Colors.grey.shade200,
            obscureText: hideConfirmPassword,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  hideConfirmPassword = !hideConfirmPassword;
                });
              },
              color: Colors.redAccent,
              icon: Icon(hideConfirmPassword
                  ? Icons.visibility_off
                  : Icons.visibility),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: FormHelper.submitButton(
              "Sign-up",
              () {
                if (validateSave()) {
                  setState(() {
                    isAsyncCallProgress = true;
                  });
                  APIService.registerUser(
                    fullName!,
                    email!,
                    password!,
                  ).then((response) {
                    setState(() {
                      isAsyncCallProgress = false;
                    });
                    if (response) {
                      FormHelper.showSimpleAlertDialog(
                        context,
                        Config.appName,
                        "Registration complete successfully",
                        "Okay",
                        () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            "/login",
                            (route) => false,
                          );
                        },
                      );
                    } else {
                      FormHelper.showSimpleAlertDialog(
                        context,
                        Config.appName,
                        "This Email is already registered . Please try again !",
                        "Okay",
                        () {
                          Navigator.of(context).pop();
                        },
                      );
                    }
                  });
                }
              },
              btnColor: Colors.deepOrange,
              borderColor: Colors.white,
              txtColor: Colors.white,
              borderRadius: 20,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
              child: RichText(
            text: TextSpan(
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
              children: <TextSpan>[
                const TextSpan(text: "Already have an account ? "),
                TextSpan(
                  text: "Sign In",
                  style: const TextStyle(
                    color: Colors.deepOrange,
                    fontWeight: FontWeight.bold,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        "/login",
                        (route) => false,
                      );
                    },
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  bool validateSave() {
    final form = globalKey.currentState;
    if (form!.validate()) {
      form.save();
      if (confirmPassword != password) {
        FormHelper.showSimpleAlertDialog(
          context,
          Config.appName,
          "Password does not match!",
          "Okay",
          () {
            Navigator.of(context).pop();
          },
        );
        return false;
      }
      return true;
    } else {
      return false;
    }
  }
}
