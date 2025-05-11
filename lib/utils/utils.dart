import 'package:brick_offline_first_with_supabase/brick_offline_first_with_supabase.dart';
import 'package:offline_first_todo/data/brick/brick_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app_urls.dart';

class Utils{
  static Future<void> updateModel<T extends OfflineFirstWithSupabaseModel>(String tableName, Function fromMap) async {
    try {
      // Fetch the latest data from the server
      final response = await Supabase.instance.client.from(tableName).select();

      if (response == null || response is !List) {
        throw Exception('Invalid response from server for table $tableName');
      }

      // Use the model's fromMap function to deserialize server data
      final serverModels = (response as List).map((row) {
        try {
          return fromMap(row) as T;
        } catch (e) {
          throw Exception('Error deserializing data for model $T: $e');
        }
      }).toList();

      // Get all models currently in the local database
      final localModels = await BrickRepository().get<T>();

      // Update or insert models from the server into the local database
      for (var model in serverModels) {
        await BrickRepository().upsert<T>(model);
      }

      // Optionally, remove models from the local database that are no longer on the server
      final serverIds = serverModels.map((model) => (model as dynamic).id).toSet();
      for (var localModel in localModels) {
        if (!serverIds.contains((localModel as dynamic).id)) {
          await BrickRepository().delete<T>(localModel);
        }
      }
    } catch (e) {
      throw Exception('Error updating model $T: $e');
    }
  }
  
  static void feildFocusChange(
    BuildContext context,
      {required FocusNode current, required FocusNode next}){
    current.unfocus();
    FocusScope.of(context).requestFocus(next);
  }

}