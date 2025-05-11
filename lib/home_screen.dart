import 'package:flutter/material.dart';
import 'package:offline_first_todo/models/task.model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import './brick/repository.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Stream<List<Task>> taskStream = Repository().subscribe<Task>();

  // final Stream<List<Task>> taskStream = Supabase.instance.client
  //     .from('task')
  //     .stream(primaryKey: ['id'])
  //     .map((data) => data.map((row) => Task(
  //           id: row['id'],
  //           name: row['name'],
  //           isComplete: row['is_complete'],
  //         )).toList());

  void _refresh() async {
    try {
      // Fetch the latest data from the server
      final response =
          await Supabase.instance.client
              .from(
                'task',
              ) // Ensure the table name matches your Supabase table
              .select();

      if (response != null && response is List) {
        final serverTasks =
            response
                .map(
                  (row) => Task(
                    id: row['id'],
                    name: row['name'],
                    isComplete: row['is_complete'],
                  ),
                )
                .toList();

        // Get all tasks currently in the local database
        final localTasks = await Repository().get<Task>();

        // Update or insert tasks from the server into the local database
        for (var task in serverTasks) {
          await Repository().upsert<Task>(task);
        }

        // Optionally, remove tasks from the local database that are no longer on the server
        final serverTaskIds = serverTasks.map((task) => task.id).toSet();
        for (var localTask in localTasks) {
          if (!serverTaskIds.contains(localTask.id)) {
            await Repository().delete<Task>(localTask);
          }
        }
      } else {
        print('Error fetching tasks: Response is null or invalid');
      }
    } catch (e) {
      print('Exception during refresh: $e');
    }

    // Refresh the task stream
    setState(() {
      taskStream = Repository().subscribe<Task>();
    });
  }

  @override
  void initState() {
    super.initState();
    final session = Supabase.instance.client.auth.currentSession;
    if (session == null) {
      Supabase.instance.client.auth.signInAnonymously();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Offline First Todo',
      home: Scaffold(
        body: Center(
          child: RefreshIndicator(
            onRefresh: () async {
              _refresh();
            },
            child: StreamBuilder(
              stream: taskStream,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  final todos = snapshot.data as List<Task>;
                  return ListView.builder(
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(todos[index].name),
                        leading: Checkbox(
                          value: todos[index].isComplete,
                          onChanged: (value) {
                            Repository().upsert<Task>(
                              todos[index].copyWith(isComplete: value),
                            );
                          },
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            // Handle delete action
                            Repository().delete<Task>(todos[index]);
                          },
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else {
                  return const Center(child: Text("No Tasks"));
                }
              },
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            // Handle adding a new todo
            Repository().upsert<Task>(
              Task(name: 'New Task', isComplete: false),
            );

            // await Supabase.instance.client.from('tasks').insert({
            //   'id': Uuid(),
            //   'name': 'New Task',
            //   'is_complete': false,
            //   'user_id': "1234",
            // });
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
