// GENERATED CODE EDIT WITH CAUTION
// THIS FILE **WILL NOT** BE REGENERATED
// This file should be version controlled and can be manually edited.
part of 'schema.g.dart';

// While migrations are intelligently created, the difference between some commands, such as
// DropTable vs. RenameTable, cannot be determined. For this reason, please review migrations after
// they are created to ensure the correct inference was made.

// The migration version must **always** mirror the file name

const List<MigrationCommand> _migration_20250511055643_up = [
  InsertTable('Task'),
  InsertColumn('id', Column.varchar, onTable: 'Task', unique: true),
  InsertColumn('name', Column.varchar, onTable: 'Task'),
  InsertColumn('is_complete', Column.boolean, onTable: 'Task'),
  CreateIndex(columns: ['id'], onTable: 'Task', unique: true)
];

const List<MigrationCommand> _migration_20250511055643_down = [
  DropTable('Task'),
  DropColumn('id', onTable: 'Task'),
  DropColumn('name', onTable: 'Task'),
  DropColumn('is_complete', onTable: 'Task'),
  DropIndex('index_Task_on_id')
];

//
// DO NOT EDIT BELOW THIS LINE
//

@Migratable(
  version: '20250511055643',
  up: _migration_20250511055643_up,
  down: _migration_20250511055643_down,
)
class Migration20250511055643 extends Migration {
  const Migration20250511055643()
    : super(
        version: 20250511055643,
        up: _migration_20250511055643_up,
        down: _migration_20250511055643_down,
      );
}
