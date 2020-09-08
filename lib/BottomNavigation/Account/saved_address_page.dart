import 'package:fz_courier/Components/address_field.dart';
import 'package:fz_courier/Components/continue_button.dart';
import 'package:fz_courier/Components/custom_app_bar.dart';
import 'package:fz_courier/Locale/locales.dart';
import 'package:fz_courier/Theme/colors.dart';
import 'package:fz_courier/Theme/style.dart';
import 'package:flutter/material.dart';

class SavedAddressesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SavedAddressesBody();
  }
}

class SavedAddressesBody extends StatefulWidget {
  @override
  _SavedAddressesBodyState createState() => _SavedAddressesBodyState();
}

class _SavedAddressesBodyState extends State<SavedAddressesBody> {
  static int _currentIndex = 0;
  PageController _pageController = PageController(
    initialPage: _currentIndex,
  );

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
              CustomAppBar(title: locale.savedAddresses),
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
                                _currentIndex = 0;
                              });
                              _pageController.animateToPage(_currentIndex,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.linearToEaseOut);
                            },
                            child: CircleAvatar(
                              radius: 24,
                              backgroundColor: _currentIndex == 0
                                  ? theme.backgroundColor
                                  : kNavigationButtonColor,
                              child: Icon(
                                Icons.home,
                                color: theme.primaryColor,
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _currentIndex = 1;
                              });
                              _pageController.animateToPage(_currentIndex,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.linearToEaseOut);
                            },
                            child: CircleAvatar(
                                radius: 24,
                                backgroundColor: _currentIndex == 1
                                    ? theme.backgroundColor
                                    : kNavigationButtonColor,
                                child: ImageIcon(
                                  AssetImage('images/ic_officewt.png'),
                                  color: theme.primaryColor,
                                )),
                          ),
                          SizedBox(height: 20.0),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _currentIndex = 2;
                              });
                              _pageController.animateToPage(_currentIndex,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.linearToEaseOut);
                            },
                            child: CircleAvatar(
                              radius: 24,
                              backgroundColor: _currentIndex == 2
                                  ? theme.backgroundColor
                                  : kNavigationButtonColor,
                              child: Icon(
                                Icons.business,
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
                        onPageChanged: (index) {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                        scrollDirection: Axis.vertical,
                        children: [
                          buildAddressContainer(
                              theme, Icons.home, locale.homeText, context),
                          buildAddressContainer(theme, Icons.account_balance,
                              locale.office, context),
                          buildAddressContainer(
                              theme, Icons.business, locale.other, context),
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

  Container buildAddressContainer(
    ThemeData theme,
    IconData icon,
    String text,
    BuildContext context,
  ) {
    var locale = AppLocalizations.of(context);
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/map.png'), fit: BoxFit.fill),
      ),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(boxShadow: [boxShadow]),
            margin: EdgeInsets.all(16.0),
            child: AddressField(
              initialValue: text,
              icon: icon == Icons.account_balance
                  ? Image.asset(
                      'images/ic_officewt.png',
                      scale: 3.5,
                      color: theme.primaryColor,
                    )
                  : Icon(icon, size: 20, color: theme.primaryColor),
              suffix: Icon(Icons.search, color: theme.hintColor),
              border: BorderSide.none,
            ),
          ),
          Spacer(),
          Container(
              decoration: BoxDecoration(
                color: kButtonColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(35.0)),
              ),
              padding: EdgeInsets.all(8.0),
              child: ListTile(
                leading: Icon(Icons.navigation, color: theme.primaryColor),
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
                  icon: Icon(Icons.star, size: 20, color: theme.primaryColor),
                  initialValue: locale.cityGarden,
                  color: kButtonColor,
                ),
                SizedBox(height: 4),
                AddressField(
                  icon: Icon(Icons.person, size: 20, color: theme.primaryColor),
                  initialValue: 'Sam Smith',
                  suffix:
                      Icon(Icons.contacts, color: theme.primaryColor, size: 20),
                  color: kButtonColor,
                ),
                SizedBox(height: 4),
                AddressField(
                  icon: Icon(Icons.phone, size: 20, color: theme.primaryColor),
                  initialValue: '+1 9876543210',
                  color: kButtonColor,
                ),
                CustomButton(
                  radius: BorderRadius.circular(35.0),
                  padding: 10,
                  text: '     ' + locale.saveAddress2 + '     ',
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
