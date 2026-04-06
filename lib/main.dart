import 'package:device_preview_plus/device_preview_plus.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

//IMPORT controller
import 'controller/inicio_controller.dart';
import 'controller/login_controller.dart';
import 'controller/cadastro_controller.dart';
import 'controller/recuperar_senha_controller.dart';
import 'controller/sobre_controller.dart';
import 'controller/home_controller.dart';
import 'controller/my_pets_controller.dart';
import 'controller/agendar_controller.dart';
import 'controller/chat_controller.dart';
import 'controller/historico_controller.dart';
import 'controller/notificacao_controller.dart';

//IMPORT view
import 'view/inicio_view.dart';
import 'view/login_view.dart';
import 'view/cadastro_view.dart';
import 'view/recuperar_senha_view.dart';
import 'view/sobre_view.dart';
import 'view/home_view.dart';
import 'view/my_pets_view.dart';
import 'view/agendar_view.dart';
import 'view/chat_view.dart';
import 'view/historico_view.dart';
import 'view/notificacao_view.dart';

final g = GetIt.instance;

void setup() {
  g.registerSingleton<InicioController>(InicioController());
  g.registerLazySingleton<LoginController>(() => LoginController());
  g.registerLazySingleton<CadastroController>(() => CadastroController());
  g.registerLazySingleton<RecuperarSenhaController>(() => RecuperarSenhaController());
  g.registerLazySingleton<SobreController>(() => SobreController());
  g.registerLazySingleton<HomeController>(() => HomeController());
  g.registerLazySingleton<MyPetsController>(() => MyPetsController());
  g.registerLazySingleton<AgendarController>(() => AgendarController());
  g.registerLazySingleton<ChatController>(() => ChatController());
  g.registerLazySingleton<HistoricoController>(() => HistoricoController());
  g.registerLazySingleton<NotificacaoController>(() => NotificacaoController());
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

      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('pt', 'BR'),
      ],
      locale: const Locale('pt', 'BR'),
      debugShowCheckedModeBanner: false,
      title: 'Clinica',

      initialRoute: 'inicio',
      routes: {
        'inicio': (context) => InicioView(),
        'login': (context) => LoginView(),
        'cadastro': (context) => CadastroView(),
        'recuperar_senha': (context) => RecuperarSenhaView(),
        'sobre': (context) => SobreView(),
        'home': (context) => HomeView(),
        'my_pets': (context) => MyPetsView(),
        'agendar': (context) => AgendarView(),
        'chat': (context) => ChatView(),
        'historico': (context) => HistoricoView(),
        'notificacao': (context) => NotificacaoView(),
      },
    );
  }
}
