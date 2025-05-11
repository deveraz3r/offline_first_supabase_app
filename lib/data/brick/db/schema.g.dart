// GENERATED CODE DO NOT EDIT
// This file should be version controlled
import 'package:brick_sqlite/db.dart';
part '20250511055643.migration.dart';

/// All intelligently-generated migrations from all `@Migratable` classes on disk
final migrations = <Migration>{const Migration20250511055643()};

/// A consumable database structure including the latest generated migration.
final schema =
    Schema(20250511055643, generatorVersion: 1, tables: <SchemaTable>{
  SchemaTable('Task', columns: <SchemaColumn>{
    SchemaColumn('_brick_id', Column.integer,
        autoincrement: true, nullable: false, isPrimaryKey: true),
    SchemaColumn('id', Column.varchar, unique: true),
    SchemaColumn('name', Column.varchar),
    SchemaColumn('is_complete', Column.boolean)
  }, indices: <SchemaIndex>{
    SchemaIndex(columns: ['id'], unique: true)
  })
});
