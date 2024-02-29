import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_page.dart';
import 'task_model.dart';
import 'task_provider.dart';

class CreatePageWidget extends StatefulWidget {
  const CreatePageWidget({super.key});

  @override
  CreatePage createState() => CreatePage();
}

class CreatePage extends State<CreatePageWidget> {
  TextEditingController taskNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Center(
              child: Text(
                'Create a new task',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
              ),
            ),
            const SizedBox(height: 5.0),
            const Text(
              'Main task name',
              style: TextStyle(fontSize: 16.0, color: Colors.red),
            ),
            const SizedBox(height: 8.0),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                controller: taskNameController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(16.0),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Due date',
              style: TextStyle(fontSize: 16.0, color: Colors.red),
            ),
            const SizedBox(height: 8.0),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: InkWell(
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2022),
                    lastDate: DateTime(2025),
                  );
                  if (pickedDate != null && pickedDate != selectedDate) {
                    setState(() {
                      selectedDate = pickedDate;
                    });
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        selectedDate != null
                            ? selectedDate!.toLocal().toString().split(' ')[0]
                            : ' ',
                      ),
                      const Icon(
                        Icons.calendar_today,
                        size: 30,
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Description',
              style: TextStyle(fontSize: 16.0, color: Colors.red),
            ),
            const SizedBox(height: 8.0),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(16.0),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 45.0),
            ElevatedButton(
              onPressed: () {
                if (taskNameController.text.isNotEmpty && selectedDate != null) {
                  Provider.of<TaskProvider>(context, listen: false).addTask(
                    Task(
                      name: taskNameController.text,
                      date: selectedDate!.toLocal().toString().split(' ')[0],
                      design: descriptionController.text,
                    ),
                  );

                  Navigator.pop(context);
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
                minimumSize: MaterialStateProperty.all(const Size(5, 30)),
              ),
              child: const Text(
                'Add a task',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
