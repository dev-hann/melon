import 'package:melon/melon.dart';

void main() async {
  final melon = Melon();
  final list = await melon.requestDjChart();
  final dj = list.first;
  final detail = await melon.requestDjDetail(dj.id);
  print(detail);
}
