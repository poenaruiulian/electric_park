import 'package:geolocator/geolocator.dart';

class AppState {
  Position? user_position;

  AppState({this.user_position});
}
class ChangePosition {
  final Position? user_position;

  Position? get position => user_position;

  ChangePosition(this.user_position);
}
