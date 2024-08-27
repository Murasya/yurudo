# routine_app

Android Releaseビルド
``` shell
fvm flutter build appbundle --flavor prod --dart-define-from-file=flavor/prod.json
```

iOS Developmentビルド

``` shell
fvm flutter build ios --flavor dev --dart-define-from-file=flavor/dev.json
```

freezed生成

``` shell
fvm flutter pub run build_runner build --delete-conflicting-outputs
```