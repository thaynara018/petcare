import 'package:device_preview_plus/device_preview_plus.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

//IMPORT controller
import 'controller/inicio_controller.dart';
import 'controller/login_controller.dart';
import 'controller/cadastro_controller.dart';
import 'controller/recuperar_senha_controller.dart';
import 'controller/sobre_controller.dart';

//NAO CONCLUIDO/INICIADO
//import 'controller/home_controller.dart';
//import 'controller/my_pets_controller.dart';
//import 'controller/chat_controller.dart';

//IMPORT view
import 'view/inicio_view.dart';
import 'view/login_view.dart';
import 'view/cadastro_view.dart';
import 'view/recuperar_senha_view.dart';
import 'view/sobre_view.dart';

//NAO CONCLUIDO/INICIADO
//import 'view/home_view.dart';
//import 'view/my_pets_view.dart';
//import 'view/chat_view.dart';


final g = GetIt.instance;


void setup() {
  g.registerSingleton<InicioController>(InicioController());
  g.registerLazySingleton<LoginController>(() => LoginController());
  g.registerLazySingleton<CadastroController>(() => CadastroController());
  g.registerLazySingleton<RecuperarSenhaController>(() => RecuperarSenhaController());
  g.registerLazySingleton<SobreController>(() => SobreController());
}

void main() {
 setup();
 runApp(
    DevicePreview(
      builder: (context) => const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clinica',

      initialRoute: 'inicio',
      routes: {
        'inicio': (context) => InicioView(),
        'login': (context) => LoginView(),
        'cadastro': (context) => CadastroView(),
        'recuperar_senha': (context) => RecuperarSenhaView(),
        'sobre': (context) => SobreView(),
      

        //'home': (context) => HomeView(),
        //'my_pets': (context) => MyPetsView(),
        //'chat': (context) => ChatView(),

        
      },
    );
  }
}
