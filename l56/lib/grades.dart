class StudentGrade {
  int id;
  String sid = '';
  String grade = '';

  StudentGrade({this.sid, this.grade});

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'sid': this.sid,
      'grade': this.grade,
    };
  }

  StudentGrade.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.sid = map['sid'];
    this.grade = map['grade'];
  }

  String toString() {
    return 'Grade {id: $id, sid: $sid, grade: $grade}';
  }
}
