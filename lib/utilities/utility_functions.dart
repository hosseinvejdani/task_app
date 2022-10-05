String generateId({int length = 5}) {
  /// generate random string based on input length
  /// which contains lawerCase and uperCase latters as well as digits
  String lettersStr = 'abcdefghijklmnopqrstuvwxyz';
  lettersStr = '$lettersStr${lettersStr.toUpperCase()}0123456789';
  List<String> lettersList = lettersStr.split(''); // convert string to list
  lettersList.shuffle(); // shuffled list
  late String generatedID;

  try {
    generatedID = lettersList.join().substring(0, length);
  } catch (e) {
    // ignore: avoid_print
    print(e);
  }
  return generatedID;
}
