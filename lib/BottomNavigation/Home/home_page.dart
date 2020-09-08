import 'package:fz_courier/Locale/locales.dart';
import 'package:fz_courier/Theme/style.dart';
import 'package:flutter/material.dart';
import 'package:fz_courier/Routes/routes.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class Card {
  Card(this.icon, this.title, this.subtitle, this.onPress);
  String icon;
  String title;
  String subtitle;
  var onPress;
}

class Ad {
  Ad(this.img, this.text, this.location);
  String img;
  String text;
  String location;
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    final List<Card> cards = [
      Card(
        "images/home1.png",
        locale.arrangeDeliv,
        locale.arrangeDelivText,
        PageRoutes.arrangeDeliveryPage,
      ),
      Card(
        "images/home2.png",
        locale.getFood,
        locale.getFoodText,
        PageRoutes.getFoodDeliveredPage,
      ),
      Card(
        "images/home3.png",
        locale.getGrocery,
        locale.getGroceryText,
        PageRoutes.getGroceryDeliveredPage,
      ),
    ];
    final List<Ad> ads = [
      Ad(
        "images/promo1.png",
        locale.orderFromUs20Discounts,
        "Yellas Fast Food",
      ),
      Ad(
        "images/promo2.png",
        locale.orderFromUsWepaydeliveryCharge,
        "City Grocery Store",
      ),
    ];
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: Padding(
        padding: EdgeInsets.only(bottom: 64.0),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Stack(
              children: [
                Image.asset("images/banner.png"),
                Padding(
                  padding: EdgeInsets.only(top: 230),
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: cards.length,
                      itemBuilder: (context, index) {
                        return buildCard(cards[index]);
                      }),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                '\n' + locale.promo + '\n',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            Container(
              height: 150,
              child: ListView.builder(
                  itemCount: ads.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return buildAdsContainer(ads[index]);
                  }),
            )
          ],
        ),
      ),
    );
  }

  Container buildCard(Card card) {
    return Container(
      margin: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
      decoration: BoxDecoration(
          boxShadow: [boxShadow],
          borderRadius: BorderRadius.circular(10.0),
          color: Theme.of(context).backgroundColor),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 12.0,
        ),
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Image.asset(card.icon),
        ),
        title: Text(
          card.title,
          style: Theme.of(context).textTheme.subtitle1.copyWith(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
        ),
        subtitle: Text(
          '\n' + card.subtitle,
          style: Theme.of(context)
              .textTheme
              .subtitle2
              .copyWith(color: Theme.of(context).dividerColor),
        ),
        onTap: () => Navigator.pushNamed(context, card.onPress),
      ),
    );
  }

  Container buildAdsContainer(Ad ad) {
    return Container(
      margin: EdgeInsets.only(left: 8, bottom: 6.0),
      width: 192.0,
      decoration: BoxDecoration(
          boxShadow: [boxShadow],
          image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.45), BlendMode.darken),
              image: AssetImage(ad.img),
              fit: BoxFit.fill),
          borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              ad.text,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(color: Theme.of(context).backgroundColor),
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.location_on,
                  size: 18.0,
                  color: Theme.of(context).primaryColor,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    ad.location,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
