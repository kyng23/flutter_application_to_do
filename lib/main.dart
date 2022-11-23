import 'package:flutter/material.dart';
import 'second_screen.dart';

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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
  // ignore: unused_element

}

class _MyHomePageState extends State<MyHomePage> {
  int fileId = 0;
  final todosList = ToDo.toDoList();
  int fileNumber = 0;
  bool startNewFilescreen = false;
  TextEditingController fileTitleTEC = TextEditingController();
  TextEditingController fileDateTEC = TextEditingController();
  TextEditingController fileExplanationTEC = TextEditingController();
  TextEditingController fileDueDateTEC = TextEditingController();

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
                style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 147, 6, 147)),
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
                    if (fileDateTEC.text != "" && fileTitleTEC.text != "")
                      (todosList.add(ToDo(
                          id: fileId.toString(),
                          title: fileTitleTEC.text,
                          date: fileDateTEC.text,
                          explanation: fileExplanationTEC.text,
                          dueDate: fileDueDateTEC.text)));
                  });
                },
                style: ElevatedButton.styleFrom(primary: Colors.blue),
                child: Text("Create"),
              ),
            )
          ],
        ),
      );

  Widget buildPlusButton() => CircleAvatar(
      backgroundColor: Colors.blue,
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          setState(() {
            startNewFilescreen = true;
          });
        },
        iconSize: 26,
        icon: Icon(
          Icons.add,
          color: Color.fromARGB(255, 255, 255, 255),
        ),
      ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
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
        body: Center(
          child: Stack(
            children: [
              Row(
                children: [
                  for (ToDo toDoo in todosList)
                    ToDoItem(
                      todo: toDoo,
                      onToDoChange: toDoChange,
                      onDeleteItem: deleteItem,
                      onEdit: editItem,
                    )
                ],
              ),
              Align(alignment: Alignment(-1.0, -1.0), child: buildPlusButton()),
              if (startNewFilescreen == true)
                (Align(
                    alignment: Alignment(-1.0, -0.7),
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
  String? id;
  String? title;
  String? date;
  String? explanation;
  String? dueDate;
  bool isDone;

  ToDo(
      {required this.id,
      required this.title,
      required this.date,
      this.explanation,
      this.dueDate,
      this.isDone = false});

  static List<ToDo> toDoList() {
    return [];
  }
}

class ToDoItem extends StatelessWidget {
  final ToDo todo;
  final onToDoChange;
  final onDeleteItem;
  final onEdit;

  ToDoItem(
      {super.key,
      required this.todo,
      required this.onToDoChange,
      required this.onDeleteItem,
      required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment(1.0, -0.8),
        child: Container(
            margin: EdgeInsets.all(10),
            color: Colors.white,
            height: 100.0,
            child: Center(
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
                        CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 255, 255, 255),
                          child: IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: (() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SecondPage(
                                              title_: todo.title,
                                              date_: todo.date,
                                              dueDate_: todo.dueDate,
                                              explanation_: todo.explanation,
                                              id_: todo.id,
                                            )));
                              }),
                              iconSize: 27,
                              icon: Icon(Icons.folder, color: Colors.blue)),
                        ),
                        Text(
                          todo.title!,
                          style: TextStyle(
                              decoration: todo.isDone
                                  ? TextDecoration.lineThrough
                                  : null),
                        ),
                        Text(todo.date!)
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
            )));
  }
}
