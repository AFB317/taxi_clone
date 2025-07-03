class Language {
  final int id;
  final String name;
  final String flag;
  final String languageCode;

  Language(this.id, this.name, this.flag, this.languageCode);

  static List <Language> languageList = [
    Language(1, 'Français', "🇫🇷", 'fr'),
    Language(2, 'Ikirundi', "🇧🇮", 'es'),
    Language(3, 'English', "🇬🇧", 'en'),
    Language(4, 'Swahili', "🇹🇿", 'sw'),
    Language(5, 'Amharic', "🇪🇹", 'am'),
    Language(6, 'Luganda', "🇺🇬", 'hr'),
    Language(7, 'Kinyarwanda', "🇷🇼", 'ro'),
  ];
  static Language defaultLanguage = Language(3, 'English', "🇬🇧", 'en');
}
