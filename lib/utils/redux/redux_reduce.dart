import 'package:electric_park/utils/redux/redux_store.dart';

AppState appReducer(AppState state, dynamic action) {
  if (action is ChangePosition) {
    return AppState(
        chargers: state.chargers,
        user_position: action.user_position,
        chargerId: state.chargerId,
        connectionId: state.connectionId);
  }
  if (action is ChangeChargerPoints) {
    return AppState(
        user_position: state.user_position,
        chargers: action.chargers,
        chargerId: state.chargerId,
        connectionId: state.connectionId);
  }
  if (action is ChangeStationIds) {
    return AppState(
        user_position: state.user_position,
        chargers: state.chargers,
        chargerId: action.chargerId,
        connectionId: action.connectionId);
  }

  return state;
}
