import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'create_page.dart';
import 'detail_page.dart';
import 'task_model.dart';
import 'task_provider.dart';
import 'home_page.dart';

class ListPageWidget extends StatelessWidget {
  const ListPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List<Task> tasks = Provider.of<TaskProvider>(context).tasks;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
          child: const Icon(
            Icons.chevron_left,
            color: Colors.red,
            size: 55.0,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: PopupMenuButton(
              itemBuilder: (context) => [
                const PopupMenuItem(
                  child: Row(
                    children: [
                      Icon(Icons.offline_bolt),
                      Text('see more'),
                    ],
                  ),
                ),
              ],
              child: const Icon(
                Icons.more_vert,
                size: 50.0,
              ),
            ),
          ),
        ],
      ),
      body: Consumer<TaskProvider>(
        builder:(context, taskProvider, child){
          List<Task> tasks =taskProvider.tasks;
       
      return Column(
        children: [
          const Image(image: AssetImage('images/list.png'), height: 230.0),
          const Padding(
            padding: EdgeInsets.fromLTRB(1.0, 0.0, 250.0, 8.0),
            child: Text(
              'Tasks list',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPageWidget(task: tasks[index]),
                      ),
                    );
                  },
                  child: Container(
                    height: 110.0,
                    child: Card(
                      child: Row(
                        children: [
                          Text(tasks[index].name,
                              style: const TextStyle(
                                fontSize: 19.0,
                                fontWeight: FontWeight.w400,
                              )),
                          const SizedBox(width: 10.0),
                          Text(tasks[index].design,
                              style: const TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              )),
                          const SizedBox(width: 10.0),
                          Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              tasks[index].date,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreatePageWidget(),
                  ),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
                foregroundColor: MaterialStateProperty.all(Colors.white),
                minimumSize: MaterialStateProperty.all(const Size(90, 30)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
              ),
              child: const Text('Create Task'),
            ),
          ),
        ],
      );
       } ,
      ),
    );
  }
}
