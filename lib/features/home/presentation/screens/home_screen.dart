import 'package:flutter/material.dart';
import 'package:news_app/models/dio.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  DioClient dioClient=DioClient();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future:   dioClient.getNews(),
        builder: (context, asyncSnapshot) {
          if(asyncSnapshot.hasData){
            return ListView.builder(
            itemCount: asyncSnapshot.data?.length??0,
            itemBuilder: (context,index){
              return Column(
                children: [
                  Image.network(asyncSnapshot.data?[index].urlToImage??""),
                  const SizedBox(height: 10,),
                  Text(asyncSnapshot.data?[index].title??"")
          
                ],
              );
            });
          }else{
            return Center(child: CircularProgressIndicator());
          }
        }
      ),
    );
  }
}