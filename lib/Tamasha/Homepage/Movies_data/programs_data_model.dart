class ProgramsDataModel {
  List<Program>? programs;

  ProgramsDataModel({this.programs});

  factory ProgramsDataModel.fromJson(Map<String, dynamic> json) =>
      ProgramsDataModel(
        programs: json["programs"] == null
            ? []
            : List<Program>.from(
                json["programs"]!.map((x) => Program.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "programs": programs == null
            ? []
            : List<dynamic>.from(programs!.map((x) => x.toJson())),
      };
}

class Program {
  int? genreId;
  String? channelName;
  List<ProgramDatum>? programData;

  Program({this.genreId, this.channelName, this.programData});

  factory Program.fromJson(Map<String, dynamic> json) => Program(
        genreId: json["genreId"],
        channelName: json["ChannelName"],
        programData: json["programData"] == null
            ? []
            : List<ProgramDatum>.from(
                json["programData"]!.map((x) => ProgramDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "genreId": genreId,
        "ChannelName": channelName,
        "programData": programData == null
            ? []
            : List<dynamic>.from(programData!.map((x) => x.toJson())),
      };
}

class ProgramDatum {
  int? id;
  String? name;
  String? image;
  bool? isLive;
  String? videoUrl;

  ProgramDatum({this.id, this.name, this.image, this.isLive, this.videoUrl});

  factory ProgramDatum.fromJson(Map<String, dynamic> json) => ProgramDatum(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        isLive: json["isLive"],
        videoUrl: json["videoUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "isLive": isLive,
        "videoUrl": videoUrl,
      };
}
