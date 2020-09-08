import 'package:fz_courier/Components/continue_button.dart';
import 'package:fz_courier/Locale/locales.dart';
import 'package:fz_courier/Routes/routes.dart';
import 'package:fz_courier/Theme/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fz_courier/Theme/colors.dart';
import 'package:grouped_buttons/grouped_buttons.dart';

class BottomList {
  final String title;
  final String subtitle;

  BottomList({this.title, this.subtitle});
}

class Payment extends StatefulWidget {
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    final List<BottomList> paymentMode = <BottomList>[
      BottomList(
        title: locale.cashonPickup,
        subtitle: locale.payWhilePickDelivery,
      ),
      BottomList(
        title: locale.cashonDelivery,
        subtitle: locale.paywhileDropDelivery,
      ),
      BottomList(
        title: locale.payPal,
        subtitle: locale.payPayPalAccount,
      ),
      BottomList(
        title: locale.stripe,
        subtitle: locale.payStripeAccount,
      )
    ];
    var theme = Theme.of(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25.0),
          child: AppBar(
            leading: Icon(Icons.arrow_back_ios),
            title: Text(
              locale.paymentMode,
              style: theme.textTheme.headline5,
            ),
            backgroundColor: kMainColor,
          ),
        ),
      ),
      body: ClipRRect(
        borderRadius: borderRadius,
        child: Container(
          decoration: BoxDecoration(
            color: kButtonColor,
            borderRadius: borderRadius,
          ),
          child: Stack(
            children: <Widget>[
              ListView(
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 30.0, top: 24.0),
                    child: Text(
                      '${locale.amountPay} \$8.60',
                      style: theme.textTheme.headline6
                          .copyWith(color: theme.primaryColorDark),
                    ),
                  ),
                  RadioButtonGroup(
                    activeColor: theme.primaryColor,
                    labelStyle: theme.textTheme.caption,
                    padding: EdgeInsets.only(top: 16.0),
                    onSelected: (String checked) {},
                    labels: paymentMode.map((e) => e.title).toList(),
                    itemBuilder: (Radio radioButton, Text title, int i) {
                      return Column(
                        children: <Widget>[
                          Container(
                            color: kWhiteColor,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                leading: radioButton,
                                title: Text(
                                  paymentMode[i].title,
                                  style: theme.textTheme.bodyText1
                                      .copyWith(fontSize: 18),
                                ),
                                subtitle: Text(
                                  paymentMode[i].subtitle,
                                  style: theme.textTheme.bodyText2.copyWith(
                                      fontSize: 13.3, color: Color(0xffc1c1c1)),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 5.0)
                        ],
                      );
                    },
                  ),
                ],
              ),
              Positioned(
                width: MediaQuery.of(context).size.width,
                bottom: 0.0,
                child: CustomButton(
                  text: locale.done,
                  radius: BorderRadius.only(topRight: Radius.circular(35.0)),
                  onPressed: () => Navigator.popAndPushNamed(
                      context, PageRoutes.pickupAssigned),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
