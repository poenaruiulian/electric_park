import 'package:electric_park/utils/types/charger_object.dart';
import 'package:geolocator/geolocator.dart';

class AppState {
  Position? user_position;
  List<Charger>? chargers;

  String? chargerId;
  String? connectionId;

  String? user_email;
  String? user_name;
  String? user_id;

  bool? mapIsLoading;

  List? user_favs;

  AppState(
      {this.user_email,
      this.user_name,
      this.user_id,
      this.user_position,
      this.chargers,
      this.chargerId,
      this.connectionId,
      this.mapIsLoading,
      this.user_favs});
}

class ChangePosition {
  final Position? user_position;

  Position? get position => user_position;

  ChangePosition(this.user_position);
}

class ChangeChargerPoints {
  final List<Charger>? chargers;

  List<Charger>? get points => chargers;

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

class ChangeUserId {
  String? id;

  ChangeUserId(this.id);
}

class ChangeUserName {
  String? name;

  ChangeUserName(this.name);
}

class ModifyMapIsLoading {
  bool? mapIsLoading;

  ModifyMapIsLoading(this.mapIsLoading);
}

class ChangeFavs {
  List user_favs;
  ChangeFavs(this.user_favs);
}
