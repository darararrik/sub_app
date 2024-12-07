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
    Map<String, String> translatedWords = const {},
    Map<String, String> syllablesNotTranslated = const {},
    Map<String, String> syllablesTranslated = const {},
    Map<String, bool> isExpanded = const {},
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
    RealmObjectBase.set<RealmMap<String>>(
        this, 'translatedWords', RealmMap<String>(translatedWords));
    RealmObjectBase.set<RealmMap<String>>(this, 'syllablesNotTranslated',
        RealmMap<String>(syllablesNotTranslated));
    RealmObjectBase.set<RealmMap<String>>(
        this, 'syllablesTranslated', RealmMap<String>(syllablesTranslated));
    RealmObjectBase.set<RealmMap<bool>>(
        this, 'isExpanded', RealmMap<bool>(isExpanded));
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
  RealmMap<String> get translatedWords =>
      RealmObjectBase.get<String>(this, 'translatedWords') as RealmMap<String>;
  @override
  set translatedWords(covariant RealmMap<String> value) =>
      throw RealmUnsupportedSetError();

  @override
  RealmMap<String> get syllablesNotTranslated =>
      RealmObjectBase.get<String>(this, 'syllablesNotTranslated')
          as RealmMap<String>;
  @override
  set syllablesNotTranslated(covariant RealmMap<String> value) =>
      throw RealmUnsupportedSetError();

  @override
  RealmMap<String> get syllablesTranslated =>
      RealmObjectBase.get<String>(this, 'syllablesTranslated')
          as RealmMap<String>;
  @override
  set syllablesTranslated(covariant RealmMap<String> value) =>
      throw RealmUnsupportedSetError();

  @override
  RealmMap<bool> get isExpanded =>
      RealmObjectBase.get<bool>(this, 'isExpanded') as RealmMap<bool>;
  @override
  set isExpanded(covariant RealmMap<bool> value) =>
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
      'translatedWords': translatedWords.toEJson(),
      'syllablesNotTranslated': syllablesNotTranslated.toEJson(),
      'syllablesTranslated': syllablesTranslated.toEJson(),
      'isExpanded': isExpanded.toEJson(),
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
          translatedWords: fromEJson(ejson['translatedWords']),
          syllablesNotTranslated: fromEJson(ejson['syllablesNotTranslated'],
              defaultValue: const {}),
          syllablesTranslated:
              fromEJson(ejson['syllablesTranslated'], defaultValue: const {}),
          isExpanded: fromEJson(ejson['isExpanded'], defaultValue: const {}),
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
      SchemaProperty('translatedWords', RealmPropertyType.string,
          collectionType: RealmCollectionType.map),
      SchemaProperty('syllablesNotTranslated', RealmPropertyType.string,
          collectionType: RealmCollectionType.map),
      SchemaProperty('syllablesTranslated', RealmPropertyType.string,
          collectionType: RealmCollectionType.map),
      SchemaProperty('isExpanded', RealmPropertyType.bool,
          collectionType: RealmCollectionType.map),
      SchemaProperty('status', RealmPropertyType.string),
      SchemaProperty('imageBytes', RealmPropertyType.int,
          collectionType: RealmCollectionType.list),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
