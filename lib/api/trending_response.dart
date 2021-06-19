class MovieListingResponse {
  MovieListingResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<Result>? results;
  int totalPages;
  int totalResults;

  factory MovieListingResponse.fromJson(Map<String, dynamic> json) =>
      MovieListingResponse(
        page: json["page"],
        results: json["results"] == null
            ? []
            : List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}

class Result {
  Result({
    required this.originalTitle,
    required this.id,
    this.posterPath,
  });

  String originalTitle;
  int id;
  String? posterPath;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        originalTitle: json["original_title"],
        id: json["id"],
        posterPath: json["poster_path"] == null ? null : json["poster_path"],
      );

  Map<String, dynamic> toJson() => {
        "original_title": originalTitle,
        "id": id,
        "poster_path": posterPath == null ? null : posterPath,
      };
}
