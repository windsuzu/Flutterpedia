# localization

Plugin: 

* https://github.com/long1eu/flutter_i18n

Dependency: 

```
flutter_localizations:
  sdk: flutter
```

## Steps

1. Setup delegates at the root of app

```dart
import 'package:localization/generated/i18n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
```

```dart
MaterialApp(
    title: 'Localization Demo',
    localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
    ],
    supportedLocales: S.delegate.supportedLocales,
    home: Scaffold(
        body: HomePage(),
));
```

* [Complete Code is here](lib/main.dart)



2. Setup arb files

Plugin will help you generate `English` arb file automatically. 

File will be located at `res/values/strings_en.arb`.

```arb
{
  "localization_demo": "Localization Demo",
  "button": "Button"
}
```

You can now refer the values.

```dart
AppBar(
	title: Text(S.of(context).localization_demo),
	backgroundColor: Colors.green,
)
```



3. LocaleOverrideDelegate

