import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:list_api_app/src/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController controller = HomeController();

  @override
  void initState() {
    controller.getComments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Get comments"),
        actions: [
          IconButton(
              onPressed: () async => await controller.getComments(),
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: Container(
          padding: const EdgeInsets.all(12),
          child: ValueListenableBuilder(
            valueListenable: controller.isLoading,
            builder: ((context, value, child) {
              if (value) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return ValueListenableBuilder(
                  valueListenable: controller.comments,
                  builder: (context, value, child) {
                    if (value.isEmpty) {
                      return const Center(
                        child: Text("Não há dados na lista."),
                      );
                    }

                    return ListView.builder(
                      itemCount: value.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                              color: index % 2 == 0
                                  ? Colors.white
                                  : Colors.blue[50],
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(.4),
                                    blurRadius: 5,
                                    offset: const Offset(0, 2),
                                    spreadRadius: 2)
                              ]),
                          width: MediaQuery.of(context).size.width - 50,
                          height: 200,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Id: ${value[index].id} / Post id: ${value[index].postId}",
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                    overflow: TextOverflow.ellipsis),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(value[index].email,
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.grey)),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                value[index].body,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontStyle: FontStyle.italic,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                maxLines: 5,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              }
            }),
          )),
    );
  }
}
