import 'package:hive/hive.dart';

part 'noteDB.g.dart';

@HiveType(typeId: 0)
class Note {
  @HiveField(0)
  String title ="";

  @HiveField(1)
  String note =""; 
}