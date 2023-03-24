import 'image.dart';
import 'category_tag.dart';
// import 'custom_field.dart';
import 'tag.dart';
import 'distance.dart';
import 'reward.dart';

class Campaign {
  int? id;
  DateTime? activeAt;
  DateTime? beginsAt;
  CampaignConfig? campaignConfig;
  String? campaignReferralType;
  String? campaignType;
  List<CategoryTag>? categoryTags;
  Map<String, dynamic>? customFields;
  String? description;
  // DisplayProperties? displayProperties;
  Distance? distance;
  DateTime? endsAt;
  bool? enrolled;
  bool? favourite;
  String? gameType;
  List<PerxImage>? images;
  String? name;
  List<Tag>? tags;
  String? termsAndConditions;
  List<Reward>? rewards;

  Campaign(
      {this.id,
      this.activeAt,
      this.beginsAt,
      this.campaignConfig,
      this.campaignReferralType,
      this.campaignType,
      this.categoryTags,
      this.customFields,
      this.description,
      // this.displayProperties,
      this.distance,
      this.endsAt,
      this.enrolled,
      this.favourite,
      this.gameType,
      this.images,
      this.name,
      this.tags,
      this.termsAndConditions,
      this.rewards});

  Campaign.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['active_at'] != null) {
      activeAt = DateTime.parse(json['active_at']);
    }
    if (json['begins_at'] != null) {
      beginsAt = DateTime.parse(json['begins_at']);
    }
    campaignConfig = json['campaign_config'] != null
        ? CampaignConfig.fromJson(json['campaign_config'])
        : null;
    campaignReferralType = json['campaign_referral_type'];
    campaignType = json['campaign_type'];
    if (json['category_tags'] != null) {
      categoryTags = <CategoryTag>[];
      json['category_tags'].forEach((v) {
        categoryTags!.add(CategoryTag.fromJson(v));
      });
    }
    customFields = json['custom_fields'];
    description = json['description'];
    // displayProperties = json['display_properties'] != null
    //     ? DisplayProperties.fromJson(json['display_properties'])
    //     : null;
    distance =
        json['distance'] != null ? Distance.fromJson(json['distance']) : null;
    endsAt = json['ends_at'];
    enrolled = json['enrolled'];
    favourite = json['favourite'];
    gameType = json['game_type'];
    if (json['images'] != null) {
      images = <PerxImage>[];
      json['images'].forEach((v) {
        images!.add(PerxImage.fromJson(v));
      });
    }
    name = json['name'];
    if (json['tags'] != null) {
      tags = <Tag>[];
      json['tags'].forEach((v) {
        tags!.add(Tag.fromJson(v));
      });
    }
    termsAndConditions = json['terms_and_conditions'];
    if (json['rewards'] != null) {
      rewards = <Reward>[];
      json['rewards'].forEach((v) {
        rewards!.add(Reward.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['active_at'] = activeAt;
    data['begins_at'] = beginsAt;
    if (campaignConfig != null) {
      data['campaign_config'] = campaignConfig!.toJson();
    }
    data['campaign_referral_type'] = campaignReferralType;
    data['campaign_type'] = campaignType;
    if (categoryTags != null) {
      data['category_tags'] = categoryTags!.map((v) => v.toJson()).toList();
    }
    if (customFields != null) {
      data['custom_fields'] = customFields!.toString();
    }
    data['description'] = description;
    // if (displayProperties != null) {
    //   data['display_properties'] = displayProperties!.toJson();
    // }
    if (distance != null) {
      data['distance'] = distance!.toJson();
    }
    data['ends_at'] = endsAt;
    data['enrolled'] = enrolled;
    data['favourite'] = favourite;
    data['game_type'] = gameType;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    data['name'] = name;
    if (tags != null) {
      data['tags'] = tags!.map((v) => v.toJson()).toList();
    }
    data['terms_and_conditions'] = termsAndConditions;
    if (rewards != null) {
      data['rewards'] = rewards!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CampaignConfig {
  CampaignResult? campaignResults;

  CampaignConfig({this.campaignResults});

  CampaignConfig.fromJson(Map<String, dynamic> json) {
    campaignResults = json['campaign_results'] != null
        ? CampaignResult.fromJson(json['campaign_results'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (campaignResults != null) {
      data['campaign_results'] = campaignResults!.toJson();
    }
    return data;
  }
}

class CampaignResult {
  int? count;
  int? firstResultId;

  CampaignResult({this.count, this.firstResultId});

  CampaignResult.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    firstResultId = json['first_result_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['first_result_id'] = firstResultId;
    return data;
  }
}
