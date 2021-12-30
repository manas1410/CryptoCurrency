import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_tracker/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:crypto_tracker/widgets/widgets.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CoinDetailScreen extends StatefulWidget {
  final DataModel coin;

  const CoinDetailScreen({Key? key, required this.coin}) : super(key: key);

  @override
  _CoinDetailScreenState createState() => _CoinDetailScreenState();
}



class _CoinDetailScreenState extends State<CoinDetailScreen> {
  List<bool> _isSelected = [true,false,false,false,false];
  @override
  Widget build(BuildContext context) {

    var coinIconUrl =
        "https://raw.githubusercontent.com/spothq/cryptocurrency-icons/master/128/color/";
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEE d MMM').format(now);
    dynamic currentTime = DateFormat.jm().format(DateTime.now());
    List<ChartData> data = [
      ChartData(widget.coin.quoteModel.usdModel.percentChange_90d, 2160),
      ChartData(widget.coin.quoteModel.usdModel.percentChange_60d, 1440),
      ChartData(widget.coin.quoteModel.usdModel.percentChange_30d, 720),
      ChartData(widget.coin.quoteModel.usdModel.percentChange_24h, 24),
      ChartData(widget.coin.quoteModel.usdModel.percentChange_1h, 1),
    ];
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
                      imageUrl: (coinIconUrl + widget.coin.symbol + ".png").toLowerCase(),
                      placeholder: (context, url)=> CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          SvgPicture.asset("assets/icons/dollar.svg"),),
                  ),
                  title: Text(
                    widget.coin.name+" "+widget.coin.symbol + " #"+widget.coin.cncRank.toString(),
                    style: Theme.of(context).textTheme.subtitle1,
                      overflow: TextOverflow.ellipsis,
                  ),
                )
              ),
              background: Image.asset("assets/images/3.png",
                fit: BoxFit.cover ,),
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
              delegate: SliverAppBarDelegate(
                  maxHeight: 360.0,
                  minHeight: 360.0,
                child: Padding(
                  padding: const EdgeInsets.only(top: 32.0,),
                  child:  Column(children: [
                    Text(
                      "\$ "+ widget.coin.quoteModel.usdModel.price .toStringAsFixed(2),
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    Text(
                      formattedDate+" "+currentTime,
                      style: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: 18.0,
                        color: Colors.grey
                      ),
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

                          ],
                        )
                    ),
                    const SizedBox(height: 8.0,),
                    ToggleButtons(
                      borderRadius: BorderRadius.circular(8.0),
                      borderColor: Colors.indigoAccent,
                      color: Colors.white,
                      fillColor: Colors.green,
                      selectedColor: Colors.white,
                      selectedBorderColor: Colors.indigoAccent,
                      children: [
                       ToggleButton(name: "Today"),
                        ToggleButton(name: "7D"),
                        ToggleButton(name: "1M"),
                        ToggleButton(name: "3M"),
                        ToggleButton(name: "6M")
                      ],
                      isSelected: _isSelected,
                      onPressed: (int newIndex){
                        setState((){

                          for (int i=0;i<_isSelected.length;i++){
                            if (i==newIndex) {
                              _isSelected[i] = true;
                            }
                            else{
                              _isSelected[i] = false;
                            }
                          }
                          //print(_isSelected);
                        });

                      },
                    ),

                  ],
                  ),
                )
              )

          )
        ],
      )
    );
  }
}
