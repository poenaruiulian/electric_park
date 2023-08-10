import 'package:electric_park/utils/redux/redux_store.dart';

AppState appReducer(AppState state, dynamic action) {
  if (action is ChangePosition) {
    return AppState(
        chargers: state.chargers,
        user_position: action.user_position,
        chargerId: state.chargerId,
        connectionId: state.connectionId,
        user_email: state.user_email,
        user_id: state.user_id,
        user_name: state.user_name,
        mapIsLoading: state.mapIsLoading,
        user_favs: state.user_favs);
  }
  if (action is ChangeChargerPoints) {
    return AppState(
        user_position: state.user_position,
        chargers: action.chargers,
        chargerId: state.chargerId,
        connectionId: state.connectionId,
        user_email: state.user_email,
        user_name: state.user_name,
        user_id: state.user_id,
        mapIsLoading: state.mapIsLoading,
        user_favs: state.user_favs);
  }
  if (action is ChangeStationIds) {
    return AppState(
        user_position: state.user_position,
        chargers: state.chargers,
        chargerId: action.chargerId,
        connectionId: action.connectionId,
        user_email: state.user_email,
        user_name: state.user_name,
        user_id: state.user_id,
        mapIsLoading: state.mapIsLoading,
        user_favs: state.user_favs);
  }
  if (action is ChangeUserEmail) {
    return AppState(
        user_position: state.user_position,
        chargers: state.chargers,
        chargerId: state.chargerId,
        connectionId: state.connectionId,
        user_email: action.email,
        user_name: state.user_name,
        user_id: state.user_id,
        mapIsLoading: state.mapIsLoading,
        user_favs: state.user_favs);
  }
  if (action is ChangeUserName) {
    return AppState(
        user_position: state.user_position,
        chargers: state.chargers,
        chargerId: state.chargerId,
        connectionId: state.connectionId,
        user_email: state.user_email,
        user_name: action.name,
        user_id: state.user_id,
        mapIsLoading: state.mapIsLoading,
        user_favs: state.user_favs);
  }

  if (action is ModifyMapIsLoading) {
    return AppState(
        user_position: state.user_position,
        chargers: state.chargers,
        chargerId: state.chargerId,
        connectionId: state.connectionId,
        user_email: state.user_email,
        user_name: state.user_name,
        user_id: state.user_id,
        mapIsLoading: action.mapIsLoading,
        user_favs: state.user_favs);
  }

  if (action is ChangeUserId) {
    return AppState(
        user_position: state.user_position,
        chargers: state.chargers,
        chargerId: state.chargerId,
        connectionId: state.connectionId,
        user_email: state.user_email,
        user_name: state.user_name,
        user_id: action.id,
        mapIsLoading: state.mapIsLoading,
        user_favs: state.user_favs);
  }

  if (action is ChangeFavs) {
    return AppState(
        user_position: state.user_position,
        chargers: state.chargers,
        chargerId: state.chargerId,
        connectionId: state.connectionId,
        user_email: state.user_email,
        user_name: state.user_name,
        user_id: state.user_id,
        mapIsLoading: state.mapIsLoading,
        user_favs: action.user_favs);
  }

  return state;
}
