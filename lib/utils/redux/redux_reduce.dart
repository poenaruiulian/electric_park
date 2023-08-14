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
        user_favs: state.user_favs,
        occupied: state.occupied,
        end: state.end,
        roadShow: state.roadShow,
        user_profile_pic: state.user_profile_pic);
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
        user_favs: state.user_favs,
        occupied: state.occupied,
        end: state.end,
        roadShow: state.roadShow,
        user_profile_pic: state.user_profile_pic);
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
        user_favs: state.user_favs,
        occupied: state.occupied,
        end: state.end,
        roadShow: state.roadShow,
        user_profile_pic: state.user_profile_pic);
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
        user_favs: state.user_favs,
        occupied: state.occupied,
        end: state.end,
        roadShow: state.roadShow,
        user_profile_pic: state.user_profile_pic);
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
        user_favs: state.user_favs,
        occupied: state.occupied,
        end: state.end,
        roadShow: state.roadShow,
        user_profile_pic: state.user_profile_pic);
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
        user_favs: state.user_favs,
        occupied: state.occupied,
        end: state.end,
        roadShow: state.roadShow,
        user_profile_pic: state.user_profile_pic);
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
        user_favs: state.user_favs,
        occupied: state.occupied,
        end: state.end,
        roadShow: state.roadShow,
        user_profile_pic: state.user_profile_pic);
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
        user_favs: action.user_favs,
        occupied: state.occupied,
        end: state.end,
        roadShow: state.roadShow,
        user_profile_pic: state.user_profile_pic);
  }

  if (action is ChangeOccupied) {
    return AppState(
        user_position: state.user_position,
        chargers: state.chargers,
        chargerId: state.chargerId,
        connectionId: state.connectionId,
        user_email: state.user_email,
        user_name: state.user_name,
        user_id: state.user_id,
        mapIsLoading: state.mapIsLoading,
        user_favs: state.user_favs,
        occupied: action.occupied,
        end: state.end,
        roadShow: state.roadShow,
        user_profile_pic: state.user_profile_pic);
  }

  if (action is ChangeEnd) {
    return AppState(
        user_position: state.user_position,
        chargers: state.chargers,
        chargerId: state.chargerId,
        connectionId: state.connectionId,
        user_email: state.user_email,
        user_name: state.user_name,
        user_id: state.user_id,
        mapIsLoading: state.mapIsLoading,
        user_favs: state.user_favs,
        occupied: state.occupied,
        end: action.end,
        roadShow: action.roadShow,
        user_profile_pic: state.user_profile_pic);
  }

  if (action is ChangeProfilePic) {
    return AppState(
        user_position: state.user_position,
        chargers: state.chargers,
        chargerId: state.chargerId,
        connectionId: state.connectionId,
        user_email: state.user_email,
        user_name: state.user_name,
        user_id: state.user_id,
        mapIsLoading: state.mapIsLoading,
        user_favs: state.user_favs,
        occupied: state.occupied,
        end: state.end,
        roadShow: state.roadShow,
        user_profile_pic: action.user_profile_pic);
  }

  return state;
}
