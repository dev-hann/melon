import 'package:dio/dio.dart';
import 'package:html/parser.dart';
import 'package:melon/src/model/melon_dj.dart';
import 'package:melon/src/model/melon_song.dart';

const _top100URL = "https://www.melon.com/chart/index.htm";
const _hot100URL = "https://www.melon.com/chart/hot100/index.htm";
const _new50URL = "https://www.melon.com/new/index.htm";
const _djURL = "https://www.melon.com/dj/today/djtoday_list.htm";
const _djDetailURL =
    "https://www.melon.com/mymusic/dj/mymusicdjplaylistview_inform.htm?plylstSeq=";

class Melon {
  Future<List<MelonSong>> requestTop100() {
    return _requestDefaultChart(_top100URL);
  }

  Future<List<MelonSong>> requestHot100() {
    return _requestDefaultChart(_hot100URL);
  }

  Future<List<MelonSong>> requestNew50() {
    return _requestDefaultChart(_new50URL);
  }

  Future<List<MelonDj>> requestDjChart() async {
    final itemList = <MelonDj>[];
    final res = await Dio().get(_djURL);
    final document = parse(res.data);
    final contentList = document.getElementsByClassName("d_content");
    for (final content in contentList) {
      final list = content.getElementsByTagName("li");
      for (final data in list) {
        final imageURL = data.getElementsByTagName("img").first;
        final title = data.getElementsByClassName("album_name");
        final id = title.first.attributes["href"];
        final tagList = data.getElementsByClassName("tag_item").map((e) {
          return e.text.trim();
        }).toList();
        final item = MelonDj(
          id: RegExp(r'\d+').allMatches(id!.trim()).last.group(0)!,
          title: title.first.text.trim(),
          imageURL: imageURL.attributes["src"]!.split("?tm=").first,
          tagList: tagList,
        );
        itemList.add(item);
      }
    }
    return itemList;
  }

  Future<List<MelonSong>> requestDjDetail(String id) {
    return _requestDefaultChart(_djDetailURL + id);
  }

  Future<List<MelonSong>> _requestDefaultChart(String url) async {
    final itemList = <MelonSong>[];
    final res = await Dio().get(url);
    final document = parse(res.data);
    final tbody = document.querySelector("tbody");
    if (tbody != null) {
      final trList = tbody.getElementsByTagName("tr");
      for (final tr in trList) {
        final rank = tr.getElementsByClassName("rank");
        final imageURL = tr.getElementsByTagName("img");
        final song = tr.getElementsByClassName("rank01");
        final singer = tr.getElementsByClassName("rank02");
        final album = tr.getElementsByClassName("rank03");
        final melonSong = MelonSong(
          rank: int.parse(rank.first.text.trim()),
          song: song.first.text.trim(),
          album: album.first.text.trim(),
          imageURL:
              imageURL.first.attributes["src"]?.split("/melon/").first ?? "",
          singer: singer.first.children.last.text.trim(),
        );
        itemList.add(melonSong);
      }
    }
    return itemList;
  }
}
