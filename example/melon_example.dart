import 'package:melon/melon.dart';

void main() async {
  final melon = Melon();
  final list = await melon.requestNew50();
  print(list);
}
