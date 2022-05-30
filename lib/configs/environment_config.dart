class EnvironmentConfig {
  /// always 'static const' , String type
  static const String CONFIG_THEME_COLOR = String.fromEnvironment("CONFIG_THEME_COLOR",defaultValue: "COLOR_GALAXY_APP");
  static const String CONFIG_BUTTON_COLOR = String.fromEnvironment("CONFIG_BUTTON_COLOR",defaultValue: "BUTTON_COLOR_GALAXY_APP");
  static const String CONFIG_APP_TITLE = String.fromEnvironment("CONFIG_APP_TITLE",defaultValue: "APP_TITLE_GALAXY_APP");
  static const String CONFIG_HOME_PAGE = String.fromEnvironment("CONFIG_HOME_PAGE",defaultValue: "HOME_PAGE_GALAXY_APP");
  static const String CONFIG_CAST_VIEW = String.fromEnvironment("CONFIG_CAST_VIEW",defaultValue: "CAST_VIEW_GALAXY_APP");
  static const String CONFIG_USER_CARD = String.fromEnvironment("CONFIG_USER_CARD",defaultValue: "USER_CARD_GALAXY_APP");
  static const String CONFIG_FIRST_CARD_COLOR = String.fromEnvironment("CONFIG_FIRST_CARD_COLOR",defaultValue: "FIRST_COLOR_GALAXY_APP");
  static const String CONFIG_SECOND_CARD_COLOR = String.fromEnvironment("CONFIG_SECOND_CARD_COLOR",defaultValue: "SECOND_COLOR_GALAXY_APP");
}

/// FLAVORS

/// Galaxy app
/// flutter run --dart-define=CONFIG_THEME_COLOR=COLOR_GALAXY_APP --dart-define=CONFIG_APP_TITLE=APP_TITLE_GALAXY_APP --dart-define=CONFIG_BUTTON_COLOR=BUTTON_COLOR_GALAXY_APP --dart-define=CONFIG_HOME_PAGE=HOME_PAGE_GALAXY_APP --dart-define=CONFIG_CAST_VIEW=CAST_VIEW_GALAXY_APP --dart-define=CONFIG_USER_CARD=USER_CARD_GALAXY_APP --dart-define=CONFIG_FIRST_CARD_COLOR=FIRST_COLOR_GALAXY_APP --dart-define=CONFIG_SECOND_CARD_COLOR=SECOND_COLOR_GALAXY_APP

/// The movie
/// flutter run --dart-define=CONFIG_THEME_COLOR=COLOR_THE_MOVIE --dart-define=CONFIG_APP_TITLE=APP_TITLE_THE_MOVIE --dart-define=CONFIG_BUTTON_COLOR=BUTTON_COLOR_THE_MOVIE --dart-define=CONFIG_HOME_PAGE=HOME_PAGE_THE_MOVIE --dart-define=CONFIG_CAST_VIEW=CAST_VIEW_THE_MOVIE --dart-define=CONFIG_USER_CARD=USER_CARD_THE_MOVIE --dart-define=CONFIG_FIRST_CARD_COLOR=FIRST_COLOR_THE_MOVIE --dart-define=CONFIG_SECOND_CARD_COLOR=SECOND_COLOR_THE_MOVIE