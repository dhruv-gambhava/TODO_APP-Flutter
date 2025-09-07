import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  const DialogBox({super.key, this.controller, this.onSave, this.onCancel});

  final controller;
  final  onSave;
  final  onCancel;


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.deepPurple,
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),hintText: "Add New Work",
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: onCancel, child: Text("Cancel",style: TextStyle(color: Colors.white),)),
                SizedBox(width: 8,),
                TextButton(onPressed: onSave, child: Text("Add",style: TextStyle(color: Colors.white),)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
