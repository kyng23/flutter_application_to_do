import 'package:flutter/material.dart';
import 'main.dart';

//wrapi horizantal çalıştır alta geç
//genel olarak hızlandırma
//sized box
//circle avatar
//set state
class SecondPage extends StatefulWidget {
  SecondPage({super.key, required this.todoItem_});

  ToDoItem todoItem_;

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  bool startNewFilescreen = false;
  TextEditingController _fileTitleTEC = TextEditingController();
  TextEditingController _fileDateTEC = TextEditingController();
  TextEditingController _fileExplanationTEC = TextEditingController();
  TextEditingController _fileDueDateTEC = TextEditingController();

  void initState() {
    super.initState();
    _fileTitleTEC.text = widget.todoItem_.todo.title;
    _fileDateTEC.text = widget.todoItem_.todo.date;
    _fileExplanationTEC.text = widget.todoItem_.todo.explanation;
    _fileDueDateTEC.text = widget.todoItem_.todo.dueDate;
  }

  Widget buildExplanation() => Container(
        color: Color.fromARGB(255, 255, 255, 255),
        height: MediaQuery.of(context).size.height / 4.0,
        width: MediaQuery.of(context).size.width / 1.01,
        child: Text(widget.todoItem_.todo.explanation),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: AppBar(
              elevation: 0,
              title: const Text(
                "TO DO LISTS",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ))),
      body: Stack(
        children: [
          Align(
            alignment: Alignment(-1.0, -1.0),
            child: Container(
              color: Colors.blue,
              height: 1000,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment(-0.67, -1.0),
                    child: Column(
                        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextField(
                              controller: _fileTitleTEC,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                filled: true,
                                fillColor: Colors.white,
                                labelText: "Title",
                              )),
                          TextField(
                              controller: _fileDateTEC,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                filled: true,
                                fillColor: Colors.white,
                                labelText: "Date",
                              )),
                          TextField(
                              controller: _fileExplanationTEC,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                filled: true,
                                fillColor: Colors.white,
                                labelText: "Explanation",
                              )),
                          TextField(
                              controller: _fileDueDateTEC,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                filled: true,
                                fillColor: Colors.white,
                                labelText: "Due When",
                              )),
                        ]),
                  ),
                  Align(
                    alignment: const Alignment(1.0, 0.3),
                    child: ElevatedButton(
                      onPressed: () {
                        widget.todoItem_.onEdit(
                            widget.todoItem_.todo,
                            _fileTitleTEC.text,
                            _fileDateTEC.text,
                            _fileExplanationTEC.text,
                            _fileDueDateTEC.text);
                      },
                      style: ElevatedButton.styleFrom(primary: Colors.red),
                      child: Text("Apply Changes"),
                    ),
                  )
                ],
              ),
            ),
          ),
          Align(alignment: Alignment(-1.0, 1.0), child: buildExplanation())
        ],
      ),
    );
  }
}
// clası boz applyın on pressediyle oyna

