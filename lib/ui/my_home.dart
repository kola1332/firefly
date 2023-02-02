// ignore_for_file: avoid_unnecessary_containers, avoid_function_literals_in_foreach_calls, avoid_print

import 'package:firefly/network/model/api_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../network/model/task_model.dart';

class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Api testiing'),
      ),
      body: _listFutureTasks(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final api = Provider.of<ApiService>(context, listen: false);
          api.gettasks().then((it) {
            it.forEach((f) {
              print(f.title);
            });
          }).catchError((onError) {
            print(onError.toString());
          });
        },
        child: const Icon(Icons.terminal),
      ),
    );
  }

  FutureBuilder _listFutureTasks(BuildContext context) {
    return FutureBuilder<List<TaskModel>>(
      future: Provider.of<ApiService>(context, listen: false).gettasks(),
      builder: (BuildContext context, AsyncSnapshot<List<TaskModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Container(
              child: const Text('Something wrong'),
            );
          }
          final tasks = snapshot.data;
          if (tasks != null) {
            return _listTasks(context: context, tasks: tasks);
          } else {
            return Container(
              child: const Text('Something wrong'),
            );
          }
        } else {
          return Container(
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  ListView _listTasks(
      {required BuildContext context, required List<TaskModel> tasks}) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return Card(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: ListTile(
              leading: Image.network(tasks[index].url),
              title: Text(tasks[index].title),
            ),
          ),
        );
      },
    );
  }
}
