import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:gpvariedadesemgeral/my_website.dart';

/*void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
      statusBarColor: Color.fromRGBO(0, 0, 0, 40),
    ),
  );
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light, // Define o tema claro (background branco)
        // Aqui você pode configurar outras propriedades do tema, como cores primárias, secundárias, fontes, etc.
      ),
      home: const MyWebsite(),
    ),
  );
}*/


// Android

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        //statusBarIconBrightness: Brightness.dark,
        //statusBarBrightness: Brightness.light,
        statusBarColor: Color.fromRGBO(0, 0, 0, 40)));
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        //appBar: AppBar(title: const Text(TITLE)),
        body: MyWebsite(),
      ),
    );
  }
}
