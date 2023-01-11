import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  int id;
  Details({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Detalhes"),
          actions: [
            IconButton(
                onPressed: () => {Navigator.pop(context)},
                icon: const Icon(Icons.arrow_back)),
          ],
        ),
        body: Center(child: Text("Nova tela: $id")));
  }
}
