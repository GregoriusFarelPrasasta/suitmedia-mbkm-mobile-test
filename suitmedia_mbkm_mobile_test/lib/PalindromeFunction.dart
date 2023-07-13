bool isPalindrome(String text) {
  int len = text.length;
  int left_stop_index = 0;
  if (len.isEven) {
    left_stop_index = len ~/ 2;
  } else {
    left_stop_index = (len / 2).ceil();
  }

  for (int left = 0, right = len-1; left < left_stop_index; left++, right-- ) {
    if (text[left].compareTo(text[right]) != 0) {
      return false;
    }
  }
  return true;
}