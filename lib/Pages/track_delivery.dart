import 'package:fz_courier/Locale/locales.dart';
import 'package:fz_courier/Theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fz_courier/Pages/slide_up_panel.dart';

class TrackDelivery extends StatefulWidget {
  @override
  _TrackDeliveryState createState() => _TrackDeliveryState();
}

class _TrackDeliveryState extends State<TrackDelivery> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 25.0),
          child: AppBar(
            leading: InkWell(
              onTap: () => Navigator.pop(context),
              child: Icon(
                Icons.arrow_back_ios,
                color: kMainColor,
                size: 24.0,
              ),
            ),
            title: Text('Order ID 114258'),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          ListTile(
            leading: Image.asset('images/home1.png'),
            title: Text(
              locale.courier,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            subtitle: Row(
              children: [
                Text(
                  '20 Jun 2020,\n11:40 am',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                      .copyWith(color: Color(0xffc1c1c1)),
                ),
                Spacer(),
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(locale.pickupAssigned,
                    style: Theme.of(context).textTheme.subtitle2.copyWith(
                        color: kMainColor, fontWeight: FontWeight.bold)),
                Text('\$ 8.50',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        .copyWith(color: Color(0xffc1c1c1))),
              ],
            ),
          ),
          SizedBox(height: 12.0),
          Expanded(
            child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/map.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: SlideUpPanel()),
          ),
        ],
      ),
    );
  }
}
