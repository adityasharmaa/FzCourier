import 'package:fz_courier/ArrangeDelivery/UI/deliveryconfirm_info.dart';
import 'package:fz_courier/ArrangeDelivery/UI/measurement.dart';
import 'package:fz_courier/Components/address_field.dart';
import 'package:fz_courier/Components/continue_button.dart';
import 'package:fz_courier/Components/custom_app_bar.dart';
import 'package:fz_courier/Locale/locales.dart';
import 'package:fz_courier/Theme/colors.dart';
import 'package:fz_courier/Theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_xlider/flutter_xlider.dart';

class ArrangeDeliveryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ArrangeDeliveryBody();
  }
}

class ArrangeDeliveryBody extends StatefulWidget {
  @override
  _ArrangeDeliveryBodyState createState() => _ArrangeDeliveryBodyState();
}

class _ArrangeDeliveryBodyState extends State<ArrangeDeliveryBody> {
  int currentIndex = 0;
  PageController _pageController;

  double weight = 5;
  bool isSwitched = false;
  Measured measured;
  double width = 0;
  double length = 0;
  double height = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    var mediaQuery = MediaQuery.of(context);
    var theme = Theme.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: mediaQuery.size.height,
          child: Column(
            children: [
              Spacer(),
              CustomAppBar(
                  title: currentIndex == 0
                      ? locale.pickupLoc
                      : currentIndex == 1
                          ? locale.dropLocation
                          : currentIndex == 2
                              ? locale.courierInfo
                              : locale.confirmInfo),
              Spacer(),
              Container(
                height: mediaQuery.size.height * 0.85,
                child: Row(
                  children: [
                    Container(
                      width: 68,
                      child: Column(
                        children: [
                          SizedBox(height: 20.0),
                          InkWell(
                            onTap: () {
                              setState(() {
                                currentIndex = 0;
                              });
                              _pageController.animateToPage(currentIndex,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.linearToEaseOut);
                            },
                            child: CircleAvatar(
                              radius: 24,
                              backgroundColor: currentIndex == 0
                                  ? theme.backgroundColor
                                  : kNavigationButtonColor,
                              child: Icon(
                                Icons.location_on,
                                color: theme.primaryColor,
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          InkWell(
                            onTap: () {
                              setState(() {
                                currentIndex = 1;
                              });
                              _pageController.animateToPage(currentIndex,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.linearToEaseOut);
                            },
                            child: CircleAvatar(
                              radius: 24,
                              backgroundColor: currentIndex == 1
                                  ? theme.backgroundColor
                                  : kNavigationButtonColor,
                              child: Icon(
                                Icons.navigation,
                                color: theme.primaryColor,
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          InkWell(
                            onTap: () {
                              setState(() {
                                currentIndex = 2;
                              });
                              _pageController.animateToPage(currentIndex,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.linearToEaseOut);
                            },
                            child: CircleAvatar(
                              radius: 24,
                              backgroundColor: currentIndex == 2
                                  ? theme.backgroundColor
                                  : kNavigationButtonColor,
                              child: Icon(
                                Icons.shopping_basket,
                                color: theme.primaryColor,
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          InkWell(
                            onTap: () {
                              setState(() {
                                currentIndex = 3;
                              });
                              _pageController.animateToPage(currentIndex,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.linearToEaseOut);
                            },
                            child: CircleAvatar(
                              radius: 24,
                              backgroundColor: currentIndex == 3
                                  ? theme.backgroundColor
                                  : kNavigationButtonColor,
                              child: Icon(
                                Icons.assignment,
                                color: theme.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: PageView(
                        physics: BouncingScrollPhysics(),
                        controller: _pageController,
                        scrollDirection: Axis.vertical,
                        onPageChanged: (index) {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                        children: [
                          buildPage(theme, locale, context, 'Pickup'),
                          buildPage(theme, locale, context, 'Drop'),
                          buildCourierInfo(theme, locale, context),
                          ConfirmInfo(
                              height.toInt().toString(),
                              width.toInt().toString(),
                              weight.toInt().toString(),
                              length.toInt().toString(),
                              'No'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _navigateAndGetData(BuildContext context) async {
    measured = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => Measurement()));
    setState(() {
      height = measured.height;
      length = measured.length;
      width = measured.width;
    });
  }

  Container buildPage(ThemeData theme, AppLocalizations locale,
      BuildContext context, String page) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/map.png'), fit: BoxFit.fill),
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(boxShadow: [boxShadow]),
            margin:
                EdgeInsetsDirectional.only(top: 16.0, start: 16.0, end: 10.0),
            child: AddressField(
              color: theme.backgroundColor,
              icon: Icon(
                page == 'Pickup' ? Icons.location_on : Icons.navigation,
                color: theme.primaryColor,
              ),
              hint: page == 'Pickup' ? locale.pickupHint : locale.dropHint,
            ),
          ),
          page == 'Pickup' ? SizedBox.shrink() : Spacer(),
          page == 'Pickup'
              ? Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [boxShadow],
                        color: kWhiteColor,
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 20.0,
                      ),
                      margin:
                          EdgeInsetsDirectional.only(start: 16.0, end: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(locale.savedAddresses,
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(color: theme.hintColor)),
                          buildListTile(
                            locale.homeText,
                            icon: Icons.home,
                          ),
                          buildListTile(locale.office),
                          buildListTile(locale.other, icon: Icons.business),
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [boxShadow],
                        color: kWhiteColor,
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                      margin:
                          EdgeInsetsDirectional.only(start: 16.0, end: 10.0),
                      padding: EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 20.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            locale.recentSearch,
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                .copyWith(color: theme.hintColor),
                          ),
                          buildListTile(
                            'City Centre',
                            icon: Icons.restore,
                          ),
                          buildListTile(
                            'Walmart Campus',
                            icon: Icons.restore,
                          ),
                          buildListTile(
                            'Golden Point',
                            icon: Icons.restore,
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          color: kButtonColor,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(35.0)),
                        ),
                        child: ListTile(
                          leading:
                              Icon(Icons.navigation, color: theme.primaryColor),
                          title: Text(
                            '2210 St. Merry Church, New York, NY 10013, United States',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        )),
                    Container(
                      color: theme.backgroundColor,
                      padding: EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          AddressField(
                            icon: Icon(Icons.star,
                                size: 20, color: theme.primaryColor),
                            initialValue: locale.cityGarden,
                            color: kButtonColor,
                            readOnly: true,
                          ),
                          SizedBox(height: 4),
                          AddressField(
                            icon: Icon(Icons.person,
                                size: 20, color: theme.primaryColor),
                            initialValue: 'Sam Smith',
                            suffix: Icon(Icons.contacts,
                                color: theme.primaryColor, size: 20),
                            color: kButtonColor,
                            readOnly: true,
                          ),
                          SizedBox(height: 4),
                          AddressField(
                            icon: Icon(Icons.phone,
                                size: 20, color: theme.primaryColor),
                            initialValue: '+1 9876543210',
                            color: kButtonColor,
                            readOnly: true,
                          ),
                          CustomButton(
                            radius: BorderRadius.circular(35.0),
                            padding: 10,
                            text: '     ' + locale.continueText + '  ↓    ',
                            onPressed: () {
                              setState(() {
                                currentIndex = 2;
                              });
                              _pageController.animateToPage(currentIndex,
                                  duration: Duration(milliseconds: 350),
                                  curve: Curves.linearToEaseOut);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                )
        ],
      ),
    );
  }

  Widget buildCourierInfo(
      ThemeData theme, AppLocalizations locale, BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: Container(
        color: theme.backgroundColor,
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    locale.courierType,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      CustomButton(
                        onPressed: () {},
                        text: locale.envelope,
                        padding: 12,
                        color: kButtonColor,
                        borderColor: kButtonTextColor.withOpacity(0.6),
                        radius: BorderRadius.circular(30.0),
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            .copyWith(color: theme.hintColor),
                      ),
                      CustomButton(
                        onPressed: () {},
                        text: locale.boxPack,
                        padding: 12,
                        borderColor: kButtonTextColor.withOpacity(0.6),
                        radius: BorderRadius.circular(30.0),
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            .copyWith(color: theme.backgroundColor),
                      ),
                      CustomButton(
                        onPressed: () {},
                        text: locale.other,
                        color: kButtonColor,
                        padding: 12,
                        borderColor: kButtonTextColor.withOpacity(0.6),
                        radius: BorderRadius.circular(30.0),
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            .copyWith(color: theme.hintColor),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            Divider(thickness: 6, color: kButtonColor),
            InkWell(
              onTap: () {
                _navigateAndGetData(context);
              },
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    buildCalcCard(Icons.arrow_upward, locale.height,
                        height.toString() + ' ' + locale.cm, theme),
                    VerticalDivider(thickness: 6, color: kButtonColor),
                    buildCalcCard(Icons.arrow_forward, locale.width,
                        width.toString() + ' ' + locale.cm, theme),
                    VerticalDivider(thickness: 6, color: kButtonColor),
                    buildCalcCard(Icons.compare_arrows, locale.length,
                        length.toString() + ' ' + locale.cm, theme),
                  ],
                ),
              ),
            ),
            Divider(thickness: 6, color: kButtonColor),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Row(
                    children: <Widget>[
                      Text(
                        locale.weight,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Expanded(
                        child: FlutterSlider(
                          handlerHeight: 60,
                          handler: FlutterSliderHandler(
                            child: Container(
                              height: 16,
                              width: 2,
                              color: theme.primaryColor,
                              margin: EdgeInsets.only(bottom: 20),
                            ),
                            decoration:
                                BoxDecoration(shape: BoxShape.rectangle),
                          ),
                          hatchMark: FlutterSliderHatchMark(
                            density: 0.5,
                            bigLine: FlutterSliderSizedBox(
                                height: 16,
                                width: 2,
                                decoration: BoxDecoration(
                                    color:
                                        theme.disabledColor.withOpacity(0.3))),
                            smallLine: FlutterSliderSizedBox(
                                height: 8,
                                width: 1,
                                decoration: BoxDecoration(
                                    color:
                                        theme.disabledColor.withOpacity(0.3))),
                            displayLines: true,
                            linesAlignment:
                                FlutterSliderHatchMarkAlignment.left,
                            labelsDistanceFromTrackBar: 28,
                            labels: [
                              FlutterSliderHatchMarkLabel(
                                  label: Text(
                                    '0 kg',
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                  percent: 0),
                              FlutterSliderHatchMarkLabel(
                                  label: Text(
                                    '20 kg',
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                  percent: 100),
                              FlutterSliderHatchMarkLabel(
                                  label: Text(
                                    '10 kg',
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                  percent: 50),
                            ],
                          ),
                          values: [weight],
                          min: 0,
                          max: 20,
                          onDragging: (index, lowerValue, upperValue) {
                            setState(() {
                              weight = lowerValue;
                            });
                          },
                          trackBar: FlutterSliderTrackBar(
                              activeTrackBarHeight: 0.1,
                              activeTrackBar: BoxDecoration(
                                color: theme.backgroundColor,
                              ),
                              inactiveTrackBarHeight: 0.1),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            Divider(thickness: 6, color: kButtonColor),
            ListTile(
              title: Text(
                locale.frangible + ' ?',
                style: theme.textTheme.bodyText1,
              ),
              trailing: FittedBox(
                child: Row(
                  children: [
                    Text(
                      isSwitched ? locale.yes : locale.no,
                      style: TextStyle(
                          color: theme.primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    Switch(
                      value: isSwitched,
                      onChanged: (value) {
                        setState(() {
                          isSwitched = value;
                        });
                      },
                      activeTrackColor: theme.hintColor.withOpacity(0.3),
                      activeColor: theme.primaryColor,
                      inactiveTrackColor: theme.hintColor.withOpacity(0.3),
                    ),
                  ],
                ),
              ),
            ),
            Divider(thickness: 6, color: kButtonColor),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    locale.courierDetail + '\n',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  TextFormField(
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: locale.courierInput,
                      hintStyle: Theme.of(context)
                          .textTheme
                          .caption
                          .copyWith(color: theme.hintColor),
                      filled: true,
                      fillColor: kButtonColor,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20),
                        //gapPadding: 3.3
                      ),
                    ),
                    maxLines: 2,
                  ),
                ],
              ),
            ),
            Divider(thickness: 6, color: kButtonColor),
            Padding(
              padding:
                  EdgeInsetsDirectional.only(start: 180, top: 12.0, end: 20.0),
              child: CustomButton(
                radius: BorderRadius.circular(35.0),
                padding: 10,
                text: '     ' + locale.continueText + '  ↓    ',
                onPressed: () {
                  setState(() {
                    currentIndex = 3;
                  });
                  _pageController.animateToPage(currentIndex,
                      duration: Duration(milliseconds: 350),
                      curve: Curves.linearToEaseOut);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListTile buildListTile(String text, {IconData icon}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: icon != null
          ? Icon(
              icon,
              color: Theme.of(context).primaryColor,
            )
          : Image.asset(
              'images/ic_officeblk.png',
              color: Theme.of(context).primaryColor,
              scale: 3.5,
            ),
      title: Text(
        text,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      dense: true,
    );
  }

  Widget buildCalcCard(
      IconData icon, String text, String measurement, ThemeData theme) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                icon,
                size: 16,
                color: theme.primaryColor,
              ),
              SizedBox(
                width: 8,
              ),
              Text(text,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                      .copyWith(color: kButtonTextColor, fontSize: 11.7)),
            ],
          ),
          SizedBox(
            height: 7.5,
          ),
          Text(measurement,
              style: Theme.of(context)
                  .textTheme
                  .subtitle2
                  .copyWith(color: kContainerTextColor))
        ],
      ),
    );
  }
}
