// ignore_for_file: non_constant_identifier_names, duplicate_ignore

part of 'student_bloc.dart';

@immutable
abstract class StudentEvent extends Equatable {
  List<Object> get properties => [];
}

class AddData extends StudentEvent {
  // ignore: non_constant_identifier_names
  final Student Studentsdata;
  AddData({required this.Studentsdata});
  @override
  List<Object?> get props => [Studentsdata];
}

class GetAllData extends StudentEvent {
  GetAllData();
  @override
  List<Object> get props => [];
}

class EditData extends StudentEvent {
  final Student studentModel;
  final int index;

  EditData({
    required this.studentModel,
    required this.index,
  });
  @override
  List<Object?> get props => [studentModel, index];
}
