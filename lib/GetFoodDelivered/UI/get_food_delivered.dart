import 'package:fz_courier/Components/address_field.dart';
import 'package:fz_courier/Components/continue_button.dart';
import 'package:fz_courier/Components/custom_app_bar.dart';
import 'package:fz_courier/GetFoodDelivered/UI/foodconfirm_info.dart';
import 'package:fz_courier/Locale/locales.dart';
import 'package:fz_courier/Theme/colors.dart';
import 'package:fz_courier/Theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GetFoodDeliveredPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetFoodDeliveredBody();
  }
}

class GetFoodDeliveredBody extends StatefulWidget {
  @override
  _GetFoodDeliveredBodyState createState() => _GetFoodDeliveredBodyState();
}

class _GetFoodDeliveredBodyState extends State<GetFoodDeliveredBody> {
  int currentIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: currentIndex,
    );
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
                              ? locale.foodInfo
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
                                Icons.local_pizza,
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
                                Icons.restaurant_menu,
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
                          buildPage(theme, locale, 'Pickup'),
                          buildPage(theme, locale, 'Drop'),
                          foodInfo(theme, locale),
                          FoodConfirmInfo(),
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

  Widget buildPage(ThemeData theme, AppLocalizations locale, String pickup) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/map.png'), fit: BoxFit.fill),
      ),
      child: pickup == 'Pickup'
          ? Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(boxShadow: [boxShadow]),
                  margin: EdgeInsets.all(16.0),
                  child: AddressField(
                    hint: locale.searchRes,
                    icon: Icon(Icons.local_pizza, color: theme.primaryColor),
                  ),
                ),
                Spacer(),
                Container(
                  decoration: BoxDecoration(
                    color: kButtonColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0)),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12.0),
                  child: ListTile(
                    leading: Icon(Icons.location_on, color: kMainColor),
                    title: Text(
                      '128 Mott St, New York, NY 10013, United States',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ),
                Container(
                  color: theme.backgroundColor,
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      AddressField(
                        icon:
                            Icon(Icons.local_pizza, color: theme.primaryColor),
                        color: kButtonColor,
                        hint: locale.nameRes,
                        readOnly: true,
                      ),
                      AddressField(
                        icon: Icon(Icons.phone, color: theme.primaryColor),
                        color: kButtonColor,
                        hint: locale.contactNumber,
                        readOnly: true,
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.only(start: 180, top: 20),
                        child: CustomButton(
                          text: locale.continueText + '  ↓',
                          radius: BorderRadius.circular(35.0),
                          padding: 10,
                          onPressed: () {
                            setState(() {
                              currentIndex = 1;
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
              ],
            )
          : Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(boxShadow: [boxShadow]),
                  margin: EdgeInsets.all(16.0),
                  child: AddressField(
                    hint: locale.dropHint,
                    icon: Icon(Icons.navigation, color: theme.primaryColor),
                  ),
                ),
                Spacer(),
                Container(
                  decoration: BoxDecoration(
                    color: kButtonColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0)),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12.0),
                  child: ListTile(
                    leading: Icon(Icons.navigation, color: theme.primaryColor),
                    title: Text(
                      'Paris, France',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ),
                Container(
                  color: theme.backgroundColor,
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      AddressField(
                        icon: Icon(Icons.assistant, color: theme.primaryColor),
                        color: kButtonColor,
                        hint: locale.nameRes,
                        readOnly: true,
                      ),
                      AddressField(
                        icon: Icon(Icons.person, color: theme.primaryColor),
                        color: kButtonColor,
                        hint: locale.namePerson,
                        suffix: Icon(
                          Icons.contacts,
                          color: theme.primaryColor,
                        ),
                        readOnly: true,
                      ),
                      AddressField(
                        icon: Icon(Icons.phone, color: theme.primaryColor),
                        color: kButtonColor,
                        hint: locale.contactNumber,
                        readOnly: true,
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.only(start: 180, top: 20),
                        child: CustomButton(
                          text: locale.continueText + '  ↓',
                          radius: BorderRadius.circular(35.0),
                          padding: 10,
                          onPressed: () {
                            setState(() {
                              currentIndex = 2;
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
              ],
            ),
    );
  }

  Widget foodInfo(ThemeData theme, AppLocalizations locale) {
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    locale.addFood + '\n',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  AddressField(
                    hint: locale.addItem,
                    color: kButtonColor,
                    icon: Icon(
                      Icons.restaurant_menu,
                      color: theme.primaryColor,
                    ),
                    suffix: Text(
                      '\nQtn',
                      style: theme.textTheme.caption
                          .copyWith(color: theme.hintColor),
                    ),
                  ),
                  AddressField(
                    hint: locale.addItem,
                    color: kButtonColor,
                    icon: Icon(
                      Icons.restaurant_menu,
                      color: theme.primaryColor,
                    ),
                    suffix: Text(
                      '\nQtn',
                      style: theme.textTheme.caption
                          .copyWith(color: theme.hintColor),
                    ),
                  ),
                  AddressField(
                    hint: locale.addItem,
                    color: kButtonColor,
                    icon: Icon(
                      Icons.restaurant_menu,
                      color: theme.primaryColor,
                    ),
                    suffix: Text(
                      '\nQtn',
                      style: theme.textTheme.caption
                          .copyWith(color: theme.hintColor),
                    ),
                  ),
                  Text(
                    '\n    + ${locale.addMore}\n',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: theme.primaryColor),
                  ),
                ],
              ),
            ),
            Divider(thickness: 6, color: kButtonColor),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    locale.addinfo + '\n',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        .copyWith(color: kContainerTextColor),
                  ),
                  TextFormField(
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      hintText: locale.addinfoInput,
                      hintStyle: Theme.of(context)
                          .textTheme
                          .caption
                          .copyWith(color: theme.hintColor),
                      filled: true,
                      fillColor: kButtonColor,
                    ),
                    maxLines: 2,
                  ),
                ],
              ),
            ),
            Divider(thickness: 6, color: kButtonColor),
            Container(
              color: kButtonColor,
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info,
                        color: kMainColor,
                        size: 12.0,
                      ),
                      SizedBox(width: 12.0),
                      Expanded(
                        child: Text(
                          locale.availableText,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.0),
                  Row(
                    children: [
                      Icon(
                        Icons.info,
                        color: kMainColor,
                        size: 12.0,
                      ),
                      SizedBox(width: 12.0),
                      Expanded(
                        child: Text(
                          locale.delivCall,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.0),
                  Row(
                    children: [
                      Icon(
                        Icons.info,
                        color: kMainColor,
                        size: 12.0,
                      ),
                      SizedBox(width: 12.0),
                      Expanded(
                        child: Text(
                          locale.delivCharges,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.0),
                  Padding(
                    padding: EdgeInsetsDirectional.only(start: 180, top: 20),
                    child: CustomButton(
                      text: '     ' + locale.continueText + '  ↓     ',
                      radius: BorderRadius.circular(35.0),
                      padding: 10,
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
          ],
        ),
      ),
    );
  }
}
