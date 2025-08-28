import 'package:news/models/sources_responces/source.dart';

class SourceRespons {
  String? status;
  List<Source>? sources;

  SourceRespons({this.status, this.sources});

  factory SourceRespons.fromJson(Map<String, dynamic> json) {
    return SourceRespons(
      status: json['status'],
      sources: (json['sources'] as List)
          .map((e) => Source.fromJson(e))
          .toList(),
    );
  }
}
