import 'models.dart';
class DataModel {
  final int id;
  final String name;
  final String symbol;
  final String slug;
  final int numMarketPairs;
  final String dateAdded;
  final List<dynamic> tags;
  final int maxSupply;
  final num circulatingSupply;
  final num totalSupply;
  final int cncRank;
  final String lastUpdated;
  final QuoteModel quoteModel;

  DataModel({required this.id,
    required this.name,
    required this.slug,
    required this.symbol,
    required this.numMarketPairs,
    required this.dateAdded,
    required this.tags,
    required this.maxSupply,
    required this.circulatingSupply,
    required this.totalSupply,
    required this.cncRank,
    required this.lastUpdated,
    required this.quoteModel});
  factory DataModel.fromJson(Map<String, dynamic>json){
    return DataModel(id: json["id"],
        name: json["name"],
        slug: json["slug"],
        symbol: json["symbol"],
        numMarketPairs: json["num_market_pairs"],
        dateAdded: json["date_added"],
        tags: json["tags"],
        maxSupply: json["max_supply"] == null ? 0: json["max_supply"] ,
        circulatingSupply: json["circulating_supply"],
        totalSupply: json["total_supply"],
        cncRank: json["cnc_rank"] == null ? 0: json["cnc_rank"],
        lastUpdated: json["last_updated"],
        quoteModel: QuoteModel.fromJson(json["quote"]));
  }
}