class LanguageUtils {
  static const _rtlLocales = <String>[
    'ar', // Arabic
    'fa', // Farsi
    'he', // Hebrew
    'ps', // Pashto
    'ur', // Urdu
  ];

  // Function to check if a given language code is RTL
  static bool isRtlLanguage(String languageCode) {
    return _rtlLocales.contains(languageCode.toLowerCase());
  }

  // Function to check if a given language code is LTR
  static bool isLtrLanguage(String languageCode) =>
      !_rtlLocales.contains(languageCode.toLowerCase());
}
