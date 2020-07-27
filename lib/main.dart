import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:provider/provider.dart';
import 'package:segcov/splash.app.dart';
import 'package:segcov/src/bloc/tracking.people.bloc.dart';
import 'package:segcov/src/config/notify.widget.dart';
import 'package:segcov/src/theme/theme.app.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => new LayoutModel(),
      child: ChangeNotifierProvider(
          create: (_) => new ThemeAplication(), child: MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeAplication>(
      builder: (BuildContext context, ThemeAplication theme, Widget child) {
        return MaterialApp(
          theme: theme.currentTheme,
          debugShowCheckedModeBanner: false,
          initialRoute: 'splashApp',
          routes: {
            'splashApp': (BuildContext context) {
              var state = Provider.of<LayoutModel>(context).isLoggedIn();
              return BlocProvider(
                child: SplashTrackingPeople(
                  isLoggedIn: state,
                ),
                bloc: TrackingPeopleBloc(),
              );
            }
          },
        );
      },
    );
  }
}
