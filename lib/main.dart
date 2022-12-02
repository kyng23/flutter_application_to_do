import 'package:flutter/material.dart';
import "second_screen.dart";

//erörü gider sıkıntı clasta muhtemelen , inint metodunun calıstıgından emin ol ve create bastığında manuel girdiğin verileri terminae bastırsın sonra tecleri hallet
// Create bastığında dosya bilgilerini gönderip create file methodunu Row da çalıştırsın
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int fileId = 0;
  final todosList = ToDo.toDoList();

  bool startNewFilescreen = false;
  TextEditingController fileTitleTEC = TextEditingController();
  TextEditingController fileDateTEC = TextEditingController();
  TextEditingController fileExplanationTEC = TextEditingController();
  TextEditingController fileDueDateTEC = TextEditingController();

  void initState() {
    super.initState();
    fileDueDateTEC.text = "";
    fileExplanationTEC.text = "";
  }

  Widget buildFileScreen() => Container(
        color: Colors.blue,
        height: MediaQuery.of(context).size.height / 2.0,
        width: MediaQuery.of(context).size.width / 2,
        child: Stack(
          children: [
            Align(
              alignment: Alignment(-0.67, -1.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextField(
                        controller: fileTitleTEC,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Color.fromARGB(255, 255, 255, 255),
                          labelText: "Title",
                        )),
                    TextField(
                        controller: fileDateTEC,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Color.fromARGB(255, 255, 255, 255),
                          labelText: "Date",
                        )),
                    TextField(
                        controller: fileExplanationTEC,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Color.fromARGB(255, 255, 255, 255),
                          labelText: "Explanation",
                        )),
                    TextField(
                        controller: fileDueDateTEC,
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
                  setState(() {
                    startNewFilescreen = false;
                    fileTitleTEC.text = "";
                    fileDateTEC.text = "";
                    fileExplanationTEC.text = "";
                    fileDueDateTEC.text = "";
                  });
                },
                style: ElevatedButton.styleFrom(primary: Colors.purple),
                child: Text(
                  "Cancel",
                ),
              ),
            ),
            Align(
              alignment: Alignment(-1.0, 1.0),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    startNewFilescreen = false;
                    fileId++;
                    if (fileDateTEC.text != "" && fileTitleTEC.text != "") {
                      (todosList.add(ToDo(
                          id: fileId.toString(),
                          title: fileTitleTEC.text,
                          date: fileDateTEC.text,
                          explanation: fileExplanationTEC.text,
                          dueDate: fileDueDateTEC.text)));
                    }
                  });
                },
                style: ElevatedButton.styleFrom(primary: Colors.blue),
                child: Text("Create"),
              ),
            )
          ],
        ),
      );

  Widget buildPlusButton() => FloatingActionButton(
        backgroundColor: Colors.blue,
        shape: BeveledRectangleBorder(borderRadius: BorderRadius.zero),
        onPressed: () {
          setState(() {
            startNewFilescreen = true;
          });
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: AppBar(
                elevation: 0,
                title: const Text(
                  "TO DO APP",
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0,
                      color: Colors.white),
                ))),
        body: Center(
          child: Stack(
            children: [
              Scrollbar(
                  isAlwaysShown: true,
                  child: Wrap(
                    direction: Axis.horizontal,
                    children: [
                      for (ToDo toDoo in todosList)
                        ToDoItem(
                            todo: toDoo,
                            onToDoChange: toDoChange,
                            onDeleteItem: deleteItem,
                            onEdit: editItem)
                    ],
                  )),
              Align(
                  alignment: const Alignment(-1.0, -1.0),
                  child: buildPlusButton()),
              if (startNewFilescreen == true)
                (Align(
                    alignment: const Alignment(-1.0, -0.7),
                    child: buildFileScreen())),
            ],
          ),
        ));
  }

  void toDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void deleteItem(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

  void editItem(ToDo todo, String newTitle, String newDate,
      String newExplanation, String dueDate) {
    setState(() {
      todo.title = newTitle;
      todo.date = newDate;
      todo.explanation = newExplanation;
      todo.dueDate = dueDate;
    });
  }
}

class ToDo {
  String id;
  String title;
  String date;
  String explanation;
  String dueDate;
  bool isDone;

  ToDo(
      {required this.id,
      required this.title,
      required this.date,
      required this.explanation,
      required this.dueDate,
      this.isDone = false});

  static List<ToDo> toDoList() {
    return [];
  }
}

class ToDoItem extends StatelessWidget {
  final ToDo todo;

  final Function onToDoChange;
  final Function onDeleteItem;
  final Function onEdit;

  ToDoItem(
      {super.key,
      required this.todo,
      required this.onToDoChange,
      required this.onDeleteItem,
      required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment(-1.0, -0.8),
        child: Container(
          margin: EdgeInsets.all(10),
          color: Colors.amber,
          height: 100.0,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                    icon: Icon(
                      todo.isDone
                          ? Icons.check_box
                          : Icons.check_box_outline_blank,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      onToDoChange(todo);
                    }),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FloatingActionButton(
                      backgroundColor: Color.fromARGB(255, 255, 255, 255),
                      onPressed: (() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SecondPage(todoItem_: this)));
                      }),
                      child: const Icon((Icons.folder),
                          color: Colors.blue, size: 25),
                    ),
                    Text(
                      todo.title,
                      style: TextStyle(
                          decoration:
                              todo.isDone ? TextDecoration.lineThrough : null),
                    ),
                    Text(todo.date)
                  ],
                ),
                IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      onDeleteItem(todo.id);
                    }),
              ]),
        ));
  }
}
