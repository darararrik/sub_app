// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_model.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Project extends _Project with RealmEntity, RealmObjectBase, RealmObject {
  Project(
    String id,
    String name, {
    String? subtitleFilePath,
    Iterable<String> translatedSubtitles = const [],
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'subtitleFilePath', subtitleFilePath);
    RealmObjectBase.set<RealmList<String>>(
        this, 'translatedSubtitles', RealmList<String>(translatedSubtitles));
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
  String? get subtitleFilePath =>
      RealmObjectBase.get<String>(this, 'subtitleFilePath') as String?;
  @override
  set subtitleFilePath(String? value) =>
      RealmObjectBase.set(this, 'subtitleFilePath', value);

  @override
  RealmList<String> get translatedSubtitles =>
      RealmObjectBase.get<String>(this, 'translatedSubtitles')
          as RealmList<String>;
  @override
  set translatedSubtitles(covariant RealmList<String> value) =>
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
      'subtitleFilePath': subtitleFilePath.toEJson(),
      'translatedSubtitles': translatedSubtitles.toEJson(),
    };
  }

  static EJsonValue _toEJson(Project value) => value.toEJson();
  static Project _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'name': EJsonValue name,
      } =>
        Project(
          fromEJson(id),
          fromEJson(name),
          subtitleFilePath: fromEJson(ejson['subtitleFilePath']),
          translatedSubtitles:
              fromEJson(ejson['translatedSubtitles'], defaultValue: const []),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Project._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(ObjectType.realmObject, Project, 'Project', [
      SchemaProperty('id', RealmPropertyType.string),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('subtitleFilePath', RealmPropertyType.string,
          optional: true),
      SchemaProperty('translatedSubtitles', RealmPropertyType.string,
          collectionType: RealmCollectionType.list),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
