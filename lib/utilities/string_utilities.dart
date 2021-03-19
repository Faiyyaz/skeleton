/// This class contains string related utility functions

class StringUtilities {
  static String getExceptionMessage(String message) {
    if (message != null) {
      return message.replaceFirst('Exception: ', '');
    } else {
      return 'Something went wrong';
    }
  }
}
