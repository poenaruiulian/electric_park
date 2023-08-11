import 'package:electric_park/utils/utils.dart';
import 'package:redux/redux.dart';

void modifyStoreOccupied(Store<AppState> store, int chargerId) async {
  List allChargers = store.state.chargers!;
  Charger charger =
      allChargers.firstWhere((element) => element.ID == chargerId);

  int totalConnections = 0;
  int occupiedConnections = 0;

  occupiedConnections = await totalOccupiedConnectors(charger);

  for (var connection in charger.Connections!) {
    totalConnections += connection.Quantity!;
  }

  List aux = store.state.occupied!;

  print("-- $totalConnections $occupiedConnections");

  if (totalConnections != occupiedConnections) {
    aux.add(chargerId.toString());
    print("adaugat");
  } else {
    aux.remove(chargerId.toString());
    print("sters");
  }

  store.dispatch(ChangeOccupied(aux));

  print(store.state.occupied);
}
