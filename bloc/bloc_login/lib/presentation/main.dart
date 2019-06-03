import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import '../data/user_repository.dart';
import '../bloc/authentication/authentication.dart';
import 'splash.dart';
import 'login_page.dart';
import 'loading_indicator.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AuthenticationBloc authenticationBloc;
  UserRepository userRepository;

  @override
  void initState() {
    userRepository = UserRepository();
    authenticationBloc = AuthenticationBloc(userRepository: userRepository);
    authenticationBloc.dispatch(AppStarted());
    super.initState();
  }

  @override
  void dispose() {
    authenticationBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: authenticationBloc,
      child: MaterialApp(
        home: Scaffold(
            body: BlocBuilder(
                bloc: authenticationBloc,
                builder: (context, state) {
                  if (state is AuthenticationUninitialized) {
                    return SplashPage();
                  }
                  if (state is AuthenticationAuthenticated) {
                    return HomePage();
                  }
                  if (state is AuthenticationUnauthenticated) {
                    return LoginPage(
                      userRepository: userRepository,
                    );
                  }
                  if (state is AuthenticationLoading) {
                    return LoadingIndicator();
                  }
                })),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Container(
        child: Center(
            child: RaisedButton(
          child: Text('logout'),
          onPressed: () {
            authenticationBloc.dispatch(LoggedOut());
          },
        )),
      ),
    );
  }
}
