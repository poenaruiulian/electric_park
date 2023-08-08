import 'package:electric_park/utils/open_charge_api/data_object.dart';
import 'package:geolocator/geolocator.dart';

class AppState {
  Position? user_position;
  List<Data>? chargers;

  String? chargerId;
  String? connectionId;

  String? user_email;
  String? user_name;

  bool? mapIsLoading;

  AppState(
      {this.user_email,
      this.user_name,
      this.user_position,
      this.chargers,
      this.chargerId,
      this.connectionId,
      this.mapIsLoading});
}

class ChangePosition {
  final Position? user_position;

  Position? get position => user_position;

  ChangePosition(this.user_position);
}

class ChangeChargerPoints {
  final List<Data>? chargers;

  List<Data>? get points => chargers;

  ChangeChargerPoints(this.chargers);
}

class ChangeStationIds {
  String? chargerId;
  String? connectionId;

  ChangeStationIds(this.chargerId, this.connectionId);
}

class ChangeUserEmail {
  String? email;

  ChangeUserEmail(this.email);
}

class ChangeUserName {
  String? name;

  ChangeUserName(this.name);
}

class ModifyMapIsLoading {
  bool? mapIsLoading;

  ModifyMapIsLoading(this.mapIsLoading);
}
