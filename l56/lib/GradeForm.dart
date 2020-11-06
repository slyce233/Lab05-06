import 'package:flutter/material.dart';
import 'package:l56/GradesModel.dart';
import 'ListGrades.dart';
import 'grades.dart';


enum GradeMode{
  Adding,
  Editing
}

class GradeForm extends StatefulWidget {
  StudentGrade student;
  final GradeMode gradeMode;

  GradeForm(this.student, this.gradeMode);
  @override
  _GradeForm createState() =>_GradeForm();

}

class _GradeForm extends State<GradeForm>{

  final _formKey = GlobalKey<FormState>();
  var _sid;
  var _grade;
  final _model = GradeModel();
  var _id;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _subtitleController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created b
        actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.chrome_reader_mode),
              tooltip: 'read',
              onPressed: () {
                _readGrades();
              },
            )],// the App.build method, and use it to set our appbar title.
        title: Text("Add Grade"),
      ),

      body: Container(
        padding: EdgeInsets.all(30.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                    children: [
                      Text("SID:",
                          textAlign: TextAlign.left,
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0)
                      ),
                        Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: widget.gradeMode == GradeMode.Adding? null : _sid),
                              onChanged: (value) => setState(() => _sid = value),
                            )
                        )
                    ]
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                Row(
                    children: [
                      Text("Grade:",
                          textAlign: TextAlign.left
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0)
                      ),
                      Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: widget.gradeMode == GradeMode.Adding? null : _grade),
                            onChanged: (value) => setState(() => _grade = value),
                          )
                      )
                    ]
                )
              ]
             ),
          ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          var form = _formKey.currentState;
          form.save();
          _addGrade();

        },
        tooltip: 'save',
        child: Icon(Icons.save),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  Future<void> _addGrade() async {
    StudentGrade grade = StudentGrade(sid: _sid, grade: _grade);
    _id = await _model.insertGrade(grade);
    print("Grade inserted: $_id");
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
