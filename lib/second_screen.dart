import 'package:flutter/material.dart';
import 'main.dart';

class SecondPage extends StatefulWidget {
  SecondPage({
    super.key,
    this.title_,
    this.date_,
    this.dueDate_,
    this.explanation_,
    this.id_,
  });
  String? id_;
  String? title_;
  String? date_;
  String? dueDate_;
  String? explanation_;

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  late ToDoItem _toDoItem;
  //Second Page sınıfındaki değişkenleri edit sınıfına aktaramıyorum
  //onları aktarmak için tanımladığım _secondToDo nun önüne gelecek şeylerin hepsini denedim ama kabul etmedi
  /* ?*/ //_seconToDo;

  bool startNewFilescreen = false;
  TextEditingController _fileTitleTEC = TextEditingController();
  TextEditingController _fileDateTEC = TextEditingController();
  TextEditingController _fileExplanationTEC = TextEditingController();
  TextEditingController _fileDueDateTEC = TextEditingController();

  void initState() {
    super.initState();
    _fileTitleTEC.text = this.widget.title_.toString();
    _fileDateTEC.text = this.widget.date_.toString();
    _fileExplanationTEC.text = this.widget.explanation_.toString();
    _fileDueDateTEC.text = this.widget.dueDate_.toString();
  }

  Widget buildExplanation() => Container(
        color: Color.fromARGB(255, 255, 255, 255),
        height: MediaQuery.of(context).size.height / 4.0,
        width: MediaQuery.of(context).size.width / 1.01,
        child: Text(this.widget.explanation_.toString()),
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
          /*Align(
            alignment: Alignment(-1.0, -1.0),
            child: ToDoEdit(
              secondTodo: _seconToDo,
              toDoItem: _toDoItem,
            ),
          ),*/
          Align(alignment: Alignment(-1.0, 1.0), child: buildExplanation())
        ],
      ),
    );
  }
}

class ToDoEdit extends StatelessWidget {
  _SecondPageState secondTodo;
  final ToDoItem toDoItem;

  ToDoEdit({super.key, required this.secondTodo, required this.toDoItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      height: 1000,
      child: Stack(
        children: [
          Align(
            alignment: Alignment(-0.67, -1.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextField(
                      controller: secondTodo._fileTitleTEC,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Color.fromARGB(255, 255, 255, 255),
                        labelText: "Title",
                      )),
                  TextField(
                      controller: secondTodo._fileDateTEC,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Color.fromARGB(255, 255, 255, 255),
                        labelText: "Date",
                      )),
                  TextField(
                      controller: secondTodo._fileExplanationTEC,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Color.fromARGB(255, 255, 255, 255),
                        labelText: "Explanation",
                      )),
                  TextField(
                      controller: secondTodo._fileDueDateTEC,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Color.fromARGB(255, 255, 255, 255),
                        labelText: "Due When",
                      )),
                ]),
          ),
          Align(
            alignment: Alignment(1.0, 1.0),
            child: ElevatedButton(
              onPressed: () {
                toDoItem.onEdit(
                    toDoItem.todo,
                    secondTodo._fileTitleTEC.text,
                    secondTodo._fileDateTEC.text,
                    secondTodo._fileExplanationTEC.text,
                    secondTodo._fileDueDateTEC.text);
              },
              style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 52, 198, 41)),
              child: Text("Apply Changes"),
            ),
          )
        ],
      ),
    );
  }
}
