// Import Flutter
import 'dart:isolate';

import 'package:flutter/material.dart';

// Import Packages
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triple_switch/triple_switch.dart';

// Import Layers
import 'package:business_layer/business_layer.dart';
import 'package:design_layer/design_layer.dart';
import 'package:model_layer/model_layer.dart';

// Import Localizations
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


// Import Widgets
import 'widgets/switch_tile.dart';

class SettingsPage extends StatefulWidget {
  static const routeName = '/settings';

  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {



  SwitchPosition? swPos = SwitchPosition.off;
  bool? swResult;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, DefaultTheme>(
      builder: (BuildContext ctx, DefaultTheme state) {
        return Scaffold(
          appBar: AppBar(title: Text(AppLocalizations.of(context)!.settings_title)),
          body: BlocBuilder<AppBloc, AppState>(
              builder: (BuildContext appCtx, AppState appState) {
                return Center(
                  child: ListView(
                    children: [
                      SwitchTile(
                        icon: Icons.sunny,
                        title: AppLocalizations.of(context)!.settings_swSystemTheme_title,
                        subtitle: AppLocalizations.of(context)!.settings_swSystemTheme_subtitle,
                        child: Switch.adaptive(
                          applyCupertinoTheme: false,
                          value: locator.get<ThemeController>().get() == ThemeMode.system,
                          onChanged: (value) {
                            (value)
                                ? ctx.read<ThemeBloc>().add(ChangeEvent(themeMode: ThemeMode.system))
                                : ctx.read<ThemeBloc>().add(ChangeEvent(themeMode: ThemeMode.light));
                          },
                        ),
                      ),
                      SwitchTile(
                        enabled: locator.get<ThemeController>().get() != ThemeMode.system,
                        icon: Icons.dark_mode,
                        title: AppLocalizations.of(context)!.settings_swDarkTheme_title,
                        subtitle: AppLocalizations.of(context)!.settings_swDarkTheme_subtitle,
                        child: Switch.adaptive(
                          applyCupertinoTheme: false,
                          value: locator.get<ThemeController>().get() == ThemeMode.dark,
                          onChanged: locator.get<ThemeController>().get() == ThemeMode.system ? null
                              : (value) {
                            (value)
                                ? ctx.read<ThemeBloc>().add(ChangeEvent(themeMode: ThemeMode.dark))
                                : ctx.read<ThemeBloc>().add(ChangeEvent(themeMode: ThemeMode.light));
                          },
                        ),
                      ),
                      Divider(),
                      SwitchTile(
                        icon: Icons.security,
                        title: AppLocalizations.of(context)!.settings_swAuthLocal_title,
                        subtitle: AppLocalizations.of(context)!.settings_swAuthLocal_subtitle,
                        child: Switch.adaptive(
                          applyCupertinoTheme: false,
                          value: appState.auth_local ?? false,
                          onChanged: (value) => ctx.read<AppBloc>().add(ChangeAuthLocal(value: value)),
                        ),
                      ),
                      SwitchTile(
                        icon: Icons.lock_open,
                        title: AppLocalizations.of(context)!.settings_swAutoLogin_title,
                        subtitle: AppLocalizations.of(context)!.settings_swAutoLogin_subtitle,
                        child: Switch.adaptive(
                          applyCupertinoTheme: false,
                          value: appState.auto_login ?? false,
                          onChanged: (value) => ctx.read<AppBloc>().add(ChangeAutoLogin(value: value)),
                        ),
                      ),

                      SwitchTile(
                        icon: Icons.recycling,
                        title: 'Тест Triple switch',
                        subtitle: 'Тестирование виджета',
                        child: TripleSwitch(
                          id: 'switchTest',
                          value: swPos,         // TODO: Get it from Hive
                          result: swResult,
                          timeoutOffOn: 20,
                          timeoutOnOff: 10,
                          // actionOffOn: () => function2(), / null
                          // actionOnOff: () => function1(), / null
                          onChanged: (value) {
                            setState(() => swPos = value); // TODO: Save value to Hive

                            // Run Heavy Function
                            final ReceivePort receivePort = ReceivePort();
                            locator.get<SomeDataController>().getData(receivePort);

                            receivePort.listen((res) {
                              print('Result ready: ${res}');
                              setState(() {
                                swResult = true;
                              });
                              receivePort.close();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
          ),
        );
      },
    );
  }
}

// TripleSwitch(
//    id: 'switchSecurity',
//    value: locator.get<Hive>().getPosition,                 // swPos is bool position of switch
//    timeoutOffOn: 20,
//    timeoutOnOff: null,
//    actionOffOn:  () async => await function1(),
//    actionOnOff:  null,
//    onChanged: (value) => locator.get<Hive>().setPosition,  // to swPos save bool position of switch
// ),

// Future<double> function1() async {
//   var total = 0.0;
//   int delta = Random().nextInt(200000000) - 100000000;
//
//   for (var i = 0; i < data.iteration + delta; i++) {
//     total += i;
//   }
//   return total;
// }