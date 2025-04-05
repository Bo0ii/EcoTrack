import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UserDirectoryRecord extends FirestoreRecord {
  UserDirectoryRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "emai" field.
  String? _emai;
  String get emai => _emai ?? '';
  bool hasEmai() => _emai != null;

  // "parentAdminRef" field.
  DocumentReference? _parentAdminRef;
  DocumentReference? get parentAdminRef => _parentAdminRef;
  bool hasParentAdminRef() => _parentAdminRef != null;

  void _initializeFields() {
    _emai = snapshotData['emai'] as String?;
    _parentAdminRef = snapshotData['parentAdminRef'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('userDirectory');

  static Stream<UserDirectoryRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UserDirectoryRecord.fromSnapshot(s));

  static Future<UserDirectoryRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UserDirectoryRecord.fromSnapshot(s));

  static UserDirectoryRecord fromSnapshot(DocumentSnapshot snapshot) =>
      UserDirectoryRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UserDirectoryRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UserDirectoryRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UserDirectoryRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UserDirectoryRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUserDirectoryRecordData({
  String? emai,
  DocumentReference? parentAdminRef,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'emai': emai,
      'parentAdminRef': parentAdminRef,
    }.withoutNulls,
  );

  return firestoreData;
}

class UserDirectoryRecordDocumentEquality
    implements Equality<UserDirectoryRecord> {
  const UserDirectoryRecordDocumentEquality();

  @override
  bool equals(UserDirectoryRecord? e1, UserDirectoryRecord? e2) {
    return e1?.emai == e2?.emai && e1?.parentAdminRef == e2?.parentAdminRef;
  }

  @override
  int hash(UserDirectoryRecord? e) =>
      const ListEquality().hash([e?.emai, e?.parentAdminRef]);

  @override
  bool isValidKey(Object? o) => o is UserDirectoryRecord;
}
