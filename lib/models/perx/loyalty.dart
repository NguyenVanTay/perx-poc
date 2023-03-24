import 'package:dogs_park/models/perx/image.dart';
import 'package:dogs_park/models/perx/tag.dart';

class Loyalty {
  int? id;
  late String name;
  String? description;
  String? membershipNumber;
  String? pointsCurrency;
  int? pointsBalance;
  List<int>? pointsBalances;
  String? pointsToCurrencyRate;
  String? pointsBalanceConvertedToCurrency;
  int? currentMembershipTierId;
  String? currentMembershipTierName;
  DateTime? beginsAt;
  DateTime? endsAt;
  Review? review;
  Setting? settings;
  List<AgingPoint>? agingPoints;
  List<Tier>? tiers;
  List<PerxImage>? images;
  Map<String, dynamic>? customFields;
  bool? favourite;
  late int currentPoints;

  Loyalty(
      {this.id,
      this.name = "",
      this.description,
      this.membershipNumber,
      this.pointsCurrency,
      this.pointsBalance,
      this.pointsToCurrencyRate,
      this.pointsBalanceConvertedToCurrency,
      this.currentMembershipTierId,
      this.currentMembershipTierName,
      this.beginsAt,
      this.endsAt,
      this.review,
      this.settings,
      this.agingPoints,
      this.tiers,
      this.images,
      this.customFields,
      this.favourite,
      this.currentPoints = 0});

  Loyalty.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    membershipNumber = json['membership_number'];
    pointsCurrency = json['points_currency'];
    pointsBalance = json['points_balance'];
    pointsToCurrencyRate = json['points_to_currency_rate'];
    pointsBalanceConvertedToCurrency = json['points_balance_converted_to_currency'];
    currentMembershipTierId = json['current_membership_tier_id'];
    currentMembershipTierName = json['current_membership_tier_name'];
    if (json['begins_at'] != null) beginsAt = DateTime.parse(json['begins_at']);
    if (json['ends_at'] != null) endsAt = DateTime.parse(json['ends_at']);
    review = json['review'] != null ? Review.fromJson(json['review']) : null;
    settings = json['settings'] != null ? Setting.fromJson(json['settings']) : null;
    if (json['aging_points'] != null) {
      agingPoints = <AgingPoint>[];
      json['aging_points'].forEach((v) {
        agingPoints!.add(AgingPoint.fromJson(v));
      });
    }
    if (json['tiers'] != null) {
      tiers = <Tier>[];
      json['tiers'].forEach((v) {
        tiers!.add(Tier.fromJson(v));
      });
    }
    if (json['images'] != null) {
      images = <PerxImage>[];
      json['images'].forEach((v) {
        images!.add(PerxImage.fromJson(v));
      });
    }
    customFields = json['custom_fields'];
    favourite = json['favourite'];
    currentPoints = getCurrentPoints();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['membership_number'] = membershipNumber;
    data['points_currency'] = pointsCurrency;
    data['points_balance'] = pointsBalance;
    data['points_to_currency_rate'] = pointsToCurrencyRate;
    data['points_balance_converted_to_currency'] = pointsBalanceConvertedToCurrency;
    data['current_membership_tier_id'] = currentMembershipTierId;
    data['current_membership_tier_name'] = currentMembershipTierName;
    data['begins_at'] = beginsAt;
    data['ends_at'] = endsAt;
    if (review != null) {
      data['review'] = review!.toJson();
    }
    if (settings != null) {
      data['settings'] = settings!.toJson();
    }
    if (agingPoints != null) {
      data['aging_points'] = agingPoints!.map((v) => v.toJson()).toList();
    }
    if (tiers != null) {
      data['tiers'] = tiers!.map((v) => v.toJson()).toList();
    }
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    if (customFields != null) {
      data['custom_fields'] = customFields;
    }
    data['favourite'] = favourite;
    return data;
  }

  int getCurrentPoints() {
    int points = 0;

    for (var tier in tiers!) {
      if (tier.pointsDifference != 0) {
        points += tier.pointsRequirement! - tier.pointsDifference!;
        break;
      }
      points += tier.pointsRequirement!;
    }

    return points;
  }
}

class Review {
  DateTime? reviewStart;
  DateTime? reviewEnd;

  Review({this.reviewStart, this.reviewEnd});

  Review.fromJson(Map<String, dynamic> json) {
    if (json['review_start'] != null) {
      reviewStart = DateTime.parse(json['review_start']);
    }
    if (json['review_end'] != null) {
      reviewEnd = DateTime.parse(json['review_end']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['review_start'] = reviewStart;
    data['review_end'] = reviewEnd;
    return data;
  }
}

class Setting {
  String? promotionJumpTier;
  String? promotionIgnoreReviewCycle;
  String? demotionJumpTier;
  String? demotionIgnoreReviewCycle;

  Setting(
      {this.promotionJumpTier, this.promotionIgnoreReviewCycle, this.demotionJumpTier, this.demotionIgnoreReviewCycle});

  Setting.fromJson(Map<String, dynamic> json) {
    promotionJumpTier = json['promotion_jump_tier'];
    promotionIgnoreReviewCycle = json['promotion_ignore_review_cycle'];
    demotionJumpTier = json['demotion_jump_tier'];
    demotionIgnoreReviewCycle = json['demotion_ignore_review_cycle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['promotion_jump_tier'] = promotionJumpTier;
    data['promotion_ignore_review_cycle'] = promotionIgnoreReviewCycle;
    data['demotion_jump_tier'] = demotionJumpTier;
    data['demotion_ignore_review_cycle'] = demotionIgnoreReviewCycle;
    return data;
  }
}

class AgingPoint {
  DateTime? expiringOnDate;
  String? pointsExpiring;

  AgingPoint({this.expiringOnDate, this.pointsExpiring});

  AgingPoint.fromJson(Map<String, dynamic> json) {
    if (json['expiring_on_date'] != null) {
      expiringOnDate = DateTime.parse(json['expiring_on_date']);
    }
    pointsExpiring = json['points_expiring'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['expiring_on_date'] = expiringOnDate;
    data['points_expiring'] = pointsExpiring;
    return data;
  }
}

class Tier {
  int? id;
  late String name;
  bool? attained;
  int? pointsRequirement;
  int? pointsDifference;
  int? pointsDifferenceConvertedToCurrency;
  String? multiplierPoint;
  String? multiplierPointsToCurrencyRate;
  List<PerxImage>? images;
  List<Tag>? tags;
  Map<String, dynamic>? customFields;

  Tier(
      {this.id,
      this.name = "",
      this.attained,
      this.pointsRequirement,
      this.pointsDifference,
      this.pointsDifferenceConvertedToCurrency,
      this.multiplierPoint,
      this.multiplierPointsToCurrencyRate,
      this.images,
      this.tags,
      this.customFields});

  Tier.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    attained = json['attained'];
    pointsRequirement = json['points_requirement'];
    pointsDifference = json['points_difference'];
    pointsDifferenceConvertedToCurrency = json['points_difference_converted_to_currency'];
    multiplierPoint = json['multiplier_point'];
    multiplierPointsToCurrencyRate = json['multiplier_points_to_currency_rate'];
    if (json['images'] != null) {
      images = <PerxImage>[];
      json['images'].forEach((v) {
        images!.add(PerxImage.fromJson(v));
      });
    }
    if (json['tags'] != null) {
      tags = <Tag>[];
      json['tags'].forEach((v) {
        tags!.add(Tag.fromJson(v));
      });
    }
    customFields = json['custom_fields'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['attained'] = attained;
    data['points_requirement'] = pointsRequirement;
    data['points_difference'] = pointsDifference;
    data['points_difference_converted_to_currency'] = pointsDifferenceConvertedToCurrency;
    data['multiplier_point'] = multiplierPoint;
    data['multiplier_points_to_currency_rate'] = multiplierPointsToCurrencyRate;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    if (tags != null) {
      data['tags'] = tags!.map((v) => v.toJson()).toList();
    }
    data['custom_fields'] = customFields;
    return data;
  }
}
