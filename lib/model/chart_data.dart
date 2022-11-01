class ChartData {
  ChartData(this.sec, this.angle);

  final double sec;
  final int angle;

  Map toJson() => {
        'sec': sec,
        'angle': angle,
      };

  ChartData.fromJson(Map<String, dynamic> json)
      : sec = json['sec'],
        angle = json['angle'];
}
