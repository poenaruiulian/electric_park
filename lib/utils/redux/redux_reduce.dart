import 'package:electric_park/utils/redux/redux_store.dart';

AppState appReducer(AppState state, dynamic action) {
  if (action is ChangePosition) {
    return AppState(
        chargers: state.chargers, user_position: action.user_position);
  }
  if (action is ChangeChargerPoints) {
    return AppState(
        user_position: state.user_position, chargers: action.chargers);
  }
  return state;
}
