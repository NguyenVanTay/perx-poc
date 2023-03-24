import 'tag.dart';
import 'category_tag.dart';
import 'image.dart';
import 'distance.dart';

class Reward {
  int? id;
  List<Brand>? brands;
  List<CategoryTag>? categoryTags;
  Map<String, dynamic>? customFields;
  String? description;
  bool? eligible;
  List<PerxImage>? images;
  bool? isGiftable;
  int? merchantId;
  String? merchantLogoUrl;
  String? merchantName;
  Map<String, dynamic>? merchantProperties;
  String? merchantWebsite;
  String? name;
  String? redemptionUrl;
  List<RewardPrice>? rewardPrice;
  DateTime? sellingFrom;
  DateTime? sellingTo;
  SocialHandler? socialHandlers;
  String? stepsToRedeem;
  String? subtitle;
  List<Tag>? tags;
  String? termsAndConditions;
  String? voucherType;
  Distance? distance;
  Inventory? inventory;

  Reward(
      {this.id,
      this.brands,
      this.categoryTags,
      this.customFields,
      this.description,
      this.images,
      this.isGiftable,
      this.merchantId,
      this.merchantLogoUrl,
      this.merchantName,
      this.merchantProperties,
      this.merchantWebsite,
      this.name,
      this.redemptionUrl,
      this.rewardPrice,
      this.sellingFrom,
      this.sellingTo,
      this.socialHandlers,
      this.stepsToRedeem,
      this.subtitle,
      this.tags,
      this.termsAndConditions,
      this.voucherType,
      this.distance,
      this.eligible,
      this.inventory});

  Reward.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['brands'] != null) {
      brands = <Brand>[];
      json['brands'].forEach((v) {
        brands!.add(Brand.fromJson(v));
      });
    }
    if (json['category_tags'] != null) {
      categoryTags = <CategoryTag>[];
      json['category_tags'].forEach((v) {
        categoryTags!.add(CategoryTag.fromJson(v));
      });
    }
    if (json['custom_fields'] != null) {
      customFields = <String, dynamic>{};
      json['custom_fields'].forEach((k, v) {
        customFields![k] = v;
      });
    }
    description = json['description'];
    if (json['images'] != null) {
      images = <PerxImage>[];
      json['images'].forEach((v) {
        images!.add(PerxImage.fromJson(v));
      });
    }
    isGiftable = json['is_giftable'];
    merchantId = json['merchant_id'];
    merchantLogoUrl = json['merchant_logo_url'];
    merchantName = json['merchant_name'];
    if (json['merchant_properties'] != null) {
      merchantProperties = <String, dynamic>{};
      json['merchant_properties'].forEach((k, v) {
        merchantProperties![k] = v;
      });
    }
    merchantWebsite = json['merchant_website'];
    name = json['name'];
    redemptionUrl = json['redemption_url'];
    if (json['reward_price'] != null) {
      rewardPrice = <RewardPrice>[];
      json['reward_price'].forEach((v) {
        rewardPrice!.add(RewardPrice.fromJson(v));
      });
    }
    if (json['selling_from'] != null) {
      sellingFrom = DateTime.parse(json['selling_from']);
    }
    if (json['selling_to'] != null) {
      sellingTo = DateTime.parse(json['selling_to']);
    }
    socialHandlers = json['social_handlers'] != null
        ? SocialHandler.fromJson(json['social_handlers'])
        : null;
    stepsToRedeem = json['steps_to_redeem'];
    subtitle = json['subtitle'];
    if (json['tags'] != null) {
      tags = <Tag>[];
      json['tags'].forEach((v) {
        tags!.add(Tag.fromJson(v));
      });
    }
    termsAndConditions = json['terms_and_conditions'];
    voucherType = json['voucher_type'];
    distance =
        json['distance'] != null ? Distance.fromJson(json['distance']) : null;
    eligible = json['eligible'];
    inventory = json['inventory'] != null
        ? Inventory.fromJson(json['inventory'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (brands != null) {
      data['brands'] = brands!.map((v) => v.toJson()).toList();
    }
    if (categoryTags != null) {
      data['category_tags'] = categoryTags!.map((v) => v.toJson()).toList();
    }
    if (customFields != null) {
      data['custom_fields'] = customFields;
    }
    data['description'] = description;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    data['is_giftable'] = isGiftable;
    data['merchant_id'] = merchantId;
    data['merchant_logo_url'] = merchantLogoUrl;
    data['merchant_name'] = merchantName;
    if (merchantProperties != null) {
      data['merchant_properties'] = merchantProperties;
    }
    data['merchant_website'] = merchantWebsite;
    data['name'] = name;
    data['redemption_url'] = redemptionUrl;
    if (rewardPrice != null) {
      data['reward_price'] = rewardPrice!.map((v) => v.toJson()).toList();
    }
    data['selling_from'] = sellingFrom;
    data['selling_to'] = sellingTo;
    if (socialHandlers != null) {
      data['social_handlers'] = socialHandlers!.toJson();
    }
    data['steps_to_redeem'] = stepsToRedeem;
    data['subtitle'] = subtitle;
    if (tags != null) {
      data['tags'] = tags!.map((v) => v.toJson()).toList();
    }
    data['terms_and_conditions'] = termsAndConditions;
    data['voucher_type'] = voucherType;
    if (distance != null) {
      data['distance'] = distance!.toJson();
    }
    data['eligible'] = eligible;
    if (inventory != null) {
      data['inventory'] = inventory!.toJson();
    }
    return data;
  }
}

class Brand {
  int? id;
  String? name;

  Brand({this.id, this.name});

  Brand.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class RewardPrice {
  int? id;
  String? currencyCode;
  String? identifier;
  int? loyaltyProgramId;
  int? points;
  String? price;
  String? rewardAmount;
  int? rewardCampaignId;
  String? rewardCurrency;

  RewardPrice(
      {this.id,
      this.currencyCode,
      this.identifier,
      this.loyaltyProgramId,
      this.points,
      this.price,
      this.rewardAmount,
      this.rewardCampaignId,
      this.rewardCurrency});

  RewardPrice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    currencyCode = json['currency_code'];
    identifier = json['identifier'];
    loyaltyProgramId = json['loyalty_program_id'];
    points = json['points'];
    price = json['price'];
    rewardAmount = json['reward_amount'];
    rewardCampaignId = json['reward_campaign_id'];
    rewardCurrency = json['reward_currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['currency_code'] = currencyCode;
    data['identifier'] = identifier;
    data['loyalty_program_id'] = loyaltyProgramId;
    data['points'] = points;
    data['price'] = price;
    data['reward_amount'] = rewardAmount;
    data['reward_campaign_id'] = rewardCampaignId;
    data['reward_currency'] = rewardCurrency;
    return data;
  }
}

class SocialHandler {
  String? facebook;
  String? twitter;

  SocialHandler({this.facebook, this.twitter});

  SocialHandler.fromJson(Map<String, dynamic> json) {
    facebook = json['facebook'];
    twitter = json['twitter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['facebook'] = facebook;
    data['twitter'] = twitter;
    return data;
  }
}

class Inventory {
  int? minutesPerPeriod;
  int? minutesPerUserPerPeriod;
  int? minutesPerUserPeriod;
  DateTime? perUserPeriodStart;

  Inventory({
    this.minutesPerPeriod,
    this.minutesPerUserPerPeriod,
    this.minutesPerUserPeriod,
    this.perUserPeriodStart,
  });

  Inventory.fromJson(Map<String, dynamic> json) {
    minutesPerPeriod = json['minutes_per_period'];
    minutesPerUserPerPeriod = json['minutes_per_user_per_period'];
    minutesPerUserPeriod = json['minutes_per_user_period'];
    if (json['per_user_period_start'] != null) {
      perUserPeriodStart = DateTime.parse(json['per_user_period_start']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['minutes_per_period'] = minutesPerPeriod;
    data['minutes_per_user_per_period'] = minutesPerUserPerPeriod;
    data['minutes_per_user_period'] = minutesPerUserPeriod;
    data['per_user_period_start'] = perUserPeriodStart;
    return data;
  }
}
