import 'package:fz_courier/Locale/locales.dart';
import 'package:fz_courier/Routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AccountBody();
  }
}

class AccountBody extends StatefulWidget {
  @override
  _AccountBodyState createState() => _AccountBodyState();
}

class _AccountBodyState extends State<AccountBody> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    var mediaQuery = MediaQuery.of(context);
    var theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: mediaQuery.size.height - mediaQuery.padding.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.0),
                  child: Text(
                    locale.accountText,
                    style:
                        TextStyle(color: theme.backgroundColor, fontSize: 28),
                  ),
                ),
                Spacer(),
                InkWell(
                  onTap: () =>
                      Navigator.pushNamed(context, PageRoutes.myProfilePage),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 28.0),
                    child: Row(
                      children: [
                        Hero(
                          tag: 'profile_pic',
                          child: CircleAvatar(
                            radius: 36.0,
                            backgroundImage: AssetImage('images/profile.png'),
                          ),
                        ),
                        SizedBox(width: 24.0),
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: "Samantha Smith" + '\n',
                              style: theme.textTheme.headline5,
                            ),
                            TextSpan(text: locale.viewProfile)
                          ]),
                        )
                      ],
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  height: mediaQuery.size.height * 0.75,
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
                      buildListTile(
                        Icons.location_on,
                        locale.savedAddresses,
                        locale.saveAddress,
                        onTap: () {
                          Navigator.pushNamed(
                              context, PageRoutes.savedAddressesPage);
                        },
                      ),
                      buildListTile(
                        Icons.mail,
                        locale.contactUs,
                        locale.contactQuery,
                        onTap: () {
                          Navigator.pushNamed(
                              context, PageRoutes.contactUsPage);
                        },
                      ),
                      buildListTile(
                        Icons.assignment,
                        locale.tnc,
                        locale.knowtnc,
                        onTap: () {
                          Navigator.pushNamed(context, PageRoutes.tncPage);
                        },
                      ),
                      buildListTile(Icons.call_split, locale.shareApp,
                          locale.shareFriends,
                          onTap: () {}),
                      buildListTile(
                        Icons.exit_to_app,
                        locale.logout,
                        locale.signoutAccount,
                        onTap: () {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(locale.loggingout),
                                  content: Text(locale.sureText),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text(locale.no),
                                      textColor: theme.primaryColor,
                                      shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              color: theme.backgroundColor)),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                    FlatButton(
                                        child: Text(locale.yes),
                                        shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                color: theme.backgroundColor)),
                                        textColor: theme.primaryColor,
                                        onPressed: () {
                                          Phoenix.rebirth(context);
                                        })
                                  ],
                                );
                              });
                        },
                      ),
                      Spacer(flex: 4),
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

  Widget buildListTile(IconData icon, String title, String subtitle,
      {Function onTap}) {
    var theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20.0),
      child: ListTile(
        leading: Icon(
          icon,
          color: theme.primaryColor,
        ),
        title: Text(
          title,
          style: theme.textTheme.headline5.copyWith(
              color: theme.primaryColorDark, height: 1.72, fontSize: 22),
        ),
        subtitle: Text(subtitle,
            style: theme.textTheme.subtitle1.copyWith(height: 1.3)),
        onTap: onTap,
      ),
    );
  }
}
