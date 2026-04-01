class Petlistmodel {
  String? petId;
  String? petOwnerId;
  String? petName;
  String? petWeightInKg;
  String? petSlug;
  String? petCategoryId;
  dynamic petCatteryId;
  dynamic applyCatteryName;
  String? petImage;
  String? petPinCode;
  String? petAddress;
  String? petCity;
  String? petState;
  String? petDistrict;
  String? petCountry;
  dynamic petBloodDonorDetails;
  String? healthinfo;
  String? vaccinationinfo;
  String? medicationinfo;
  String? veterinarian;
  dynamic uploadImage;
  dynamic uploadVideo;
  dynamic uploadPdf;
  dynamic petRegistrationNumber;
  dynamic petRegistrationNumberCreatedDate;
  dynamic otherPetClubId;
  dynamic otherClubRegistrationNumber;
  String? microchipNumber;
  String? microchipImplementedBy;
  String? microchipImplementorName;
  String? microchipImplementorMobileNumber;
  String? microchipImplementedDate;
  String? microchipDocument;
  String? isSireRegisterWithAff;
  String? isSireRegisterWithOther;
  String? sireOtherClubId;
  dynamic petSireRegistrationNumber;
  dynamic petSireRegistrationNumberOther;
  dynamic sireFrontSideCertificate;
  dynamic sireBackSideCertificate;
  dynamic sireOwnerTransferForm;
  dynamic sireStudAgreementForm;
  String? petSireAdminStatus;
  String? isDamRegisterWithAff;
  String? isDamRegisterWithOther;
  String? damOtherClubId;
  dynamic petDamRegistrationNumber;
  dynamic petDamRegistrationNumberOther;
  dynamic damFrontSideCertificate;
  dynamic damBackSideCertificate;
  dynamic damOwnerTransferForm;
  dynamic damStudAgreementForm;
  String? petDamAdminStatus;
  String? petBirthDate;
  dynamic petExpireDate;
  String? petBreedId;
  dynamic petCcpId;
  String? countryBredIn;
  String? petGender;
  String? withMicrochip;
  dynamic microchipOrderWith;
  String? isIndivisualCertificate;
  String? isTreeCertificate;
  dynamic frontSideCertificate;
  dynamic backSideCertificate;
  dynamic ownerTransferForm;
  dynamic studAgreementForm;
  String? petMicrochipStatus;
  dynamic petMicrochipComment;
  dynamic petStatusComment;
  String? petLastBloodDonorAddress;
  String? sterilizationStatus;
  String? isSecondaryGardianAvailable;
  String? secondOwnerId;
  String? petStatus;
  String? isAffixCatteryPaid;
  String? isPetPaid;
  String? isPetApi;
  String? petUpdatedOn;
  String? petCreatedOn;
  String? userId;
  dynamic userAddedId;
  String? ownerType;
  String? organisationName;
  String? userFirstName;
  String? userLastName;
  String? userEmailId;
  String? userPassword;
  String? userProfileImage;
  String? userMobileNumber;
  String? userDateOfBirth;
  String? userGender;
  String? userBloodGroup;
  String? userCountry;
  String? userState;
  String? userDistrict;
  String? userCity;
  String? userAddress;
  String? userPinCode;
  dynamic deliveryDetails;
  String? userVerifyCode;
  dynamic affilateCode;
  String? isVerified;
  dynamic cardCode;
  dynamic cardExpiryDate;
  String? userStatus;
  String? isUserApi;
  String? isUserActive;
  String? userWebCode;
  String? userToken;
  String? userUpdateOn;
  String? userCreatedOn;
  String? lastDonateDate;
  String? donateAfter;

  Petlistmodel({this.petId, this.petOwnerId, this.petName, this.petWeightInKg, this.petSlug, this.petCategoryId, this.petCatteryId, this.applyCatteryName, this.petImage, this.petPinCode, this.petAddress, this.petCity, this.petState, this.petDistrict, this.petCountry, this.petBloodDonorDetails, this.healthinfo, this.vaccinationinfo, this.medicationinfo, this.veterinarian, this.uploadImage, this.uploadVideo, this.uploadPdf, this.petRegistrationNumber, this.petRegistrationNumberCreatedDate, this.otherPetClubId, this.otherClubRegistrationNumber, this.microchipNumber, this.microchipImplementedBy, this.microchipImplementorName, this.microchipImplementorMobileNumber, this.microchipImplementedDate, this.microchipDocument, this.isSireRegisterWithAff, this.isSireRegisterWithOther, this.sireOtherClubId, this.petSireRegistrationNumber, this.petSireRegistrationNumberOther, this.sireFrontSideCertificate, this.sireBackSideCertificate, this.sireOwnerTransferForm, this.sireStudAgreementForm, this.petSireAdminStatus, this.isDamRegisterWithAff, this.isDamRegisterWithOther, this.damOtherClubId, this.petDamRegistrationNumber, this.petDamRegistrationNumberOther, this.damFrontSideCertificate, this.damBackSideCertificate, this.damOwnerTransferForm, this.damStudAgreementForm, this.petDamAdminStatus, this.petBirthDate, this.petExpireDate, this.petBreedId, this.petCcpId, this.countryBredIn, this.petGender, this.withMicrochip, this.microchipOrderWith, this.isIndivisualCertificate, this.isTreeCertificate, this.frontSideCertificate, this.backSideCertificate, this.ownerTransferForm, this.studAgreementForm, this.petMicrochipStatus, this.petMicrochipComment, this.petStatusComment, this.petLastBloodDonorAddress, this.sterilizationStatus, this.isSecondaryGardianAvailable, this.secondOwnerId, this.petStatus, this.isAffixCatteryPaid, this.isPetPaid, this.isPetApi, this.petUpdatedOn, this.petCreatedOn, this.userId, this.userAddedId, this.ownerType, this.organisationName, this.userFirstName, this.userLastName, this.userEmailId, this.userPassword, this.userProfileImage, this.userMobileNumber, this.userDateOfBirth, this.userGender, this.userBloodGroup, this.userCountry, this.userState, this.userDistrict, this.userCity, this.userAddress, this.userPinCode, this.deliveryDetails, this.userVerifyCode, this.affilateCode, this.isVerified, this.cardCode, this.cardExpiryDate, this.userStatus, this.isUserApi, this.isUserActive, this.userWebCode, this.userToken, this.userUpdateOn, this.userCreatedOn, this.lastDonateDate, this.donateAfter});

  Petlistmodel.fromJson(Map<String, dynamic> json) {
    if(json["pet_id"] is String) {
      petId = json["pet_id"];
    }
    if(json["pet_owner_id"] is String) {
      petOwnerId = json["pet_owner_id"];
    }
    if(json["pet_name"] is String) {
      petName = json["pet_name"];
    }
    if(json["pet_weight_in_kg"] is String) {
      petWeightInKg = json["pet_weight_in_kg"];
    }
    if(json["pet_slug"] is String) {
      petSlug = json["pet_slug"];
    }
    if(json["pet_category_id"] is String) {
      petCategoryId = json["pet_category_id"];
    }
    petCatteryId = json["pet_cattery_id"];
    applyCatteryName = json["apply_cattery_name"];
    if(json["pet_image"] is String) {
      petImage = json["pet_image"];
    }
    if(json["pet_pin_code"] is String) {
      petPinCode = json["pet_pin_code"];
    }
    if(json["pet_address"] is String) {
      petAddress = json["pet_address"];
    }
    if(json["pet_city"] is String) {
      petCity = json["pet_city"];
    }
    if(json["pet_state"] is String) {
      petState = json["pet_state"];
    }
    if(json["pet_district"] is String) {
      petDistrict = json["pet_district"];
    }
    if(json["pet_country"] is String) {
      petCountry = json["pet_country"];
    }
    petBloodDonorDetails = json["pet_blood_donor_details"];
    if(json["healthinfo"] is String) {
      healthinfo = json["healthinfo"];
    }
    if(json["vaccinationinfo"] is String) {
      vaccinationinfo = json["vaccinationinfo"];
    }
    if(json["medicationinfo"] is String) {
      medicationinfo = json["medicationinfo"];
    }
    if(json["veterinarian"] is String) {
      veterinarian = json["veterinarian"];
    }
    uploadImage = json["upload_image"];
    uploadVideo = json["upload_video"];
    uploadPdf = json["upload_pdf"];
    petRegistrationNumber = json["pet_registration_number"];
    petRegistrationNumberCreatedDate = json["pet_registration_number_created_date"];
    otherPetClubId = json["other_pet_club_id"];
    otherClubRegistrationNumber = json["other_club_registration_number"];
    if(json["microchip_number"] is String) {
      microchipNumber = json["microchip_number"];
    }
    if(json["microchip_implemented_by"] is String) {
      microchipImplementedBy = json["microchip_implemented_by"];
    }
    if(json["microchip_implementor_name"] is String) {
      microchipImplementorName = json["microchip_implementor_name"];
    }
    if(json["microchip_implementor_mobile_number"] is String) {
      microchipImplementorMobileNumber = json["microchip_implementor_mobile_number"];
    }
    if(json["microchip_implemented_date"] is String) {
      microchipImplementedDate = json["microchip_implemented_date"];
    }
    if(json["microchip_document"] is String) {
      microchipDocument = json["microchip_document"];
    }
    if(json["is_sire_register_with_aff"] is String) {
      isSireRegisterWithAff = json["is_sire_register_with_aff"];
    }
    if(json["is_sire_register_with_other"] is String) {
      isSireRegisterWithOther = json["is_sire_register_with_other"];
    }
    if(json["sire_other_club_id"] is String) {
      sireOtherClubId = json["sire_other_club_id"];
    }
    petSireRegistrationNumber = json["pet_sire_registration_number"];
    petSireRegistrationNumberOther = json["pet_sire_registration_number_other"];
    sireFrontSideCertificate = json["sire_front_side_certificate"];
    sireBackSideCertificate = json["sire_back_side_certificate"];
    sireOwnerTransferForm = json["sire_owner_transfer_form"];
    sireStudAgreementForm = json["sire_stud_agreement_form"];
    if(json["pet_sire_admin_status"] is String) {
      petSireAdminStatus = json["pet_sire_admin_status"];
    }
    if(json["is_dam_register_with_aff"] is String) {
      isDamRegisterWithAff = json["is_dam_register_with_aff"];
    }
    if(json["is_dam_register_with_other"] is String) {
      isDamRegisterWithOther = json["is_dam_register_with_other"];
    }
    if(json["dam_other_club_id"] is String) {
      damOtherClubId = json["dam_other_club_id"];
    }
    petDamRegistrationNumber = json["pet_dam_registration_number"];
    petDamRegistrationNumberOther = json["pet_dam_registration_number_other"];
    damFrontSideCertificate = json["dam_front_side_certificate"];
    damBackSideCertificate = json["dam_back_side_certificate"];
    damOwnerTransferForm = json["dam_owner_transfer_form"];
    damStudAgreementForm = json["dam_stud_agreement_form"];
    if(json["pet_dam_admin_status"] is String) {
      petDamAdminStatus = json["pet_dam_admin_status"];
    }
    if(json["pet_birth_date"] is String) {
      petBirthDate = json["pet_birth_date"];
    }
    petExpireDate = json["pet_expire_date"];
    if(json["pet_breed_id"] is String) {
      petBreedId = json["pet_breed_id"];
    }
    petCcpId = json["pet_ccp_id"];
    if(json["country_bred_in"] is String) {
      countryBredIn = json["country_bred_in"];
    }
    if(json["pet_gender"] is String) {
      petGender = json["pet_gender"];
    }
    if(json["with_microchip"] is String) {
      withMicrochip = json["with_microchip"];
    }
    microchipOrderWith = json["microchip_order_with"];
    if(json["is_indivisual_certificate"] is String) {
      isIndivisualCertificate = json["is_indivisual_certificate"];
    }
    if(json["is_tree_certificate"] is String) {
      isTreeCertificate = json["is_tree_certificate"];
    }
    frontSideCertificate = json["front_side_certificate"];
    backSideCertificate = json["back_side_certificate"];
    ownerTransferForm = json["owner_transfer_form"];
    studAgreementForm = json["stud_agreement_form"];
    if(json["pet_microchip_status"] is String) {
      petMicrochipStatus = json["pet_microchip_status"];
    }
    petMicrochipComment = json["pet_microchip_comment"];
    petStatusComment = json["pet_status_comment"];
    if(json["pet_last_blood_donor_address"] is String) {
      petLastBloodDonorAddress = json["pet_last_blood_donor_address"];
    }
    if(json["sterilization_status"] is String) {
      sterilizationStatus = json["sterilization_status"];
    }
    if(json["is_secondary_gardian_available"] is String) {
      isSecondaryGardianAvailable = json["is_secondary_gardian_available"];
    }
    if(json["second_owner_id"] is String) {
      secondOwnerId = json["second_owner_id"];
    }
    if(json["pet_status"] is String) {
      petStatus = json["pet_status"];
    }
    if(json["is_affix_cattery_paid"] is String) {
      isAffixCatteryPaid = json["is_affix_cattery_paid"];
    }
    if(json["is_pet_paid"] is String) {
      isPetPaid = json["is_pet_paid"];
    }
    if(json["is_pet_api"] is String) {
      isPetApi = json["is_pet_api"];
    }
    if(json["pet_updated_on"] is String) {
      petUpdatedOn = json["pet_updated_on"];
    }
    if(json["pet_created_on"] is String) {
      petCreatedOn = json["pet_created_on"];
    }
    if(json["user_id"] is String) {
      userId = json["user_id"];
    }
    userAddedId = json["user_added_id"];
    if(json["owner_type"] is String) {
      ownerType = json["owner_type"];
    }
    if(json["organisation_name"] is String) {
      organisationName = json["organisation_name"];
    }
    if(json["user_first_name"] is String) {
      userFirstName = json["user_first_name"];
    }
    if(json["user_last_name"] is String) {
      userLastName = json["user_last_name"];
    }
    if(json["user_email_id"] is String) {
      userEmailId = json["user_email_id"];
    }
    if(json["user_password"] is String) {
      userPassword = json["user_password"];
    }
    if(json["user_profile_image"] is String) {
      userProfileImage = json["user_profile_image"];
    }
    if(json["user_mobile_number"] is String) {
      userMobileNumber = json["user_mobile_number"];
    }
    if(json["user_date_of_birth"] is String) {
      userDateOfBirth = json["user_date_of_birth"];
    }
    if(json["user_gender"] is String) {
      userGender = json["user_gender"];
    }
    if(json["user_blood_group"] is String) {
      userBloodGroup = json["user_blood_group"];
    }
    if(json["user_country"] is String) {
      userCountry = json["user_country"];
    }
    if(json["user_state"] is String) {
      userState = json["user_state"];
    }
    if(json["user_district"] is String) {
      userDistrict = json["user_district"];
    }
    if(json["user_city"] is String) {
      userCity = json["user_city"];
    }
    if(json["user_address"] is String) {
      userAddress = json["user_address"];
    }
    if(json["user_pin_code"] is String) {
      userPinCode = json["user_pin_code"];
    }
    deliveryDetails = json["delivery_details"];
    if(json["user_verify_code"] is String) {
      userVerifyCode = json["user_verify_code"];
    }
    affilateCode = json["affilate_code"];
    if(json["is_verified"] is String) {
      isVerified = json["is_verified"];
    }
    cardCode = json["card_code"];
    cardExpiryDate = json["card_expiry_date"];
    if(json["user_status"] is String) {
      userStatus = json["user_status"];
    }
    if(json["is_user_api"] is String) {
      isUserApi = json["is_user_api"];
    }
    if(json["is_user_active"] is String) {
      isUserActive = json["is_user_active"];
    }
    if(json["user_web_code"] is String) {
      userWebCode = json["user_web_code"];
    }
    if(json["user_token"] is String) {
      userToken = json["user_token"];
    }
    if(json["user_update_on"] is String) {
      userUpdateOn = json["user_update_on"];
    }
    if(json["user_created_on"] is String) {
      userCreatedOn = json["user_created_on"];
    }
    if(json["last_donate_date"] is String) {
      lastDonateDate = json["last_donate_date"];
    }
    if(json["donate_after"] is String) {
      donateAfter = json["donate_after"];
    }
  }

  static List<Petlistmodel> fromList(List<Map<String, dynamic>> list) {
    return list.map(Petlistmodel.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["pet_id"] = petId;
    _data["pet_owner_id"] = petOwnerId;
    _data["pet_name"] = petName;
    _data["pet_weight_in_kg"] = petWeightInKg;
    _data["pet_slug"] = petSlug;
    _data["pet_category_id"] = petCategoryId;
    _data["pet_cattery_id"] = petCatteryId;
    _data["apply_cattery_name"] = applyCatteryName;
    _data["pet_image"] = petImage;
    _data["pet_pin_code"] = petPinCode;
    _data["pet_address"] = petAddress;
    _data["pet_city"] = petCity;
    _data["pet_state"] = petState;
    _data["pet_district"] = petDistrict;
    _data["pet_country"] = petCountry;
    _data["pet_blood_donor_details"] = petBloodDonorDetails;
    _data["healthinfo"] = healthinfo;
    _data["vaccinationinfo"] = vaccinationinfo;
    _data["medicationinfo"] = medicationinfo;
    _data["veterinarian"] = veterinarian;
    _data["upload_image"] = uploadImage;
    _data["upload_video"] = uploadVideo;
    _data["upload_pdf"] = uploadPdf;
    _data["pet_registration_number"] = petRegistrationNumber;
    _data["pet_registration_number_created_date"] = petRegistrationNumberCreatedDate;
    _data["other_pet_club_id"] = otherPetClubId;
    _data["other_club_registration_number"] = otherClubRegistrationNumber;
    _data["microchip_number"] = microchipNumber;
    _data["microchip_implemented_by"] = microchipImplementedBy;
    _data["microchip_implementor_name"] = microchipImplementorName;
    _data["microchip_implementor_mobile_number"] = microchipImplementorMobileNumber;
    _data["microchip_implemented_date"] = microchipImplementedDate;
    _data["microchip_document"] = microchipDocument;
    _data["is_sire_register_with_aff"] = isSireRegisterWithAff;
    _data["is_sire_register_with_other"] = isSireRegisterWithOther;
    _data["sire_other_club_id"] = sireOtherClubId;
    _data["pet_sire_registration_number"] = petSireRegistrationNumber;
    _data["pet_sire_registration_number_other"] = petSireRegistrationNumberOther;
    _data["sire_front_side_certificate"] = sireFrontSideCertificate;
    _data["sire_back_side_certificate"] = sireBackSideCertificate;
    _data["sire_owner_transfer_form"] = sireOwnerTransferForm;
    _data["sire_stud_agreement_form"] = sireStudAgreementForm;
    _data["pet_sire_admin_status"] = petSireAdminStatus;
    _data["is_dam_register_with_aff"] = isDamRegisterWithAff;
    _data["is_dam_register_with_other"] = isDamRegisterWithOther;
    _data["dam_other_club_id"] = damOtherClubId;
    _data["pet_dam_registration_number"] = petDamRegistrationNumber;
    _data["pet_dam_registration_number_other"] = petDamRegistrationNumberOther;
    _data["dam_front_side_certificate"] = damFrontSideCertificate;
    _data["dam_back_side_certificate"] = damBackSideCertificate;
    _data["dam_owner_transfer_form"] = damOwnerTransferForm;
    _data["dam_stud_agreement_form"] = damStudAgreementForm;
    _data["pet_dam_admin_status"] = petDamAdminStatus;
    _data["pet_birth_date"] = petBirthDate;
    _data["pet_expire_date"] = petExpireDate;
    _data["pet_breed_id"] = petBreedId;
    _data["pet_ccp_id"] = petCcpId;
    _data["country_bred_in"] = countryBredIn;
    _data["pet_gender"] = petGender;
    _data["with_microchip"] = withMicrochip;
    _data["microchip_order_with"] = microchipOrderWith;
    _data["is_indivisual_certificate"] = isIndivisualCertificate;
    _data["is_tree_certificate"] = isTreeCertificate;
    _data["front_side_certificate"] = frontSideCertificate;
    _data["back_side_certificate"] = backSideCertificate;
    _data["owner_transfer_form"] = ownerTransferForm;
    _data["stud_agreement_form"] = studAgreementForm;
    _data["pet_microchip_status"] = petMicrochipStatus;
    _data["pet_microchip_comment"] = petMicrochipComment;
    _data["pet_status_comment"] = petStatusComment;
    _data["pet_last_blood_donor_address"] = petLastBloodDonorAddress;
    _data["sterilization_status"] = sterilizationStatus;
    _data["is_secondary_gardian_available"] = isSecondaryGardianAvailable;
    _data["second_owner_id"] = secondOwnerId;
    _data["pet_status"] = petStatus;
    _data["is_affix_cattery_paid"] = isAffixCatteryPaid;
    _data["is_pet_paid"] = isPetPaid;
    _data["is_pet_api"] = isPetApi;
    _data["pet_updated_on"] = petUpdatedOn;
    _data["pet_created_on"] = petCreatedOn;
    _data["user_id"] = userId;
    _data["user_added_id"] = userAddedId;
    _data["owner_type"] = ownerType;
    _data["organisation_name"] = organisationName;
    _data["user_first_name"] = userFirstName;
    _data["user_last_name"] = userLastName;
    _data["user_email_id"] = userEmailId;
    _data["user_password"] = userPassword;
    _data["user_profile_image"] = userProfileImage;
    _data["user_mobile_number"] = userMobileNumber;
    _data["user_date_of_birth"] = userDateOfBirth;
    _data["user_gender"] = userGender;
    _data["user_blood_group"] = userBloodGroup;
    _data["user_country"] = userCountry;
    _data["user_state"] = userState;
    _data["user_district"] = userDistrict;
    _data["user_city"] = userCity;
    _data["user_address"] = userAddress;
    _data["user_pin_code"] = userPinCode;
    _data["delivery_details"] = deliveryDetails;
    _data["user_verify_code"] = userVerifyCode;
    _data["affilate_code"] = affilateCode;
    _data["is_verified"] = isVerified;
    _data["card_code"] = cardCode;
    _data["card_expiry_date"] = cardExpiryDate;
    _data["user_status"] = userStatus;
    _data["is_user_api"] = isUserApi;
    _data["is_user_active"] = isUserActive;
    _data["user_web_code"] = userWebCode;
    _data["user_token"] = userToken;
    _data["user_update_on"] = userUpdateOn;
    _data["user_created_on"] = userCreatedOn;
    _data["last_donate_date"] = lastDonateDate;
    _data["donate_after"] = donateAfter;
    return _data;
  }
}