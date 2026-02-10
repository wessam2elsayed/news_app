import 'package:dio/dio.dart';
import 'package:news_app/features/home/data/models/article_model.dart';
import 'package:news_app/features/home/data/models/news_model.dart';


class DioClient{
  final Dio dio=Dio();
  // List<Article> articles=[];
  Future<List<Article>> getNews(String sort)async{
    try{
      final Response response=await dio.get(
               "https://newsapi.org/v2/everything?q=tesla&from=2026-02-08&sortBy=$sort&apiKey=d7c6f32c42c94424b884ab06169c3e2d"
      // "https://newsapi.org/v2/everything?q=news&from=2026-01-27&to=2026-01-27&sortBy=$sort&apikey=d7c6f32c42c94424b884ab06169c3e2d"
    );
    if(response.statusCode==200){
      final data=NewsResponse.fromJson(response.data);
      final artList=data.articles;
      // articles=artList;
      return artList;
    }else{
      print("Failed to load data: ${response.statusCode}");
      throw Exception("Failed to load news: ${response.statusCode}");
      // return [];

    }
    }catch(e){
      print(e);
      throw Exception("Failed to load news: $e");
      // return [];
    }
  }
}