import 'package:firebase_auth/firebase_auth.dart';
import 'package:fz_courier/Authentication/signin_navigator.dart';
import 'package:fz_courier/Components/continue_button.dart';
import 'package:fz_courier/Components/custom_app_bar.dart';
import 'package:fz_courier/Components/entry_field.dart';
import 'package:fz_courier/Locale/locales.dart';
import 'package:flutter/material.dart';
import 'package:fz_courier/Routes/routes.dart';

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
  String _verificationId;
  String _mobileNumber;
  int _forceResendingToken;
  bool _loading = false;
  final _scaffold = GlobalKey<ScaffoldState>();

  void _showMessage(String message) {
    _scaffold.currentState.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  void _verifyPhoneNumber() async {
    setState(() {
      _loading = true;
    });

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

    if (success) {
      _showMessage("Sign In Success");
      Navigator.popAndPushNamed(context, PageRoutes.bottomNavigation);
    } else
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
    Navigator.of(context).popAndPushNamed(
      SignInRoutes.verification,
      arguments: [
        _mobileNumber,
        _verificationId,
        _forceResendingToken,
      ],
    );
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

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    var mediaQuery = MediaQuery.of(context);
    var theme = Theme.of(context);
    _mobileNumber = ModalRoute.of(context).settings.arguments;
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
                        readOnly: _loading,
                      ),
                      EntryField(
                        label: locale.emailText,
                        hint: locale.emailHint,
                        readOnly: _loading,
                      ),
                      EntryField(
                        suffixIcon: Icons.arrow_drop_down,
                        label: locale.countryText,
                        hint: locale.selectCountryFromList,
                        readOnly: true,
                        initialValue: "+91",
                      ),
                      EntryField(
                        label: locale.phoneText,
                        hint: locale.phoneHint,
                        initialValue: _mobileNumber,
                        readOnly: true,
                      ),
                      Spacer(flex: 2),
                      CustomButton(
                        radius: BorderRadius.only(
                          topLeft: Radius.circular(35.0),
                        ),
                        onPressed: () {
                          if (_loading) return;
                          _showMessage("Please wait a few seconds...");
                          _verifyPhoneNumber();
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
