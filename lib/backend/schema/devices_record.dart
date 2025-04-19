import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DevicesRecord extends FirestoreRecord {
  DevicesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "deviceId" field.
  String? _deviceId;
  String get deviceId => _deviceId ?? '';
  bool hasDeviceId() => _deviceId != null;

  // "friendlyName" field.
  String? _friendlyName;
  String get friendlyName => _friendlyName ?? '';
  bool hasFriendlyName() => _friendlyName != null;

  // "householdId" field.
  String? _householdId;
  String get householdId => _householdId ?? '';
  bool hasHouseholdId() => _householdId != null;

  // "userView" field.
  List<String>? _userView;
  List<String> get userView => _userView ?? const [];
  bool hasUserView() => _userView != null;

  // "userControl" field.
  List<String>? _userControl;
  List<String> get userControl => _userControl ?? const [];
  bool hasUserControl() => _userControl != null;

  // "cost" field.
  String? _cost;
  String get cost => _cost ?? '';
  bool hasCost() => _cost != null;

  // "imageIdentifier" field.
  String? _imageIdentifier;
  String get imageIdentifier => _imageIdentifier ?? '';
  bool hasImageIdentifier() => _imageIdentifier != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _deviceId = snapshotData['deviceId'] as String?;
    _friendlyName = snapshotData['friendlyName'] as String?;
    _householdId = snapshotData['householdId'] as String?;
    _userView = getDataList(snapshotData['userView']);
    _userControl = getDataList(snapshotData['userControl']);
    _cost = snapshotData['cost'] as String?;
    _imageIdentifier = snapshotData['imageIdentifier'] as String?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('devices')
          : FirebaseFirestore.instance.collectionGroup('devices');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('devices').doc(id);

  static Stream<DevicesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => DevicesRecord.fromSnapshot(s));

  static Future<DevicesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => DevicesRecord.fromSnapshot(s));

  static DevicesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      DevicesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static DevicesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      DevicesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'DevicesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is DevicesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createDevicesRecordData({
  String? deviceId,
  String? friendlyName,
  String? householdId,
  String? cost,
  String? imageIdentifier,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'deviceId': deviceId,
      'friendlyName': friendlyName,
      'householdId': householdId,
      'cost': cost,
      'imageIdentifier': imageIdentifier,
    }.withoutNulls,
  );

  return firestoreData;
}

class DevicesRecordDocumentEquality implements Equality<DevicesRecord> {
  const DevicesRecordDocumentEquality();

  @override
  bool equals(DevicesRecord? e1, DevicesRecord? e2) {
    const listEquality = ListEquality();
    return e1?.deviceId == e2?.deviceId &&
        e1?.friendlyName == e2?.friendlyName &&
        e1?.householdId == e2?.householdId &&
        listEquality.equals(e1?.userView, e2?.userView) &&
        listEquality.equals(e1?.userControl, e2?.userControl) &&
        e1?.cost == e2?.cost &&
        e1?.imageIdentifier == e2?.imageIdentifier;
  }

  @override
  int hash(DevicesRecord? e) => const ListEquality().hash([
        e?.deviceId,
        e?.friendlyName,
        e?.householdId,
        e?.userView,
        e?.userControl,
        e?.cost,
        e?.imageIdentifier
      ]);

  @override
  bool isValidKey(Object? o) => o is DevicesRecord;
}
