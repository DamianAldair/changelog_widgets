/// Default widget title.
const String widgetTitle = 'Changelog';

/// Default 'CHANGELOG.md' file path.
const String defaultChangelogPath = 'CHANGELOG.md';

/// Default error message.
///
/// Example: 'Error loading "CHANGELOG.md"',
String getDefaultErrorMessage([String? filePath]) =>
    'Error loading "${filePath ?? defaultChangelogPath}"';
