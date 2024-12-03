// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_model.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Project extends _Project with RealmEntity, RealmObjectBase, RealmObject {
  static var _defaultsSet = false;

  Project(
    String id,
    String name,
    String engSubtitleFilePath, {
    String? ruSubtitleFilePath,
    Map<String, String> syllables = const {},
    String status = "Не переведено",
    Iterable<int> imageBytes = const [],
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObjectBase.setDefaults<Project>({
        'status': "Не переведено",
      });
    }
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'engSubtitleFilePath', engSubtitleFilePath);
    RealmObjectBase.set(this, 'ruSubtitleFilePath', ruSubtitleFilePath);
    RealmObjectBase.set<RealmMap<String>>(
        this, 'syllables', RealmMap<String>(syllables));
    RealmObjectBase.set(this, 'status', status);
    RealmObjectBase.set<RealmList<int>>(
        this, 'imageBytes', RealmList<int>(imageBytes));
  }

  Project._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  String get engSubtitleFilePath =>
      RealmObjectBase.get<String>(this, 'engSubtitleFilePath') as String;
  @override
  set engSubtitleFilePath(String value) =>
      RealmObjectBase.set(this, 'engSubtitleFilePath', value);

  @override
  String? get ruSubtitleFilePath =>
      RealmObjectBase.get<String>(this, 'ruSubtitleFilePath') as String?;
  @override
  set ruSubtitleFilePath(String? value) =>
      RealmObjectBase.set(this, 'ruSubtitleFilePath', value);

  @override
  RealmMap<String> get syllables =>
      RealmObjectBase.get<String>(this, 'syllables') as RealmMap<String>;
  @override
  set syllables(covariant RealmMap<String> value) =>
      throw RealmUnsupportedSetError();

  @override
  String get status => RealmObjectBase.get<String>(this, 'status') as String;
  @override
  set status(String value) => RealmObjectBase.set(this, 'status', value);

  @override
  RealmList<int> get imageBytes =>
      RealmObjectBase.get<int>(this, 'imageBytes') as RealmList<int>;
  @override
  set imageBytes(covariant RealmList<int> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<Project>> get changes =>
      RealmObjectBase.getChanges<Project>(this);

  @override
  Stream<RealmObjectChanges<Project>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<Project>(this, keyPaths);

  @override
  Project freeze() => RealmObjectBase.freezeObject<Project>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'name': name.toEJson(),
      'engSubtitleFilePath': engSubtitleFilePath.toEJson(),
      'ruSubtitleFilePath': ruSubtitleFilePath.toEJson(),
      'syllables': syllables.toEJson(),
      'status': status.toEJson(),
      'imageBytes': imageBytes.toEJson(),
    };
  }

  static EJsonValue _toEJson(Project value) => value.toEJson();
  static Project _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'name': EJsonValue name,
        'engSubtitleFilePath': EJsonValue engSubtitleFilePath,
      } =>
        Project(
          fromEJson(id),
          fromEJson(name),
          fromEJson(engSubtitleFilePath),
          ruSubtitleFilePath: fromEJson(ejson['ruSubtitleFilePath']),
          syllables: fromEJson(ejson['syllables'], defaultValue: const {}),
          status: fromEJson(ejson['status'], defaultValue: "Не переведено"),
          imageBytes: fromEJson(ejson['imageBytes']),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Project._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(ObjectType.realmObject, Project, 'Project', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('engSubtitleFilePath', RealmPropertyType.string),
      SchemaProperty('ruSubtitleFilePath', RealmPropertyType.string,
          optional: true),
      SchemaProperty('syllables', RealmPropertyType.string,
          collectionType: RealmCollectionType.map),
      SchemaProperty('status', RealmPropertyType.string),
      SchemaProperty('imageBytes', RealmPropertyType.int,
          collectionType: RealmCollectionType.list),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
