import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/database/database.dart';
import 'package:todo_app/utils/dialog_box.dart';
import 'package:todo_app/utils/todo_item.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final _controller = TextEditingController();
  final _myBox = Hive.box("mybox");
  TodoDatabase db = TodoDatabase();

  @override
  void initState()
  {
    if(_myBox.get("TODOLIST")==null)
      {
        db.createData();
      }
    else
      {
        db.loadData();
      }
    super.initState();
  }

  // List TodoList = [
  //   ["TODO", false],
  //   ["TODO", false],
  //   ["TODO", false],
  //   ["TODO", false],
  //   ["TODO", false],
  //   ["TODO", false],
  // ];

  void deleteTask(int index)
  {
    setState(() {
      db.TodoList.removeAt((index));
    });
    db.updateDatabase();
  }

  void checkBoxChanged(bool? value, int index)
  {
    setState(() {
      db.TodoList[index][1] = !db.TodoList[index][1];
    });
    db.updateDatabase();
  }
  void saveNewTask()
  {
    setState(() {
      db.TodoList.add([_controller.text,false]);
      _controller.clear();
      Navigator.of(context).pop();
    });
    db.updateDatabase();
  }
  void createNewTask()
  {
    showDialog(context: context, builder: (context)
        {
          return DialogBox(
            controller: _controller,
            onCancel: ()=> Navigator.of(context).pop(),
            onSave: saveNewTask,
          );
        }
    );

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[200],
      appBar: AppBar(
        title: const Text("TODO",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.deepPurple[400],
        elevation: 10,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple[400],
        onPressed: createNewTask,
        child: Icon(Icons.add,color: Colors.white,),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return TodoItem(
            isChecked: db.TodoList[index][1],
            todoText: db.TodoList[index][0],
            onChanged: (value)=> checkBoxChanged(value,index),
            onPressed: (context)=> deleteTask(index),
          );
        },
        itemCount: db.TodoList.length,
      ),
    );
  }
}
