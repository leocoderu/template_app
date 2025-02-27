// Import Packages
import 'package:hive/hive.dart';

part 'app_state.g.dart';

@HiveType(typeId: 0)
class AppState extends HiveObject {
  @HiveField(0)
  final bool? auth_local;

  @HiveField(1)
  final bool? auto_login;

  @HiveField(2)
  final int? counter;

  @HiveField(3)
  final bool? switcher;

  @HiveField(4)
  final String? text;

  @HiveField(5)
  final bool? swSecurity;

  @HiveField(6)
  final bool? swFireAlarm;

  @HiveField(7)
  final bool? swSprinkler;

  AppState({
    this.auth_local,
    this.auto_login,
    this.counter,
    this.switcher,
    this.text,
    this.swSecurity,
    this.swFireAlarm,
    this.swSprinkler,
  });

  AppState copyWith({
    bool? auth_local,
    bool? auto_login,
    int? counter,
    bool? switcher,
    String? text,
    bool? swSecurity,
    bool? swFireAlarm,
    bool? swSprinkler,
  }) => AppState(
    auth_local: auth_local ?? this.auth_local,
    auto_login: auto_login ?? this.auto_login,
    counter: counter ?? this.counter,
    switcher: switcher ?? this.switcher,
    text: text ?? this.text,
    swSecurity: swSecurity ?? this.swSecurity,
    swFireAlarm: swFireAlarm ?? this.swFireAlarm,
    swSprinkler: swSprinkler ?? this.swSprinkler,
  );

  @override
  String toString() =>
    'AppState(auth_local: $auth_local, '
        'auto_login:$auto_login, '
        'counter: $counter, '
        'switcher: $switcher, '
        'text: $text,'
        'swSecurity: $swSecurity,'
        'swFireAlarm: $swFireAlarm,'
        'swSprinkler: $swSprinkler'
    ')';
}