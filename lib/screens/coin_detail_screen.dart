import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_tracker/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CoinDetailScreen extends StatelessWidget {
  final DataModel coin;
  const CoinDetailScreen({Key? key, required this.coin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var coinIconUrl =
        "https://raw.githubusercontent.com/spothq/cryptocurrency-icons/master/128/color/";
    return Scaffold(
        backgroundColor: Color.fromRGBO(11, 12, 54, 1),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(

            shape:  RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(36.0),
            ),
            pinned: true,
            snap: true,
            floating: true,
            expandedHeight: 280.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Container(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                padding: const EdgeInsets.fromLTRB(0.0, 24.0, 4.4, 0.0),
                width: double.infinity,
                height: 56.0,
                child: ListTile(
                  leading: Container(
                    height:40.0,
                    width: 40.0,
                    child: CachedNetworkImage(
                      imageUrl: (coinIconUrl + coin.symbol + ".png").toLowerCase(),
                      placeholder: (context, url)=> CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          SvgPicture.asset("assets/icons/dollar.svg"),),
                  ),
                  title: Text(
                    coin.name+" "+coin.symbol + " #"+(coin.cncRank+1).toString(),
                    style: Theme.of(context).textTheme.subtitle1,
                      overflow: TextOverflow.ellipsis

                  ),
                )
              ),
            ),
          )
        ],
      )
    );
  }
}
