# Flutter Bloc Kit

## Demo 

Demo app is using [igorsteblii.com](igorsteblii.com) Jekyll based blog as an API source to feature articles and About page.

| Home | Story | About |
|--------|--------|--------|
| ![Demo 1](demo/home.png) | ![Demo 2](demo/story.png) | ![Demo 3](demo/about.png) |

## Setup 

### Flutter Version Manager 

 * Install `fvm` [Flutter Version Manager](https://fvm.app/documentation/getting-started) with `brew`
 * Check Flutter version from [.fvmrc](.fvmrc)
 * Install Flutter: `fvm use x.y.z`


## Run

### Debug

Run on any device / emulator from terminal
* `fvm flutter run`

### Release

Options to release the app:

#### Android 

 * `Preferred:` For App Store release  
    * fvm flutter build appbundle --release
 * Fat APK with all ABI
   * fvm flutter build apk --release   
 * For split-abi APK testing 
    * fvm flutter build apk --release --split-per-abi  

#### iOS 

 * Archive for App store upload 
    * fvm flutter build ipa --release
    * open file with Xcode, validate and upload

## Greenfield

A simple way to create a new screen, copy folder [_greenfield](lib/screens/_greenfield) and rename all instances:

   *  files names from `greenfield_` to new name
   *  All instances of `greenfield` and `Greenfield` in file


## Plugins

### Architecture

See [BLoC](https://bloclibrary.dev/)

### Localisation 

1. Add new localisation in [l10n](lib/l10n/app_en.arb)
2. Run `fvm flutter gen-l10n` or rebuild the app

### Database

Isar DB

* To regenerate clases `fvm flutter pub run build_runner build`
* New entity add `part '[file name].g.dart';`

### Launcher Icon

See more [here](https://pub.dev/packages/flutter_launcher_icons)

```
flutter pub get
dart run flutter_launcher_icons
```

## Tools 

Usefull tools

### VSCode Plugins

Name: [File Header Comment](https://marketplace.visualstudio.com/items?itemName=doi.fileheadercomment)

## Git

### Tags

Each release need to be tag acccording to the version from [pubspec](pubspec.yaml)

   * Example: `version: 0.9.23+23`
   * Git: `git tag -a v0.9.23 -m "Release version 0.9.23"` & `git push --tags`
   * Version naming `[MAJOR][MINOR][PATCH]`
   * See all tags: `git tag -n` 

### MR Naming 

MR naming: `[TYPE][TICKET]` 

Types:

   * `[FEAT]` - feature developemt
   * `[FIX]` - bug fixing 
   * `[CHORE]` - refactoring
   * `[TEST]` -  UI/UT tests

### Branch naming 

Branch naming: `type/ticket`

* `feat` - feature developemt
* `fix` - bug fixing 
* `chore` - refactoring
* `test` -  UI/UT tests

## Author

Email: me@igorsteblii.com