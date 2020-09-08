import 'package:fz_courier/ArrangeDelivery/UI/bottom_list.dart';
import 'package:fz_courier/Components/continue_button.dart';
import 'package:fz_courier/GetFoodDelivered/UI/foodconfirm_info.dart';
import 'package:fz_courier/Locale/locales.dart';
import 'package:fz_courier/Routes/routes.dart';
import 'package:fz_courier/Theme/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fz_courier/Theme/colors.dart';

class GroceryConfirmInfoPage extends StatefulWidget {
  @override
  _GroceryConfirmInfoPageState createState() => _GroceryConfirmInfoPageState();
}

class _GroceryConfirmInfoPageState extends State<GroceryConfirmInfoPage> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    var theme = Theme.of(context);
    final List<Item> items = [
      Item(locale.packofEverydayMilk, '1'),
      Item(locale.frozenChickenPack, '1'),
      Item(locale.coconutOil500, '1'),
    ];
    return ClipRRect(
      borderRadius: borderRadius,
      child: Container(
        decoration: BoxDecoration(
          color: theme.backgroundColor,
          borderRadius: borderRadius,
        ),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.local_pizza, color: kMainColor),
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
            SizedBox(height: 12.0),
            Divider(thickness: 6, color: kButtonColor),
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
            Divider(thickness: 6, color: kButtonColor),
            Container(
              height: 28.0,
              child: ListTile(
                title: Text(
                  locale.foodItems,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                      .copyWith(color: theme.hintColor.withOpacity(0.7)),
                ),
                trailing: Text(
                  'Qty',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                      .copyWith(color: theme.hintColor.withOpacity(0.7)),
                ),
              ),
            ),
            ListView.builder(
                itemCount: 3,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    height: 24,
                    child: ListTile(
                      title: Text(
                        items[index].name,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(fontSize: 16),
                      ),
                      trailing: Text(
                        items[index].quantity,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(fontSize: 16),
                      ),
                    ),
                  );
                }),
            ListTile(
              title: Text(
                '\n' + locale.addinfo,
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    .copyWith(color: theme.hintColor.withOpacity(0.7)),
              ),
              subtitle: Text(
                locale.keepFrozenChicken,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontSize: 16),
              ),
            ),
            Divider(thickness: 6, color: kButtonColor),
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
                  end: 16, start: 110, top: 8.0, bottom: 20.0),
              child: CustomButton(
                text: locale.proceedPayment + '  ➔',
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
