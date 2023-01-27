class SizeInfoModel {
  String? size;
  int? shoulderCrossLength;
  dynamic chestCrossLength;
  int? armhole;
  dynamic armStraightLength;
  dynamic armCrossLength;
  dynamic sleeveCrossLength;
  dynamic bottomCrossLength;
  dynamic strap;
  dynamic totalEntryLength;
  dynamic waistCrossLength;
  dynamic hipCrossLength;
  dynamic bottomTopCrossLength;
  dynamic thighCrossLength;
  dynamic open;
  dynamic lining;

  dynamic entrance_cross_length;
  dynamic breadth;
  dynamic diameter;
  dynamic width;
  dynamic height;
  dynamic handle_height;
  dynamic handle_length;
  dynamic front_heel_height;
  dynamic back_heel_height;
  dynamic calf_cross_length;
  dynamic weight;
  dynamic foot_width;

  dynamic necklace_breadth;
  dynamic necklace_total_entry_length;
  dynamic earring_total_entry_length;
  dynamic clock_diameter;
  dynamic clock_breadth;
  dynamic total_length;
  dynamic total_length2;
  dynamic entrace_circum;
  dynamic total_height;

  SizeInfoModel({
    this.size,
    this.shoulderCrossLength,
    this.chestCrossLength,
    this.armhole,
    this.armStraightLength,
    this.armCrossLength,
    this.sleeveCrossLength,
    this.bottomCrossLength,
    this.strap,
    this.totalEntryLength,
    this.waistCrossLength,
    this.hipCrossLength,
    this.bottomTopCrossLength,
    this.thighCrossLength,
    this.open,
    this.lining,
    this.entrance_cross_length,
    this.breadth,
    this.diameter,
    this.width,
    this.height,
    this.handle_height,
    this.handle_length,
    this.front_heel_height,
    this.back_heel_height,
    this.calf_cross_length,
    this.weight,
    this.foot_width,
    this.necklace_breadth,
    this.necklace_total_entry_length,
    this.earring_total_entry_length,
    this.clock_diameter,
    this.clock_breadth,
    this.total_length,
    this.total_length2,
    this.entrace_circum,
    this.total_height,
  });

  factory SizeInfoModel.fromJson(Map<String, dynamic> json) => SizeInfoModel(
        size: json['size'] as String?,
        shoulderCrossLength: json['shoulder_cross_length'] as int?,
        chestCrossLength: json['chest_cross_length'] as dynamic,
        armhole: json['armhole'] as int?,
        armStraightLength: json['arm_straight_length'] as dynamic,
        armCrossLength: json['arm_cross_length'] as dynamic,
        sleeveCrossLength: json['sleeve_cross_length'] as dynamic,
        bottomCrossLength: json['bottom_cross_length'] as dynamic,
        strap: json['strap'] as dynamic,
        totalEntryLength: json['total_entry_length'] as dynamic,
        waistCrossLength: json['waist_cross_length'] as dynamic,
        hipCrossLength: json['hip_cross_length'] as dynamic,
        bottomTopCrossLength: json['bottom_top_cross_length'] as dynamic,
        thighCrossLength: json['thigh_cross_length'] as dynamic,
        open: json['open'] as dynamic,
        lining: json['lining'] as dynamic,
        entrance_cross_length: json['entrance_cross_length'] as dynamic,
        breadth: json['breadth'] as dynamic,
        diameter: json['diameter'] as dynamic,
        width: json['width'] as dynamic,
        height: json['height'] as dynamic,
        handle_height: json['handle_height'] as dynamic,
        handle_length: json['handle_length'] as dynamic,
        front_heel_height: json['front_heel_height'] as dynamic,
        back_heel_height: json['back_heel_height'] as dynamic,
        calf_cross_length: json['calf_cross_length'] as dynamic,
        weight: json['weight'] as dynamic,
        foot_width: json['foot_width'] as dynamic,
        necklace_breadth: json['necklace_breadth'] as dynamic,
        necklace_total_entry_length:
            json['necklace_total_entry_length'] as dynamic,
        earring_total_entry_length:
            json['earring_total_entry_length'] as dynamic,
        clock_diameter: json['clock_diameter'] as dynamic,
        clock_breadth: json['clock_breadth'] as dynamic,
        total_length: json['total_length'] as dynamic,
        total_length2: json['total_length2'] as dynamic,
        entrace_circum: json['entrace_circum'] as dynamic,
        total_height: json['total_height'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'size': size,
        'shoulder_cross_length': shoulderCrossLength,
        'chest_cross_length': chestCrossLength,
        'armhole': armhole,
        'arm_straight_length': armStraightLength,
        'arm_cross_length': armCrossLength,
        'sleeve_cross_length': sleeveCrossLength,
        'bottom_cross_length': bottomCrossLength,
        'strap': strap,
        'total_entry_length': totalEntryLength,
        'waist_cross_length': waistCrossLength,
        'hip_cross_length': hipCrossLength,
        'bottom_top_cross_length': bottomTopCrossLength,
        'thigh_cross_length': thighCrossLength,
        'open': open,
        'lining': lining,
        'entrance_cross_length': entrance_cross_length,
        'breadth': breadth,
        'diameter': diameter,
        'width': width,
        'height': height,
        'handle_height': handle_height,
        'handle_length': handle_length,
        'front_heel_height': front_heel_height,
        'back_heel_height': back_heel_height,
        'calf_cross_length': calf_cross_length,
        'weight': weight,
        'foot_width': foot_width,
        'necklace_breadth': necklace_breadth,
        'necklace_total_entry_length': necklace_total_entry_length,
        'earring_total_entry_length': earring_total_entry_length,
        'clock_diameter': clock_diameter,
        'clock_breadth': clock_breadth,
        'total_length': total_length,
        'total_length2': total_length2,
        'entrace_circum': entrace_circum,
        'total_height': total_height,
      };
}
