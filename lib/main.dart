import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'task.dart';
import 'task_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskList(),
      child: MaterialApp(
        title: 'To-Do List',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: TaskListScreen(),
      ),
    );
  }
}

class TaskListScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var tasksProvider = Provider.of<TaskList>(context);
    var tasks = tasksProvider.tasks;

    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(tasks[index].name),
            subtitle: Text(tasks[index].description),
            onTap: () {
              // Görev detaylarına git
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Yeni Görev Ekle"),
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextField(
                        controller: _nameController,
                        decoration: InputDecoration(labelText: 'Görev Adı'),
                      ),
                      TextField(
                        controller: _descriptionController,
                        decoration: InputDecoration(labelText: 'Açıklama'),
                      ),
                      TextField(
                        controller: _startDateController,
                        decoration: InputDecoration(labelText: 'Başlangıç Tarihi'),
                      ),
                      TextField(
                        controller: _endDateController,
                        decoration: InputDecoration(labelText: 'Bitiş Tarihi'),
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('İptal'),
                  ),
                  TextButton(
                    onPressed: () {
                      Task newTask = Task(
                        name: _nameController.text,
                        description: _descriptionController.text,
                        startDate: _startDateController.text,
                        endDate: _endDateController.text,
                      );
                      tasksProvider.addTask(newTask);
                      Navigator.of(context).pop();
                    },
                    child: Text('Ekle'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
