String convertToEnglishDigits(String value) {
  String newValue = value
      .replaceAll("١", "1")
      .replaceAll("٢", "2")
      .replaceAll("٣", "3")
      .replaceAll("٤", "4")
      .replaceAll("٥", "5")
      .replaceAll("٦", "6")
      .replaceAll("٧", "7")
      .replaceAll("٨", "8")
      .replaceAll("٩", "9")
      .replaceAll("٠", "0")
      .replaceAll("۱", "1")
      .replaceAll("۲", "2")
      .replaceAll("۳", "3")
      .replaceAll("۴", "4")
      .replaceAll("۵", "5")
      .replaceAll("۶", "6")
      .replaceAll("۷", "7")
      .replaceAll("۸", "8")
      .replaceAll("۹", "9")
      .replaceAll("۰", "0");
  return newValue;
}

cashCalculations({String cash, selectedType}) {
  print('caaaaaashhhhh');
  print(cash);
  String filterCash = convertToEnglishDigits(cash);
  print(filterCash);
  String _finalCash; // ignore: unused_local_variable
  print('filterrrd caaaaaashhhhh');
  print(filterCash);
  int cashInt = int.parse(filterCash);
  if (selectedType == "دائن") {
    return _finalCash = "-${cashInt.toString()}";
  }
  if (selectedType == "خالص") {
    return _finalCash = "0";
  }
  if (selectedType == "مدين") {
    return _finalCash = filterCash;
  }
}

calculateTheTotalBill({totalNo, wholesaleUnit}) {}
