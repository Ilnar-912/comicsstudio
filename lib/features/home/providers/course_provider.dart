// import 'package:flutter/material.dart';

// import '../domain/entities/course_entity.dart';
// import '../domain/usecases/get_courses_usecase.dart';


// class CourseProvider extends ChangeNotifier {
//   final GetCoursesUseCase getCoursesUseCase;
//   List<CourseEntity> _courses = [];
//   bool _isLoading = false;

//   CourseProvider(this.getCoursesUseCase);

//   List<CourseEntity> get courses => _courses;
//   bool get isLoading => _isLoading;

//   Future<void> loadCourses() async {
//     _isLoading = true;
//     notifyListeners();

//     _courses = await getCoursesUseCase();
//     _isLoading = false;
//     notifyListeners();
//   }
// }
