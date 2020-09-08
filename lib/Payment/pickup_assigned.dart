import 'package:fz_courier/Components/continue_button.dart';
import 'package:fz_courier/Locale/locales.dart';
import 'package:fz_courier/Theme/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fz_courier/Theme/colors.dart';
import 'package:fz_courier/Routes/routes.dart';

class PickupAssigned extends StatefulWidget {
  @override
  _PickupAssignedState createState() => _PickupAssignedState();
}

class _PickupAssignedState extends State<PickupAssigned> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kMainColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25.0),
          child: AppBar(
            leading: Icon(Icons.arrow_back_ios),
            title: Text(
              locale.pickupAssigned,
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: borderRadius,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Spacer(flex: 2),
            Image.asset(
              'images/pickup.png',
              scale: 3,
            ),
            Spacer(),
            Text(
              locale.pickupArranged,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6.copyWith(
                  color: Theme.of(context).primaryColorDark,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              locale.thanksText,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .subtitle2
                  .copyWith(color: Color(0xff282828)),
            ),
            Spacer(flex: 2),
            CustomButton(
              text: locale.trackCourier,
              radius: BorderRadius.only(topRight: Radius.circular(35.0)),
              onPressed: () => Navigator.popAndPushNamed(
                  context, PageRoutes.bottomNavigation),
            )
          ],
        ),
      ),
    );
  }
}
