
import 'package:get_it/get_it.dart';
import 'package:photo_editing_app/view_model/photo_editor_view_model.dart';


final sl = GetIt.instance;

Future<void> init() async {

  /// Core

  /// Repository

  /// Provider
  sl.registerFactory(() => PhotoEditorViewModel());
  /// External


}