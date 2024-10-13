# routine_app

Android deploygate

```shell
./dev-build.sh both 1
```

Android Releaseビルド
``` shell
fvm flutter build appbundle --flavor prod
```

iOS Developmentビルド

``` shell
fvm flutter build ipa --flavor dev
```
``` shell
fvm flutter build ipa --flavor prod --export-options-plist="ios/config/prod/ExportOptions.plist"
```

freezed生成

``` shell
fvm flutter pub run build_runner build --delete-conflicting-outputs
```