import 'package:flutter/material.dart';
import 'package:localization/generated/i18n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SpecifiedLocalizationDelegate _localeOverrideDelegate;

  @override
  void initState() {
    super.initState();
    _localeOverrideDelegate = SpecifiedLocalizationDelegate(null);
    applic.onLocaleChanged = (locale) {
      setState(() {
        final newLocale = (locale.languageCode == 'zh')
            ? Locale('en', '')
            : Locale('zh', 'TW');

        applic.currentLocale = newLocale;
        _localeOverrideDelegate = SpecifiedLocalizationDelegate(newLocale);
      });
    };
  }

  @override
  Widget build(BuildContext context) {
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
          onPressed: () => applic.onLocaleChanged(applic.currentLocale),
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

typedef void LocaleChangeCallback(Locale locale);

class APPLIC {
  final List<String> supportedLanguages = ['en', 'zh'];

  Iterable<Locale> supportedLocales() =>
      supportedLanguages.map<Locale>((lang) => Locale(lang, ''));

  LocaleChangeCallback onLocaleChanged;
  Locale currentLocale = Locale('en');
  static final APPLIC _applic = APPLIC._internal();

  factory APPLIC() {
    return _applic;
  }

  APPLIC._internal();
}

APPLIC applic = new APPLIC();
