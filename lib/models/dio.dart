

import 'package:dio/dio.dart';
import 'package:news_app/models/model.dart';

class DioClient{
  final Dio dio=Dio();
  Future<List<Article>> getNews()async{
    try{
      final Response response=await dio.get(
      "https://newsapi.org/v2/everything?q=tesla&from=2026-2-6&sortBy=publishedAt&apikey=d7c6f32c42c94424b884ab06169c3e2d"
    );
    if(response.statusCode==200){
      final data=NewsResponse.fromJson(response.data);
      final artList=data.articles;
      return artList;
    }else{
      print("erroe");
      return [];

    }
    }catch(e){
      print(e);
      return [];
    }
  }
}