// GENERATED CODE DO NOT EDIT
part of '../brick.g.dart';

Future<Task> _$TaskFromSupabase(Map<String, dynamic> data,
    {required SupabaseProvider provider,
    OfflineFirstWithSupabaseRepository? repository}) async {
  return Task(
      id: data['id'] as String?,
      name: data['name'] as String,
      isComplete: data['is_complete'] as bool);
}

Future<Map<String, dynamic>> _$TaskToSupabase(Task instance,
    {required SupabaseProvider provider,
    OfflineFirstWithSupabaseRepository? repository}) async {
  return {
    'id': instance.id,
    'name': instance.name,
    'is_complete': instance.isComplete
  };
}

Future<Task> _$TaskFromSqlite(Map<String, dynamic> data,
    {required SqliteProvider provider,
    OfflineFirstWithSupabaseRepository? repository}) async {
  return Task(
      id: data['id'] as String,
      name: data['name'] as String,
      isComplete: data['is_complete'] == 1)
    ..primaryKey = data['_brick_id'] as int;
}

Future<Map<String, dynamic>> _$TaskToSqlite(Task instance,
    {required SqliteProvider provider,
    OfflineFirstWithSupabaseRepository? repository}) async {
  return {
    'id': instance.id,
    'name': instance.name,
    'is_complete': instance.isComplete ? 1 : 0
  };
}

/// Construct a [Task]
class TaskAdapter extends OfflineFirstWithSupabaseAdapter<Task> {
  TaskAdapter();

  @override
  final supabaseTableName = 'task';
  @override
  final defaultToNull = true;
  @override
  final fieldsToSupabaseColumns = {
    'id': const RuntimeSupabaseColumnDefinition(
      association: false,
      columnName: 'id',
    ),
    'name': const RuntimeSupabaseColumnDefinition(
      association: false,
      columnName: 'name',
    ),
    'isComplete': const RuntimeSupabaseColumnDefinition(
      association: false,
      columnName: 'is_complete',
    )
  };
  @override
  final ignoreDuplicates = false;
  @override
  final uniqueFields = {'id'};
  @override
  final Map<String, RuntimeSqliteColumnDefinition> fieldsToSqliteColumns = {
    'primaryKey': const RuntimeSqliteColumnDefinition(
      association: false,
      columnName: '_brick_id',
      iterable: false,
      type: int,
    ),
    'id': const RuntimeSqliteColumnDefinition(
      association: false,
      columnName: 'id',
      iterable: false,
      type: String,
    ),
    'name': const RuntimeSqliteColumnDefinition(
      association: false,
      columnName: 'name',
      iterable: false,
      type: String,
    ),
    'isComplete': const RuntimeSqliteColumnDefinition(
      association: false,
      columnName: 'is_complete',
      iterable: false,
      type: bool,
    )
  };
  @override
  Future<int?> primaryKeyByUniqueColumns(
      Task instance, DatabaseExecutor executor) async {
    final results = await executor.rawQuery('''
        SELECT * FROM `Task` WHERE id = ? LIMIT 1''', [instance.id]);

    // SQFlite returns [{}] when no results are found
    if (results.isEmpty || (results.length == 1 && results.first.isEmpty)) {
      return null;
    }

    return results.first['_brick_id'] as int;
  }

  @override
  final String tableName = 'Task';

  @override
  Future<Task> fromSupabase(Map<String, dynamic> input,
          {required provider,
          covariant OfflineFirstWithSupabaseRepository? repository}) async =>
      await _$TaskFromSupabase(input,
          provider: provider, repository: repository);
  @override
  Future<Map<String, dynamic>> toSupabase(Task input,
          {required provider,
          covariant OfflineFirstWithSupabaseRepository? repository}) async =>
      await _$TaskToSupabase(input, provider: provider, repository: repository);
  @override
  Future<Task> fromSqlite(Map<String, dynamic> input,
          {required provider,
          covariant OfflineFirstWithSupabaseRepository? repository}) async =>
      await _$TaskFromSqlite(input, provider: provider, repository: repository);
  @override
  Future<Map<String, dynamic>> toSqlite(Task input,
          {required provider,
          covariant OfflineFirstWithSupabaseRepository? repository}) async =>
      await _$TaskToSqlite(input, provider: provider, repository: repository);
}
