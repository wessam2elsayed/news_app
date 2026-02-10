import 'package:flutter/material.dart';
import 'package:news_app/features/home/data/models/article_model.dart';
// import 'package:news_app/models/model.dart';

class DetailsScreen extends StatelessWidget {
  final Article article;
  const DetailsScreen({super.key, required this.article}); 

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 50,),
              Row(
                children: [
                  IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: Icon(Icons.arrow_back)),
                  const SizedBox(width: 80,),
                  Text("News details",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),),
                ],
              ),
              const SizedBox(height: 20,),
              Container(
                width: 300,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: NetworkImage(
                      article.urlToImage ?? "",
                    ),
                    fit: BoxFit.cover,
              ),
                ),
              ),
              const SizedBox(height: 20,),
              Text(article.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),),
              const SizedBox(height: 30,),
              Text(article.description??"",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),),
            ],
          ),
        ),
      ),
    );
  }
}