const String widgetTitle = 'Changelog';

const String defaultChangelogPath = 'CHANGELOG.md';

String getDefaultErrorMessage([String? filePath]) =>
    'Error loading "${filePath ?? defaultChangelogPath}"';
