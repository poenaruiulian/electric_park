class Data {
  final bool? IsRecentlyVerified;
  final String? DateLastVerified;
  final int? ID;
  final String? UUID;
  final int? DataProviderID;
  final int? OperatorID;
  final int? UsageTypeID;
  final String? UsageCost;
  final AddressInfo addressInfo;
  final List<Connection>? Connections;
  bool isOpen;

  Data(
      {required this.IsRecentlyVerified,
      required this.DateLastVerified,
      required this.ID,
      required this.UUID,
      required this.DataProviderID,
      required this.OperatorID,
      required this.UsageTypeID,
      required this.UsageCost,
      required this.addressInfo,
      required this.Connections,
      required this.isOpen});

  factory Data.fromJson(Map<String, dynamic> parsedJson) {
    return Data(
        isOpen: true,
        ID: parsedJson["ID"] as int?,
        UsageCost: parsedJson["UsageCost"] as String?,
        IsRecentlyVerified: parsedJson["IsRecentlyVerified"] as bool?,
        DateLastVerified: parsedJson["DateLastVerified"] as String?,
        UUID: parsedJson["UUID"] as String?,
        DataProviderID: parsedJson["DataProviderID"] as int?,
        OperatorID: parsedJson["OperatorID"] as int?,
        UsageTypeID: parsedJson["UsageTypeID"] as int?,
        addressInfo: AddressInfo.fromJson(parsedJson['AddressInfo']),
        Connections: List<Connection>.from(parsedJson["Connections"]
            .map((i) => Connection.fromJson(i))
            .toList()));
  }
}

class AddressInfo {
  final int? ID;
  final String Title;
  final String AddressLine1;
  final String? Town;
  final String? Postcode;
  final int? CountryID;
  final double Latitude;
  final double Longitude;
  final double? Distance;
  final int? DistanceUnit;
  final String? StateOrProvince;

  AddressInfo(
      {required this.ID,
      required this.Title,
      required this.AddressLine1,
      required this.Town,
      required this.Postcode,
      required this.CountryID,
      required this.Latitude,
      required this.Longitude,
      required this.Distance,
      required this.DistanceUnit,
      required this.StateOrProvince});

  factory AddressInfo.fromJson(Map<String, dynamic> parsedJson) {
    return AddressInfo(
        ID: parsedJson["ID"] as int?,
        Title: parsedJson["Title"] as String,
        AddressLine1: parsedJson["AddressLine1"] as String,
        Town: parsedJson["Town"] as String?,
        Postcode: parsedJson["Postcode"] as String?,
        CountryID: parsedJson["CountryID"] as int?,
        Latitude: parsedJson["Latitude"] as double,
        Longitude: parsedJson["Longitude"] as double,
        Distance: parsedJson["Distance"] as double?,
        DistanceUnit: parsedJson["DistanceUnit"] as int?,
        StateOrProvince: parsedJson["StateOrProvince"] as String?);
  }
}

class Connection {
  final int? ID;
  final int? ConnectionTypeID;
  final int? StatusTypeID;
  final int? LevelID;
  final double? PowerKW;
  final int? CurrentTypeID;
  final int? Quantity;

  Connection(
      {required this.ID,
      required this.ConnectionTypeID,
      required this.StatusTypeID,
      required this.LevelID,
      required this.PowerKW,
      required this.CurrentTypeID,
      required this.Quantity});

  factory Connection.fromJson(Map<String, dynamic> parsedJson) {
    return Connection(
        ID: parsedJson["ID"] as int?,
        ConnectionTypeID: parsedJson["ConnectionTypeID"] as int?,
        StatusTypeID: parsedJson["StatusTypeID"] as int?,
        LevelID: parsedJson["LevelID"] as int?,
        PowerKW: parsedJson["PowerKW"] as double?,
        CurrentTypeID: parsedJson["CurrentTypeID"] as int?,
        Quantity: parsedJson["Quantity"] as int?);
  }
}
