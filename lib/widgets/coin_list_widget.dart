import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:crypto_tracker/models/models.dart';
import 'package:flutter_svg/svg.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:crypto_tracker/screens/screens.dart';

class CoinListWidget extends StatelessWidget {
  final List<DataModel> coins;
  const CoinListWidget({Key? key, required this.coins}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var coinIconUrl =
        "https://raw.githubusercontent.com/spothq/cryptocurrency-icons/master/128/color/";

    return SafeArea(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0,vertical: 16.0),
          child: Text("Crypto Currency",
              style: Theme.of(context).textTheme.headline5,
          ),
        ),
        const SizedBox(height: 8.0,),
        Expanded(child: ListView.builder(
          itemExtent: 160.0,
            itemCount: coins.length,
            itemBuilder: (context,index){
              List<ChartData> data = [
                ChartData(coins[index].quoteModel.usdModel.percentChange_90d, 2160),
                ChartData(coins[index].quoteModel.usdModel.percentChange_60d, 1440),
                ChartData(coins[index].quoteModel.usdModel.percentChange_30d, 720),
                ChartData(coins[index].quoteModel.usdModel.percentChange_24h, 24),
                ChartData(coins[index].quoteModel.usdModel.percentChange_1h, 1),
              ];

          return GestureDetector(
            onTap:(){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => CoinDetailScreen(coin: coins[index])));
            },
            child: Container(
              height: 160.0,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              margin: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 16.0),
              decoration: BoxDecoration(
                color: Color.fromRGBO(0, 0, 0, 0.6),
                borderRadius: BorderRadius.circular(16.0),

              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding:  const EdgeInsets.only(left: 16.0),
                    height: 96.0,
                    width: 96.0,
                    child: Column(
                      children: [
                        Container(
                          height:50.0,
                          width: 50.0,
                          child: CachedNetworkImage(
                              imageUrl: (coinIconUrl + coins[index].symbol + ".png").toLowerCase(),
                          placeholder: (context, url)=> CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              SvgPicture.asset("assets/icons/dollar.svg"),),
                        ),
                        const SizedBox(height: 2.0,),
                        Text(coins[index].symbol,
                        style: Theme.of(context).textTheme.subtitle1,),
                        Text(
                          "\$"+
                            coins[index].quoteModel
                              .usdModel.price
                              .toStringAsFixed(2),
                            style: Theme.of(context).textTheme.subtitle2,
                        )
                      ],
                    )
                  ),
                  Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child:
                          Container(
                           padding: const EdgeInsets.only(left: 16.0),
                            height: 96.0,
                            width: double.infinity,
                            child: SfCartesianChart(
                              plotAreaBorderWidth: 0,
                              primaryXAxis: CategoryAxis(isVisible: false),
                                primaryYAxis: CategoryAxis(isVisible: false),
                              legend: Legend(isVisible: false),
                              tooltipBehavior: TooltipBehavior(enable: false),
                              series: <ChartSeries<ChartData, String>>[
                                LineSeries<ChartData,String >(
                                    dataSource: data,
                                    xValueMapper:(ChartData data,_) => data.year.toString(),
                                    yValueMapper: (ChartData data,_) => data.value)
                              ],
                            ),
                          )
                          ),
                          Container(
                            padding: const EdgeInsets.all(4.0),
                            margin: const EdgeInsets.only(right: 16.0),
                            alignment: Alignment.center,
                            width: 72,
                            height:36,
                            decoration: BoxDecoration(
                              color: coins[index].quoteModel.usdModel.percentChange_7d >= 0?
                              Colors.green : Colors.red,
                              borderRadius: BorderRadius.circular(16.0)
                                
                            ),
                            child: Text(
                              coins[index].quoteModel.usdModel.percentChange_7d.toStringAsFixed(2)
                                  +"%",
                              style: TextStyle(
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          )
                        ],
                      )),
                ],
              ),
            ),
          );
        }))
      ],
    ));
  }
}
