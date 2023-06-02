// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:student_app/models/boxes.dart';

import '../models/student.dart';

part 'student_event.dart';
part 'student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  StudentBloc() : super(StudentInitial()) {
    on<GetAllData>((event, emit) {
      final studentData = StudentBox.getstudentData();
      List<Student> studentslist = studentData.values.toList();
      emit(ViewAllStudents(students: studentslist));
    });
    on<AddData>((event, emit) {
      final studentBox = StudentBox.getstudentData();
      studentBox.add(event.Studentsdata);
      add(GetAllData());
    });
    on<EditData>((event, emit) {
      final studentData = StudentBox.getstudentData();
      studentData.putAt(event.index, event.studentModel);
      add(GetAllData());
    });
  }
}
