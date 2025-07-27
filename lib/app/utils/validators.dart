class AppValidators {
  static String? validateDate(String? value) {
    if (value == null || value.isEmpty) return 'Введите дату';
    final parts = value.split('.');
    if (parts.length != 3) return 'Некорректный формат';

    final day = int.tryParse(parts[0]);
    final month = int.tryParse(parts[1]);
    final year = int.tryParse(parts[2]);

    if (day == null || month == null || year == null) {
      return 'Используйте только цифры';
    }

    if (day < 1 || day > 31) return 'Некорректный день';
    if (month < 1 || month > 12) return 'Некорректный месяц';

    return null;
  }

  static String? validateTitle(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Имя не может быть пустым';
    }
    return null;
  }
}
