# Changelog Widgets

by [Damian Aldair](https://damianaldair.github.io).

---

Inspired by Flutter's **AboutDialog**.

The easiest way to display your app's changelog.


## Getting Started

Add following dependency to your `pubspec.yaml`.

```yaml
dependencies:
  changelog_widgets: <latest_version>
```


## Initialization

Add the markdown file to your `pubspec.yaml`, in the **flutter** section, for example:

```dart
flutter:
  assets:
    - CHANGELOG.md
```

Import the package.
```dart
import 'package:changelog_widgets/changelog_widgets.dart';
```

Now, you can use the screens and dialogs.

## Available widgets

- Raw Material screen: `ChangelogRawScreen`.
- Built-in Material screen: `ChangelogScreen`.
- Built-in Material dialog: `ChangelogDialog`.
- Built-in Cupertino screen: `CupertinoChangelogScreen`.