import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../models/country.dart';
import '../../utils/constants.dart';
import '../../utils/enumerations.dart';
import '../../utils/languages/constants.dart';
import '../../utils/providers/initial.dart';
import '../widgets/dropdowns.dart';
import '../widgets/form_helper.dart';
import '../widgets/loading.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  GlobalKey<FormState> signKey = GlobalKey<FormState>();
  bool isAsync = false;
  bool _hidePassword = true;
  bool _hidePassword1 = true;
  List<Country> countries = [];
  Country selectedCountry = Country();
  
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      countries = Provider.of<InitialProvider>(
        context,
        listen: false,
      ).countries;
      setState(() {
        selectedCountry = countries[0];
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Consumer<InitialProvider>(
        builder: (c, provider, _) {
          return LoadingPage(
            isAsync:
                isAsync ||
                provider.apiRequestStatus == ApiRequestStatus.loading,
            child: SafeArea(
              child: Column(
                children: [
                  Expanded(child: formContent()),
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        context.go(
                          "/${RouterPath.welcome}/${RouterPath.signIn}",
                        );
                      },
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: Theme.of(
                              context,
                            ).textTheme.bodyMedium!.color,
                          ),
                          children: [
                            TextSpan(
                              text:
                                  "${getTranslated(context, 'already_account')} ",
                            ),
                            TextSpan(
                              text: "${getTranslated(context, 'sign_in')}",
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
            ),
          );
        },
      ),
    );
  }

  formContent() {
    return Form(
      key: signKey,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Text(
              "${getTranslated(context, 'sign_up')}",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "${getTranslated(context, 'sign_up_account_title')}",
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(letterSpacing: 1),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                children: [
                  CountryDropDown(
                    countries: countries,
                    selectedCountry: selectedCountry,
                    onChanged: (value) {
                      setState(() {
                        selectedCountry = value!;
                      });
                    },
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: TextFormField(
                      autofocus: true,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      controller: phoneController,
                      decoration: InputDecoration(
                        hintText: "${getTranslated(context, 'phone_number')}",
                        border: InputBorder.none,
                      ),
                      validator: (value) {
                        if (value!.trim().length < 8) {
                          return "${getTranslated(context, 'invalid_phone')}";
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            myTextField(
              context,
              label: "${getTranslated(context, 'last_name')}",
              controller: lastNameController,
              onValidate: (value) {
                if (value.toString().isEmpty) {
                  return "${getTranslated(context, 'empty_field')}";
                }
                return null;
              },
              icon: AntDesign.user,
            ),
            const SizedBox(height: 10),
            myTextField(
              context,
              label: "${getTranslated(context, 'first_name')}",
              controller: firstNameController,
              onValidate: (value) {
                if (value.toString().isEmpty) {
                  return "${getTranslated(context, 'empty_field')}";
                }
                return null;
              },
              icon: AntDesign.user,
            ),
            const SizedBox(height: 10),
            myEmailField(
              context,
              label: "${getTranslated(context, 'email')}",
              controller: emailController,
            ),
            const SizedBox(height: 10),
            myPasswordField(
              context,
              controller: passwordController,
              isCheck: () {
                setState(() {
                  _hidePassword = !_hidePassword;
                });
              },
              label: "${getTranslated(context, 'password')}",
              isChecked: _hidePassword,
              onValidate: (value) {
                bool passValid = RegExp(requirement).hasMatch(value!);
                if (!passValid) {
                  return getTranslated(context, 'enter_valid_password');
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            myPasswordField(
              context,
              controller: confirmPasswordController,
              isCheck: () {
                setState(() {
                  _hidePassword1 = !_hidePassword1;
                });
              },
              isChecked: _hidePassword1,
              label: "${getTranslated(context, 'confirm_password')}",
              onValidate: (value) {
                if (passwordController.text != confirmPasswordController.text) {
                  return "${getTranslated(context, 'password_incompatible')}";
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {
                  if (validateAndSave()) {
                    //Create account Request
                  }
                },
                child: Text(
                  '${getTranslated(context, 'confirm')}'.toUpperCase(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool validateAndSave() {
    var form = signKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }
}
