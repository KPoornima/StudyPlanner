import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test3/models/task_data.dart';
import 'package:test3/widgets/tasks_tile.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TasksWidget extends StatefulWidget {
  @override
  _TasksWidgetState createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {
  SharedPreferences sharedPreferences;
  @override
  void initState() {
    initSharedPreferences();
    super.initState();
  }

  void initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskdata, child) {
        return GridView.builder(
          reverse: false,
          itemCount: Provider.of<TaskData>(context).tasks.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),

          itemBuilder: (context, index) {
            return Dismissible(
              direction: DismissDirection.horizontal,
              key: UniqueKey(),
              background: Container(
                margin: EdgeInsets.fromLTRB(0, 8, 0, 8),
                color: Colors.redAccent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Icon(
                        Icons.delete,
                        size: 30,
                      ),
                    ),
                    Text("Delete?"),
                  ],
                ),
              ),
              secondaryBackground: Container(
                margin: EdgeInsets.fromLTRB(0, 8, 0, 8),
                color: Colors.redAccent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Delete?"),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Icon(
                        Icons.delete,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
              onDismissed: (direction) {
                taskdata.deleteTask(taskdata.tasks[index]);
                BotToast.showSimpleNotification(
                  title: "Study Planner",
                  subTitle: 'Deleted the task Successfully',
                  borderRadius: 10.0,
                );
              },
              child: TaskTile(
                taskTitle: taskdata.tasks[index].name,
                isTrue: Provider.of<TaskData>(context).tasks[index].isdone,
                delpresscallback: () {
                  taskdata.deleteTask(taskdata.tasks[index]);
                  BotToast.showSimpleNotification(
                    title: "Study Planner",
                    subTitle: 'Deleted the task Successfully',
                    borderRadius: 10.0,
                  );
                },
                checkBoxCallBack: (checkBoxState) {
                  taskdata.updateTask(taskdata.tasks[index]);
                },
              ),
            );
          },
        );
      },
    );
  }
}
