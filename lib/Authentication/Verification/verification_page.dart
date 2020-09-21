import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fz_courier/Components/continue_button.dart';
import 'package:fz_courier/Components/custom_app_bar.dart';
import 'package:fz_courier/Components/entry_field.dart';
import 'package:fz_courier/Locale/locales.dart';
import 'package:flutter/material.dart';
import 'package:fz_courier/Routes/routes.dart';

import '../signin_navigator.dart';

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
  int _counter = 25;
  Timer _timer;
  String _verificationId;
  String _mobileNumber;
  int _forceResendingToken;
  bool _loading = false;
  final _scaffold = GlobalKey<ScaffoldState>();
  final _otpController = TextEditingController();

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
    _startTimer();
    _initValues();
  }

  void _initValues(){
    Future.delayed(Duration(milliseconds: 0),(){
      List<dynamic> data = ModalRoute.of(context).settings.arguments;
      _mobileNumber = data[0];
      _verificationId = data[1];
      _forceResendingToken = data[2];
    });
  }

  void _showMessage(String message) {
    _scaffold.currentState.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  void _verifyPhoneNumber() async {
    setState(() {
      _loading = true;
    });
    _showMessage("Please wait a few seconds...");

    final FirebaseAuth _auth = FirebaseAuth.instance;
    await _auth.verifyPhoneNumber(
      phoneNumber: "+91" + _mobileNumber,
      verificationCompleted: (authCredential) =>
          _verificationComplete(authCredential),
      verificationFailed: (authException) => _verificationFailed(authException),
      codeAutoRetrievalTimeout: (verificationId) =>
          _codeAutoRetrievalTimeout(verificationId),
      // called when the SMS code is sent
      codeSent: (verificationId, [code]) => _smsCodeSent(
        verificationId,
        [code],
      ),
      forceResendingToken: _forceResendingToken,
    );
  }

  void _verificationComplete(AuthCredential authCredential) async {
    final authResult =
        await FirebaseAuth.instance.signInWithCredential(authCredential);

    bool success = authResult.user != null;

    setState(() {
      _loading = false;
    });

    if(success){
      _showMessage("Sign In Success");
      widget.onVerificationDone();
    }
    else
      _showMessage("Error Signing In!");
  }

  void _smsCodeSent(String verificationId, List<int> code) {
    // set the verification code so that we can use it to log the user in

    setState(() {
      _loading = false;
    });

    _verificationId = verificationId;
    _forceResendingToken = code[0];
    print("OTP Sent");
    _showMessage("OTP Sent");
  }

  void _verificationFailed(FirebaseAuthException authException) {
    setState(() {
      _loading = false;
    });
    print("Verification Failed: " + authException.message);
    _showMessage("Verification Failed!");
  }

  void _codeAutoRetrievalTimeout(String verificationId) {
    setState(() {
      _loading = false;
    });
    // set the verification code so that we can use it to log the user in
    _verificationId = verificationId;
    print("Code autoretrieval timeout");
  }

  void _signInWithOTP(String smsCode) async {
    setState(() {
      _loading = true;
    });
    _showMessage("Please wait a few seconds...");

    try {
      final result = await FirebaseAuth.instance.signInWithCredential(
        PhoneAuthProvider.credential(
          verificationId: _verificationId,
          smsCode: smsCode,
        ),
      );

      bool success = result.user != null;

      if(success){
        widget.onVerificationDone();
        _showMessage("Sign In Success!");
      }
      else{
        _showMessage("Error Signing In!");
      }
    } catch (e) {
      print(e.toString());
      _showMessage("Error");
    }
    setState(() {
      _loading = false;
    });
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
      key: _scaffold,
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
                        onPressed: () {
                          if(_counter != 0)
                            return;
                          _verifyPhoneNumber();
                        },
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
                        readOnly: _loading,
                        controller: _otpController,
                      ),
                      Spacer(flex: 4),
                      CustomButton(
                        radius: BorderRadius.only(
                          topLeft: Radius.circular(35.0),
                        ),
                        onPressed: () {
                          if(_otpController.text.length < 6){
                            _showMessage("Invalid OTP");
                            return;
                          }
                          _signInWithOTP(_otpController.text);
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
