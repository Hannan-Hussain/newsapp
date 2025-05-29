import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsapp/controllers/news_controller.dart';

class HeadlinesScreen extends StatelessWidget {
  const HeadlinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(NewsController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Headlines"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              controller.getNews();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Obx(
          () {
            if (controller.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.black),
              );
            } else if (controller.news.isEmpty) {
              return const Center(child: Text("No News Found!"));
            } else {
              return ListView.builder(
                itemCount: controller.news.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(10),
                    height: 250,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color:
                          const Color.fromARGB(255, 153, 145, 145).withOpacity(0.4), 
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              controller.news[index].urlToImage ?? '',
                              fit: BoxFit.cover,
                              height: 150,
                              width: double.infinity,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 60,
                                width: 150,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                      5), 
                                ),
                                child: Center(
                                  child: Text(
                                    controller.news[index].title.length > 20
                                        ? "${controller.news[index].title.substring(0, 20)}..."
                                        : controller.news[index].title,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 40,
                                width: 150,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(
                                  child: Text(
                                    controller.news[index].publishedAt,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
