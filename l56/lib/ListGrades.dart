import 'package:flutter/material.dart';
import 'package:l56/GradeForm.dart';
import 'package:l56/GradesModel.dart';
import 'grades.dart';

Widget buildListGrades() {
  return ListGrades();
}

class ListGrades extends StatefulWidget {
  @override
  _ListGrades createState() => _ListGrades();
}

class _ListGrades extends State<ListGrades> {
  final _model = GradeModel();
  StudentGrade grade;
  int _selectedIndex;
  Future grades = GradeModel().getAllGrades();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Forms and SQlite"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: 'Edit',
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => GradeForm(this.grade, GradeMode.Editing)));
              print(grades);}

          ),
          IconButton(
            icon: const Icon(Icons.delete),
            tooltip: 'Delete',
            onPressed: () {
              _deleteGrade(_selectedIndex);
            },
          )
        ],
      ),
      body:FutureBuilder<List>(
        future: _model.getAllGrades(),
        initialData: List(),
        builder:(context,snapshot){
          final grades = snapshot.data;
          return
            ListView.builder(
              itemCount: grades.length,
              itemBuilder: (context, index) {
                return Container(
                  color: (_selectedIndex == index+1)
                      ? Colors.lightBlue
                      : Colors.transparent,
                  child: ListTile(
                    title: Text(grades[index].sid,
                        textAlign: TextAlign.left),
                    subtitle: Text(grades[index].grade, textAlign: TextAlign.left),
                    onTap: () {
                      {
                        setState(() {
                          //  (index == 0)?{_selectedIndex = index + 1}:
                          _selectedIndex = index+1;
                        });
                        print(grades[index]);
                      };
                    },
                  ),

                );
              }
             );
          },
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => GradeForm(grade, GradeMode.Adding)));
        },
        tooltip: 'add new',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _deleteGrade(int index) async {
    _model.deleteGradeWithId(index);
    print("id deleted");
  }


  Future<void> _readGrades() async {
    List<StudentGrade> grades = await _model.getAllGrades();

    print('');
    print('Grades:');
    for (StudentGrade grade in grades) {
      print(grade);
    }
  }
}
