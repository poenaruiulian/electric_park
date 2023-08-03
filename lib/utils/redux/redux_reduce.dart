import 'package:electric_park/utils/redux/redux_store.dart';

AppState appReducer(AppState state, dynamic action) {
  if (action is ChangePosition) {
    return AppState(user_position: action.user_position);
  }
  return state;
}
