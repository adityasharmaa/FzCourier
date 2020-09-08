import 'package:fz_courier/Components/continue_button.dart';
import 'package:fz_courier/Locale/locales.dart';
import 'package:flutter/material.dart';
import 'package:fz_courier/Theme/colors.dart';
import 'package:grouped_buttons/grouped_buttons.dart';

class BottomList {
  final String title;
  final String subtitle;
  final String trailing;

  BottomList({this.title, this.subtitle, this.trailing});
}

class ModalBottomWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    final List<BottomList> deliveryMode = <BottomList>[
      BottomList(
        title: locale.economyDelivery,
        subtitle: locale.comment1,
        trailing: '\$8.60',
      ),
      BottomList(
        title: (locale.deluxDelivery),
        subtitle: (locale.comment2),
        trailing: ('\$12.50'),
      ),
      BottomList(
        title: (locale.premiumDelivery),
        subtitle: (locale.comment3),
        trailing: ('\$20.00'),
      ),
    ];
    return Stack(
      children: [
        ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                locale.selectDelivery,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(color: Theme.of(context).primaryColorDark),
              ),
            ),
            RadioButtonGroup(
              labelStyle: Theme.of(context).textTheme.caption,
              padding: EdgeInsets.only(top: 16.0),
              activeColor: Theme.of(context).primaryColor,
              onSelected: (String checked) {},
              labels: deliveryMode.map((e) => e.title).toList(),
              itemBuilder: (Radio radioButton, Text title, int i) {
                return Column(
                  children: <Widget>[
                    Container(
                      color: kWhiteColor,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: radioButton,
                          title: Text(
                            deliveryMode[i].title,
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(
                                    fontSize: 18.3, color: kContainerTextColor),
                          ),
                          subtitle: Text(
                            deliveryMode[i].subtitle,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(color: Theme.of(context).hintColor),
                          ),
                          trailing: Text(deliveryMode[i].trailing,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(
                                      color:
                                          Theme.of(context).primaryColorDark)),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                  ],
                );
              },
            ),
            SizedBox(height: 64),
          ],
        ),
        Positioned(
          width: MediaQuery.of(context).size.width,
          bottom: 0.0,
          child: CustomButton(
            text: locale.update,
            radius: BorderRadius.only(topRight: Radius.circular(35.0)),
            onPressed: () => Navigator.pop(context),
          ),
        )
      ],
    );
  }
}
