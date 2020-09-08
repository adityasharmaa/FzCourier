import 'package:fz_courier/Authentication/signin_navigator.dart';
import 'package:fz_courier/Components/continue_button.dart';
import 'package:fz_courier/Components/custom_app_bar.dart';
import 'package:fz_courier/Components/entry_field.dart';
import 'package:fz_courier/Locale/locales.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RegisterBody();
  }
}

class RegisterBody extends StatefulWidget {
  @override
  _RegisterBodyState createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    var mediaQuery = MediaQuery.of(context);
    var theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: mediaQuery.size.height - mediaQuery.padding.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Spacer(),
                CustomAppBar(title: locale.registerText),
                Spacer(),
                Container(
                  height: mediaQuery.size.height * 0.8,
                  decoration: BoxDecoration(
                    color: theme.backgroundColor,
                    borderRadius: BorderRadiusDirectional.only(
                      topStart: Radius.circular(35.0),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Spacer(),
                      EntryField(
                        label: locale.nameText,
                        hint: locale.nameHint,
                        textCapitalization: TextCapitalization.words,
                      ),
                      EntryField(
                        label: locale.emailText,
                        hint: locale.emailHint,
                      ),
                      EntryField(
                        suffixIcon: Icons.arrow_drop_down,
                        label: locale.countryText,
                        hint: locale.selectCountryFromList,
                        readOnly: true,
                      ),
                      EntryField(
                        label: locale.phoneText,
                        hint: locale.phoneHint,
                      ),
                      Spacer(flex: 2),
                      CustomButton(
                        radius: BorderRadius.only(
                          topLeft: Radius.circular(35.0),
                        ),
                        onPressed: () => Navigator.pushNamed(
                            context, SignInRoutes.verification),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
