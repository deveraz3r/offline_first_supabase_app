// Your model definition can live anywhere in lib/**/* as long as it has the .model.dart suffix
// Assume this file is saved at my_app/lib/src/users/user.model.dart

import 'package:brick_offline_first_with_supabase/brick_offline_first_with_supabase.dart';
import 'package:brick_sqlite/brick_sqlite.dart';
import 'package:brick_supabase/brick_supabase.dart';
import 'package:uuid/uuid.dart';

@ConnectOfflineFirstWithSupabase(
  supabaseConfig: SupabaseSerializable(tableName: 'task'),
)
class Task extends OfflineFirstWithSupabaseModel {
  // Be sure to specify an index that **is not** auto incremented in your table.
  // An offline-first strategy requires distributed clients to create
  // indexes without fear of collision.
  @Supabase(unique: true)
  @Sqlite(index: true, unique: true)
  final String id; //unique id for each task

  final String name;
  final bool isComplete;

  Task({String? id, required this.name, required this.isComplete})
    : this.id = id ?? const Uuid().v4();

  // Factory constructor to create a Task from a Map
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] as String,
      name: map['name'] as String,
      isComplete: map['is_complete'] as bool,
    );
  }

  // Method to convert a Task to a Map
  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'is_complete': isComplete};
  }

  Task copyWith({String? name, bool? isComplete}) {
    return Task(
      id: this.id,
      name: name ?? this.name,
      isComplete: isComplete ?? this.isComplete,
    );
  }
}
