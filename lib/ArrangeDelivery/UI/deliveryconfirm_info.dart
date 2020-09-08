import 'package:fz_courier/Components/continue_button.dart';
import 'package:fz_courier/Locale/locales.dart';
import 'package:fz_courier/Theme/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fz_courier/Theme/colors.dart';
import 'package:fz_courier/Routes/routes.dart';

import 'bottom_list.dart';

class ConfirmInfo extends StatefulWidget {
  final String height;
  final String width;
  final String weight;
  final String length;
  final String frangible;

  ConfirmInfo(
      this.height, this.width, this.weight, this.length, this.frangible);

  @override
  _ConfirmInfoState createState() => _ConfirmInfoState();
}

class _ConfirmInfoState extends State<ConfirmInfo> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    var theme = Theme.of(context);
    return ClipRRect(
      borderRadius: borderRadius,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: borderRadius, color: theme.backgroundColor),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.location_on, color: kMainColor),
              title: RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: 'Walmart' + '\n',
                    style: theme.textTheme.subtitle2
                        .copyWith(color: theme.hintColor.withOpacity(0.7)),
                  ),
                  TextSpan(
                      text: 'Emili Williamson',
                      style: theme.textTheme.headline6
                          .copyWith(color: theme.primaryColorDark, height: 1.5))
                ]),
              ),
              subtitle: Text(
                '128 Mott St, New York, NY 10013, United States',
                style:
                    Theme.of(context).textTheme.bodyText1.copyWith(height: 1.5),
              ),
            ),
            SizedBox(height: 12.0),
            ListTile(
              leading: Icon(Icons.navigation, color: kMainColor),
              title: RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: locale.cityGarden + '\n',
                    style: theme.textTheme.subtitle2
                        .copyWith(color: theme.hintColor.withOpacity(0.7)),
                  ),
                  TextSpan(
                      text: 'Samantha Smith',
                      style: theme.textTheme.headline6
                          .copyWith(color: theme.primaryColorDark, height: 1.5))
                ]),
              ),
              subtitle: Text(
                '2210 St. Merry Church, New York, NY 10013, United States',
                style:
                    Theme.of(context).textTheme.bodyText1.copyWith(height: 1.5),
              ),
            ),
            Divider(color: kButtonColor, thickness: 6),
            ListTile(
              title: Text(
                locale.distance,
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    .copyWith(color: theme.hintColor.withOpacity(0.7)),
              ),
              subtitle: Row(
                children: <Widget>[
                  Text(
                    '24.2 ' + locale.km,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(fontSize: 16),
                  ),
                  Spacer(),
                  Icon(Icons.navigation, color: kMainColor, size: 20),
                  Text(
                    locale.viewMap,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        .copyWith(color: kMainColor),
                  )
                ],
              ),
            ),
            Divider(color: kButtonColor, thickness: 6),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              child: Row(
                children: [
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: locale.courierType + '\n',
                        style: theme.textTheme.subtitle2
                            .copyWith(color: theme.hintColor.withOpacity(0.7)),
                      ),
                      TextSpan(
                        text: locale.boxCourier,
                        style: theme.textTheme.bodyText1.copyWith(fontSize: 16),
                      ),
                    ]),
                  ),
                  Spacer(),
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: locale.frangible + '\n',
                        style: theme.textTheme.subtitle2
                            .copyWith(color: theme.hintColor.withOpacity(0.7)),
                      ),
                      TextSpan(
                        text: widget.frangible,
                        style: theme.textTheme.bodyText1.copyWith(fontSize: 16),
                      ),
                    ]),
                  ),
                  SizedBox(width: 40),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: locale.height +
                            ' ' +
                            locale.width +
                            ' ' +
                            locale.length +
                            '\n',
                        style: theme.textTheme.subtitle2
                            .copyWith(color: theme.hintColor.withOpacity(0.7)),
                      ),
                      TextSpan(
                        text: widget.height +
                            ' x ' +
                            widget.width +
                            ' x ' +
                            widget.length +
                            ' (cm)',
                        style: theme.textTheme.bodyText1.copyWith(fontSize: 16),
                      ),
                    ]),
                  ),
                  Spacer(),
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: locale.weight + '\n',
                        style: theme.textTheme.subtitle2
                            .copyWith(color: theme.hintColor.withOpacity(0.7)),
                      ),
                      TextSpan(
                        text: widget.weight + ' kg',
                        style: theme.textTheme.bodyText1.copyWith(fontSize: 16),
                      ),
                    ]),
                  ),
                  SizedBox(width: 54),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: locale.courierInfo + '\n',
                    style: theme.textTheme.subtitle2
                        .copyWith(color: theme.hintColor.withOpacity(0.7)),
                  ),
                  TextSpan(
                    text: locale.comment4,
                    style: theme.textTheme.bodyText1.copyWith(fontSize: 16),
                  ),
                ]),
              ),
            ),
            Divider(color: kButtonColor, thickness: 6),
            Container(
              decoration: BoxDecoration(
                  color: kButtonColor,
                  borderRadius: BorderRadius.circular(30.0)),
              margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: ListTile(
                title: Text(
                  locale.delivMode,
                  style: theme.textTheme.subtitle2
                      .copyWith(color: theme.hintColor.withOpacity(0.7)),
                ),
                subtitle: Text(
                  locale.economyDelivery,
                  style: theme.textTheme.bodyText1.copyWith(fontSize: 16),
                ),
                trailing: Text('\$8.60 ▼',
                    style: Theme.of(context).textTheme.headline6.copyWith(
                          fontSize: 18.3,
                        )),
                onTap: () async {
                  await showModalBottomSheet(
                    shape: OutlineInputBorder(
                      borderRadius: borderRadius,
                      borderSide: BorderSide.none,
                    ),
                    context: context,
                    builder: (context) {
                      return ModalBottomWidget();
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(
                  end: 16, start: 120, top: 8, bottom: 20.0),
              child: CustomButton(
                text: locale.proceedPayment,
                radius: BorderRadius.circular(35.0),
                padding: 10,
                onPressed: () =>
                    Navigator.popAndPushNamed(context, PageRoutes.payment),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
