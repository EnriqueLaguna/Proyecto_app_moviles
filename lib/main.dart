import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_app_moviles/HomePage/homePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:proyecto_app_moviles/Login/auth/bloc/auth_bloc.dart';
import 'package:proyecto_app_moviles/Login/login.dart';
import 'package:proyecto_app_moviles/Perfil/bloc/create_catalogo_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc()..add(VerifyAuthEvent())
        ),
        BlocProvider(
          create: ((context) => CreateCatalogoBloc()),
        ),
      ], 
      child: MyApp()
    )
  );
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Material App',
        theme: ThemeData(primarySwatch: Colors.lightGreen),
        home: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthErrorState){
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Favor de autenticarse"))
              );
            }
          },
          builder: (context, state) {
            if(state is AuthSuccessState){
              return HomePage();
            } else if(state is UnAuthState || state is AuthErrorState){
              return LoginPage();
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
