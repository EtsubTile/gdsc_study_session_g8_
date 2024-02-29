import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/home_page.dart';
import 'package:to_do_list/task_model.dart';
import 'package:to_do_list/task_provider.dart';

class DetailPageWidget extends StatefulWidget {
  const DetailPageWidget({super.key, required this.task});

  final Task task;

  @override
  DetailPage createState() => DetailPage();
}

class DetailPage extends State<DetailPageWidget> {
  void deleteTask(Task task) {
    Provider.of<TaskProvider>(context, listen: false).deleteTask(task);
    Navigator.pop(context);
  }

  void updateTask(Task oldTask, Task newTask) {
    Provider.of<TaskProvider>(context, listen: false)
        .updateTask(oldTask, newTask);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Detail'),
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
                    children: [Icon(Icons.offline_bolt), Text('see more')],
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
      body: Column(
        children: [
          const Image(
            image: AssetImage('images/download (2).png'),
            height: 270.0,
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(36.0, 0.0, 305.0, 5.0),
            child: Text('Title', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
            child: Container(
              width: 300.0,
              height: 50.0,
              decoration: BoxDecoration(
                color: const Color.fromARGB(220, 239, 233, 233),
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Text(widget.task.name),
            ),
          ),
          const SizedBox(height: 10.0),
          const Padding(
            padding: EdgeInsets.fromLTRB(36.0, 0.0, 275.0, 5.0),
            child: Text('Description',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
            child: Container(
              width: 300.0,
              height: 150.0,
              decoration: BoxDecoration(
                color: const Color.fromARGB(220, 239, 233, 233),
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Text(widget.task.design),
            ),
          ),
          const SizedBox(height: 10.0),
          const Padding(
            padding: EdgeInsets.fromLTRB(36.0, 0.0, 285.0, 5.0),
            child:
                Text('Due date', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
            child: Container(
              width: 300.0,
              height: 50.0,
              decoration: BoxDecoration(
                color: const Color.fromARGB(220, 239, 233, 233),
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Text(widget.task.date),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(48.0, 15.0, 5.0, 5.0),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Provider.of<TaskProvider>(context, listen: false).deleteTask(widget.task);
                    Navigator.pop(context);
                    //deleteTask(widget.task);
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                      foregroundColor: MaterialStateProperty.all(Colors.white)),
                  child: const Text('Delete Task'),
                ),
                const SizedBox(width: 10.0),
                ElevatedButton(
                  onPressed: () {
                    _showUpdateDialog(); // Removed task argument
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                      foregroundColor: MaterialStateProperty.all(Colors.white)),
                  child: const Text('Update Task'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showUpdateDialog() async {
    TextEditingController nameController =
        TextEditingController(text: widget.task.name);
    TextEditingController designController =
        TextEditingController(text: widget.task.design);
    TextEditingController dateController =
        TextEditingController(text: widget.task.date);

    Task? updatedTask = await showDialog<Task>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Task Name'),
              ),
              const SizedBox(height: 8.0),
              TextField(
                controller: designController,
                decoration: const InputDecoration(labelText: 'Task Design'),
              ),
              const SizedBox(height: 8.0),
              InkWell(
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2022),
                    lastDate: DateTime(2025),
                  );
                  if (pickedDate != null) {
                    dateController.text =
                        pickedDate.toLocal().toString().split(' ')[0];
                  }
                },
                child: IgnorePointer(
                  child: TextField(
                    controller: dateController,
                    decoration: const InputDecoration(labelText: 'Due Date'),
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Task newTask = Task(
                  name: nameController.text,
                  design: designController.text,
                  date: dateController.text,
                );
                Provider.of<TaskProvider>(context, listen: false).updateTask(widget.task, newTask);
                Navigator.of(context).pop(newTask);
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );

    if (updatedTask != null) {
      Provider.of<TaskProvider>(context, listen: false).updateTask(widget.task, updatedTask);
    }
  }
}
