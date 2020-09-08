import 'dart:async';
import 'package:fz_courier/Components/continue_button.dart';
import 'package:fz_courier/Components/custom_app_bar.dart';
import 'package:fz_courier/Components/entry_field.dart';
import 'package:fz_courier/Locale/locales.dart';
import 'package:flutter/material.dart';

class VerificationPage extends StatelessWidget {
  final VoidCallback onVerificationDone;
  VerificationPage({this.onVerificationDone});
  @override
  Widget build(BuildContext context) {
    return VerificationBody(onVerificationDone);
  }
}

class VerificationBody extends StatefulWidget {
  final VoidCallback onVerificationDone;
  VerificationBody(this.onVerificationDone);
  @override
  _VerificationBodyState createState() => _VerificationBodyState();
}

class _VerificationBodyState extends State<VerificationBody> {
  int _counter = 23;
  Timer _timer;

  _startTimer() {
    //shows timer
    _counter = 23; //time counter

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _counter > 0 ? _counter-- : _timer.cancel();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    verifyPhoneNumber();
  }

  void verifyPhoneNumber() {
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

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
                CustomAppBar(title: locale.verificationText),
                Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    locale.otpText,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "0:$_counter min",
                        style: Theme.of(context).textTheme.button,
                      ),
                      CustomButton(
                        text: locale.resendText,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  height: mediaQuery.size.height * 0.63,
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
                        label: locale.enterOTP,
                        hint: locale.otpText1,
                        maxLength: 6,
                      ),
                      Spacer(flex: 4),
                      CustomButton(
                        radius: BorderRadius.only(
                          topLeft: Radius.circular(35.0),
                        ),
                        onPressed: () {
                          widget.onVerificationDone();
                        },
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
