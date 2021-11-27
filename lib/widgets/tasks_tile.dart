import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final bool isTrue;
  final String taskTitle;
  final Function checkBoxCallBack;
  final Function delpresscallback;

  const TaskTile(
      {this.isTrue,
        this.taskTitle,
        this.checkBoxCallBack,
        this.delpresscallback});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
        decoration: BoxDecoration(
          color: isTrue ? Colors.black54 : Colors.lightGreenAccent,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 5,
            ),
          ],
        ),
        child: GridTile(
          footer: GridTileBar(
            leading: Switch(
              activeColor: Colors.blue,
              inactiveThumbColor: Colors.white.withOpacity(0.8),
              inactiveTrackColor: Colors.grey,
              value: isTrue,
              onChanged: checkBoxCallBack,
            ),
            title: SizedBox(
              width: 10,
            ),
          trailing: GestureDetector(
            onTap: delpresscallback,
            child: Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                margin: EdgeInsets.only(bottom: 5.0),
                height: 300,
                width: 250,
                child: Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Center(
                        child: Text(
                      taskTitle,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        decoration: isTrue ? TextDecoration.lineThrough : null,
                      ),
                    )),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}