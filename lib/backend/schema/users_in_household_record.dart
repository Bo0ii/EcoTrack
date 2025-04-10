import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UsersInHouseholdRecord extends FirestoreRecord {
  UsersInHouseholdRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "password" field.
  String? _password;
  String get password => _password ?? '';
  bool hasPassword() => _password != null;

  // "householdId" field.
  String? _householdId;
  String get householdId => _householdId ?? '';
  bool hasHouseholdId() => _householdId != null;

  // "display_name" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  bool hasDisplayName() => _displayName != null;

  // "Age" field.
  int? _age;
  int get age => _age ?? 0;
  bool hasAge() => _age != null;

  // "Title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "NameOfHouse" field.
  String? _nameOfHouse;
  String get nameOfHouse => _nameOfHouse ?? '';
  bool hasNameOfHouse() => _nameOfHouse != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _email = snapshotData['email'] as String?;
    _password = snapshotData['password'] as String?;
    _householdId = snapshotData['householdId'] as String?;
    _displayName = snapshotData['display_name'] as String?;
    _age = castToType<int>(snapshotData['Age']);
    _title = snapshotData['Title'] as String?;
    _nameOfHouse = snapshotData['NameOfHouse'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('usersInHousehold')
          : FirebaseFirestore.instance.collectionGroup('usersInHousehold');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('usersInHousehold').doc(id);

  static Stream<UsersInHouseholdRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UsersInHouseholdRecord.fromSnapshot(s));

  static Future<UsersInHouseholdRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => UsersInHouseholdRecord.fromSnapshot(s));

  static UsersInHouseholdRecord fromSnapshot(DocumentSnapshot snapshot) =>
      UsersInHouseholdRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UsersInHouseholdRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UsersInHouseholdRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UsersInHouseholdRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UsersInHouseholdRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUsersInHouseholdRecordData({
  String? email,
  String? password,
  String? householdId,
  String? displayName,
  int? age,
  String? title,
  String? nameOfHouse,
  String? photoUrl,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'email': email,
      'password': password,
      'householdId': householdId,
      'display_name': displayName,
      'Age': age,
      'Title': title,
      'NameOfHouse': nameOfHouse,
      'photo_url': photoUrl,
    }.withoutNulls,
  );

  return firestoreData;
}

class UsersInHouseholdRecordDocumentEquality
    implements Equality<UsersInHouseholdRecord> {
  const UsersInHouseholdRecordDocumentEquality();

  @override
  bool equals(UsersInHouseholdRecord? e1, UsersInHouseholdRecord? e2) {
    return e1?.email == e2?.email &&
        e1?.password == e2?.password &&
        e1?.householdId == e2?.householdId &&
        e1?.displayName == e2?.displayName &&
        e1?.age == e2?.age &&
        e1?.title == e2?.title &&
        e1?.nameOfHouse == e2?.nameOfHouse &&
        e1?.photoUrl == e2?.photoUrl;
  }

  @override
  int hash(UsersInHouseholdRecord? e) => const ListEquality().hash([
        e?.email,
        e?.password,
        e?.householdId,
        e?.displayName,
        e?.age,
        e?.title,
        e?.nameOfHouse,
        e?.photoUrl
      ]);

  @override
  bool isValidKey(Object? o) => o is UsersInHouseholdRecord;
}
