import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_editing_app/view/home_page.dart';
import 'package:photo_editing_app/view_model/photo_editor_view_model.dart';
import 'package:provider/provider.dart';
import 'di_container.dart' as di;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  // GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  await di.init();
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => di.sl<PhotoEditorViewModel>()),
        ],
          child: MyApp()
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Photo Editing App',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home:  HomePage(),
    );
  }
}
