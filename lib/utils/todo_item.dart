import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({super.key, required this.isChecked, required this.todoText, this.onChanged, this.onPressed});

final bool isChecked;
final String todoText;

final Function(bool?)? onChanged;
final Function(BuildContext)? onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Slidable(
        endActionPane: ActionPane(
            motion: StretchMotion(),
            children: [
              SlidableAction(onPressed: onPressed,
              icon: Icons.delete,
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.circular(12),
              )
            ]),
        child: Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.deepPurple[500],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(children: [
            Checkbox(value: isChecked, onChanged: onChanged,),
            Text(todoText,
              style: TextStyle(
                decoration: isChecked ?
                    TextDecoration.lineThrough:TextDecoration.none,
                color:  Colors.white,
                fontSize: 16,
              ),),
          ]),
        ),
      ),
    );
  }
}
