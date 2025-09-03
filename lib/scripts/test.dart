void main() {
  List<int> array = [6, 7, 6, 6, 6, 6, -1];
  int smaller = array[0];

  for (int i = 1; i < array.length; i++) {
    smaller = array[i] < smaller ? array[i] : smaller;
  }
  print(smaller);
}
