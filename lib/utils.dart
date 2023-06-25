class Logger {
  Logger._();
  static final Logger _instance = Logger._();
  factory Logger() => _instance;

  static bool _verboseMode = false;

  void activateVerbose() => _verboseMode = true;

  void error(String text, {bool onlyVerbose = false}) {
    if (_verboseMode && _verboseMode || !onlyVerbose) {
      print(wrapRed(text));
    }
  }

  void info(String text, {bool onlyVerbose = false}) {
    if (_verboseMode && _verboseMode || !onlyVerbose) {
      print(wrapBlue(text));
    }
  }

  void success(String text, {bool onlyVerbose = false}) {
    if (_verboseMode && _verboseMode || !onlyVerbose) {
      print(wrapGreen(text));
    }
  }

  void regular(String text, {bool onlyVerbose = false}) {
    if (_verboseMode && _verboseMode || !onlyVerbose) {
      print(text);
    }
  }
}

String wrapRed(String text) {
  return '\x1B[31m$text\x1B[0m';
}

String wrapGreen(String text) {
  return '\x1B[32m$text\x1B[0m';
}

String wrapBlue(String text) {
  return '\x1B[34m$text\x1B[0m';
}
