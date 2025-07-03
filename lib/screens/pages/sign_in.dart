import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:go_router/go_router.dart';

import '../../utils/enumerations.dart';
import '../../utils/functions.dart';
import '../../utils/languages/constants.dart';
import '../widgets/form_helper.dart';
import '../widgets/loading.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isSync = false;
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  bool _hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LoadingPage(isAsync: isSync, child: _signInForm()),
      ),
    );
  }

  Widget _signInForm() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${getTranslated(context, 'welcome')},",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Theme.of(
                      context,
                    ).textTheme.headlineSmall?.fontSize,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Text(
                    "${getTranslated(context, 'sign_in_title')}",
                    style: TextStyle(
                      fontSize: Theme.of(
                        context,
                      ).textTheme.titleSmall?.fontSize,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ListView(
                children: [
                  myTextField(
                    context,
                    controller: _userController,
                    label: "${getTranslated(context, 'email_phone')}",
                    icon: AntDesign.user,
                    onValidate: (String value) {
                      if (value.isEmpty) {
                        return "${getTranslated(context, 'empty_field')}";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  myPasswordField(
                    context,
                    controller: _passController,
                    isChecked: _hidePassword,
                    label: "${getTranslated(context, 'password')}",
                    isCheck: () {
                      setState(() {
                        _hidePassword = !_hidePassword;
                      });
                    },
                    onValidate: (value) {
                      if (value.toString().isEmpty) {
                        return '${getTranslated(context, 'empty_field')}';
                      }
                      return null;
                    },
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "${getTranslated(context, 'forgot_password')}?",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: ElevatedButton(
                      onPressed: () {
                        if (validateAndSave()) {
                          //Login Request
                          //then Authenticate
                          authenticate(context);
                        }
                      },
                      child: Text(
                        "${getTranslated(context, 'sign_in')}".toUpperCase(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () {
                context.go("/${RouterPath.welcome}/${RouterPath.signUp}");
              },
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium!.color,
                  ),
                  children: [
                    TextSpan(
                      text: "${getTranslated(context, 'have_account')} ",
                    ),
                    TextSpan(
                      text: "${getTranslated(context, 'sign_up')}",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool validateAndSave() {
    var form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }
}
