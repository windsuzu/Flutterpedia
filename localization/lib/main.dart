import 'package:flutter/material.dart';
import 'package:localization/generated/i18n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(MyApp());

SpecifiedLocalizationDelegate _localeOverrideDelegate;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _localeOverrideDelegate = SpecifiedLocalizationDelegate(null);
    return MaterialApp(
        title: 'Localization Demo',
        localizationsDelegates: [
          _localeOverrideDelegate,
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: Builder(
          builder: (context) => Scaffold(
                appBar: AppBar(
                  title: Text(S.of(context).localization_demo),
                  backgroundColor: Colors.green,
                ),
                body: HomePage(),
              ),
        ));
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FlatButton(
          shape: StadiumBorder(side: BorderSide(color: Colors.green)),
          onPressed: () {
            setState(() {
              _localeOverrideDelegate =
                  SpecifiedLocalizationDelegate(Locale('zh', 'TW'));
            });
          },
          child: Text(S.of(context).button)),
    );
  }
}

class SpecifiedLocalizationDelegate extends LocalizationsDelegate<S> {
  final Locale overriddenLocale;

  const SpecifiedLocalizationDelegate(this.overriddenLocale);

  @override
  bool isSupported(Locale locale) => overriddenLocale != null;

  @override
  Future<S> load(Locale locale) =>
      GeneratedLocalizationsDelegate().load(overriddenLocale);

  @override
  bool shouldReload(SpecifiedLocalizationDelegate old) => true;
}
