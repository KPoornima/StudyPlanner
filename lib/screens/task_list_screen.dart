import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:test3/models/task_data.dart';
import 'package:test3/widgets/tasks_list.dart';
import 'add_task_screen.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

// ignore: camel_case_types
class Tasks_List_screen extends StatelessWidget {
// ignore: camel_case_types
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 80,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      extendBodyBehindAppBar: true,
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              accountName: Text(
                "Study Planner",
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              accountEmail: Text("To-Do List"),
              currentAccountPicture: Image(image: AssetImage("assets/logo.png")),
            ),
            ListTile(
              leading: Icon(Icons.check_box),
              title: Text('Check All'),
              enabled: true,
              onTap: () {
                checkAll(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.check_box_outline_blank_rounded),
              title: Text('UnCheck All'),
              onTap: () {
                uncheckAll(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.delete),
              title: Text('Delete All'),
              onTap: () {
                Alert(
                  context: context,
                  type: AlertType.warning,
                  title: "Study Planner",
                  desc:
                  'This will delete all the tasks and is irreversible.\n Do you want to continue?',
                  buttons: [
                    DialogButton(
                      child: Text(
                        "NO",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () => Navigator.pop(context),
                      color: Color.fromRGBO(220, 0, 0, 1.0),
                    ),
                    DialogButton(
                      child: Text(
                        "YES",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () {
                        delAll(context);
                      },
                      color: Color.fromRGBO(0, 200, 0, 1.0),
                    )
                  ],
                ).show();
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About'),
              onTap: () {
                Alert(
                  context: context,
                  type: AlertType.warning,
                  title: "Study Planner",
                  desc:
                  'An easy-to-use Study Planner To-Do List App\n\n - Press the plus button to add a task\n - Check, Uncheck, or Delete any or all tasks\n',
                ).show();
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.amber,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context, builder: (context) => Add_Task_screen());
        },
        elevation: 12.0,
        backgroundColor: Colors.amber,
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding:
              EdgeInsets.only(top: 5.0, left: 50, right: 50.0, bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Image(
                        height: 100,
                        width: 100,
                        image: AssetImage(
                          "assets/logo.png",
                        ),
                      ),
                      Text(
                        "To-Do",
                        style: TextStyle(
                          fontSize: 50.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.lightBlueAccent,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                        margin: EdgeInsets.all(10),
                        child: Text(
                          '${Provider.of<TaskData>(context).tasks.length}',
                          style: TextStyle(
                              fontSize: 60.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                      Text(
                        ' Tasks left',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontFamily: 'OpenSans-Light',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 2.0,
                  vertical: 2.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: TasksWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void delAll(BuildContext context) {
  Provider.of<TaskData>(context, listen: false).deleteAll();
  BotToast.showSimpleNotification(
    title: "Study Planner",
    subTitle: 'All tasks Deleted Successfully ',
    borderRadius: 5.0,
  );
  Navigator.pop(context);
}

void checkAll(BuildContext context) {
  Provider.of<TaskData>(context, listen: false).checkAll();
  BotToast.showSimpleNotification(
    title: "Study Planner",
    subTitle: 'All tasks Checked Successfully ',
    borderRadius: 5.0,
  );
  Navigator.pop(context);
}

void uncheckAll(BuildContext context) {
  Provider.of<TaskData>(context, listen: false).uncheckAll();
  BotToast.showSimpleNotification(
    title: "Study Planner",
    subTitle: 'All tasks Unchecked Successfully ',
    borderRadius: 5.0,
  );
  Navigator.pop(context);
}