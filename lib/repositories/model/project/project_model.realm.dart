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
    String name, {
    String? engSubtitleFilePath,
    String? japSubtitleFilePath,
    Iterable<String> translatedSubtitles = const [],
    String? status = "Не переведено",
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
    RealmObjectBase.set(this, 'japSubtitleFilePath', japSubtitleFilePath);
    RealmObjectBase.set<RealmList<String>>(
        this, 'translatedSubtitles', RealmList<String>(translatedSubtitles));
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
  String? get engSubtitleFilePath =>
      RealmObjectBase.get<String>(this, 'engSubtitleFilePath') as String?;
  @override
  set engSubtitleFilePath(String? value) =>
      RealmObjectBase.set(this, 'engSubtitleFilePath', value);

  @override
  String? get japSubtitleFilePath =>
      RealmObjectBase.get<String>(this, 'japSubtitleFilePath') as String?;
  @override
  set japSubtitleFilePath(String? value) =>
      RealmObjectBase.set(this, 'japSubtitleFilePath', value);

  @override
  RealmList<String> get translatedSubtitles =>
      RealmObjectBase.get<String>(this, 'translatedSubtitles')
          as RealmList<String>;
  @override
  set translatedSubtitles(covariant RealmList<String> value) =>
      throw RealmUnsupportedSetError();

  @override
  String? get status => RealmObjectBase.get<String>(this, 'status') as String?;
  @override
  set status(String? value) => RealmObjectBase.set(this, 'status', value);

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
      'japSubtitleFilePath': japSubtitleFilePath.toEJson(),
      'translatedSubtitles': translatedSubtitles.toEJson(),
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
      } =>
        Project(
          fromEJson(id),
          fromEJson(name),
          engSubtitleFilePath: fromEJson(ejson['engSubtitleFilePath']),
          japSubtitleFilePath: fromEJson(ejson['japSubtitleFilePath']),
          translatedSubtitles:
              fromEJson(ejson['translatedSubtitles'], defaultValue: const []),
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
      SchemaProperty('id', RealmPropertyType.string),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('engSubtitleFilePath', RealmPropertyType.string,
          optional: true),
      SchemaProperty('japSubtitleFilePath', RealmPropertyType.string,
          optional: true),
      SchemaProperty('translatedSubtitles', RealmPropertyType.string,
          collectionType: RealmCollectionType.list),
      SchemaProperty('status', RealmPropertyType.string, optional: true),
      SchemaProperty('imageBytes', RealmPropertyType.int,
          collectionType: RealmCollectionType.list),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
