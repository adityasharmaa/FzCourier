import 'package:fz_courier/Authentication/signin_navigator.dart';
import 'package:fz_courier/Components/continue_button.dart';
import 'package:fz_courier/Components/custom_app_bar.dart';
import 'package:fz_courier/Components/entry_field.dart';
import 'package:fz_courier/Locale/locales.dart';
import 'package:flutter/material.dart';

class SocialSignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SocialSignUpBody();
  }
}

class SocialSignUpBody extends StatefulWidget {
  @override
  _SocialSignUpBodyState createState() => _SocialSignUpBodyState();
}

class _SocialSignUpBodyState extends State<SocialSignUpBody> {
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
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Spacer(),
                    CustomAppBar(),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        '\n' + locale.hey + " Samntha Smith",
                        style: Theme.of(context).textTheme.headline5.copyWith(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        '\n' + locale.socialText,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                    Spacer(flex: 2),
                    Container(
                      height: mediaQuery.size.height * 0.58,
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
                            label: locale.countryText,
                            hint: locale.selectCountryFromList,
                            suffixIcon: Icons.arrow_drop_down,
                            readOnly: true,
                          ),
                          EntryField(
                            label: locale.phoneText,
                            hint: locale.phoneHint,
                            keyboardType: TextInputType.number,
                          ),
                          Spacer(),
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
                Positioned(
                  width: mediaQuery.size.width,
                  top: mediaQuery.size.height / 3.1,
                  child: Center(
                    child: CircleAvatar(
                      radius: 55,
                      backgroundImage: AssetImage("images/profile.png"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
