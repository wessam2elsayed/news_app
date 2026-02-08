import 'package:flutter/material.dart';
import 'package:news_app/features/home/presentation/screens/details_screen.dart';
import 'package:news_app/models/dio.dart';
import 'package:news_app/models/model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int selectedIndex = 0;

  DioClient dioClient = DioClient();

  List<Article> articles = [];

  @override
  void initState() {
    dioClient.getNews("all").then((value) {
      setState(() {
        articles = value;
      });
    });
    super.initState();
  }

  List sortArticle = [
    "all",
    "popularity",
    "business",
    "entertainment",
    "health",
    "science",
    "sports",
    "technology",
  ];

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: articles.isEmpty
              ? Center(child: CircularProgressIndicator())
              : CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(child: const SizedBox(height: 20)),
                    SliverAppBar(
                      centerTitle: true,
                      title: Text(
                        "News App",

                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(child: const SizedBox(height: 20)),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 150,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: articles.length,
                          shrinkWrap: true,
                          itemBuilder: (ctx, index) {
                            return Container(
                              width: 300,
                              height: 150,
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.blue,
                                image: DecorationImage(
                                  image: NetworkImage(
                                    articles[index].urlToImage ??  "",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 80,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: sortArticle.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                  articles.clear();
                                  dioClient.getNews(sortArticle[index]).then((value) {
                                 return setState(() {
                                    articles = value;
                                  });
                                });
                                
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 5,
                                ),
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 20),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: selectedIndex == index
                                          ? Colors.blue
                                          : Colors.black,
                                    ),
                                    borderRadius: BorderRadius.circular(17),
                                    color: selectedIndex == index
                                        ? Colors.blue
                                        : Colors.white,
                                  ),
                                  child: Center(
                                    child: Text(sortArticle[index]),
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 10);
                          },
                        ),
                      ),
                    ),

                    SliverToBoxAdapter(
                      child: ListView.builder(
                        itemCount: sortArticle.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (ctx, index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailsScreen(article: articles[index],)
                                  ));
                                },
                                child: Container(
                                  width: 140,
                                  height: 140,
                                  margin: EdgeInsets.only(bottom: 20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.blue,
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        articles[index].urlToImage ??"",
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),

                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    Text(
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      articles[index].title,
                                    ),
                                    const SizedBox(height: 30),
                                    Text(
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                      articles[index].description ?? "",
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
        ),
      ),

      // FutureBuilder(
      //   future:   dioClient.getNews(),
      //   builder: (context, asyncSnapshot) {
      //     if(asyncSnapshot.hasData){
      //       return ListView.builder(
      //       itemCount: asyncSnapshot.data?.length??0,
      //       itemBuilder: (context,index){
      //         return Column(
      //           children: [
      //             Image.network(asyncSnapshot.data?[index].urlToImage??""),
      //             const SizedBox(height: 10,),
      //             Text(asyncSnapshot.data?[index].title??"")

      //           ],
      //         );
      //       });
      //     }else{
      //       return Center(child: CircularProgressIndicator());
      //     }
      //   }
      // ),
    );
  }
}
