class Petlistmodel {
  String? petId;
  String? petOwnerId;
  String? petName;
  dynamic petWeightInKg;
  String? petSlug;
  String? petCategoryId;
  dynamic petCatteryId;
  dynamic applyCatteryName;
  String? petImage;
  String? isAddressSame;
  dynamic petPinCode;
  dynamic petAddress;
  dynamic petCity;
  dynamic petState;
  dynamic petDistrict;
  dynamic petCountry;
  dynamic petBloodDonorDetails;
  dynamic healthinfo;
  dynamic vaccinationinfo;
  dynamic medicationinfo;
  dynamic veterinarian;
  dynamic uploadImage;
  dynamic uploadVideo;
  dynamic uploadPdf;
  dynamic petRegistrationNumber;
  dynamic petRegistrationNumberCreatedDate;
  dynamic otherPetClubId;
  dynamic otherClubRegistrationNumber;
  dynamic microchipNumber;
  dynamic microchipImplementedBy;
  dynamic microchipImplementorName;
  dynamic microchipImplementorMobileNumber;
  dynamic microchipImplementedDate;
  dynamic microchipDocument;
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
  String? petExpireDate;
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
  dynamic petLastBloodDonorAddress;
  String? sterilizationStatus;
  String? isSecondaryGardianAvailable;
  dynamic secondOwnerId;
  String? petStatus;
  String? isAffixCatteryPaid;
  String? isPetPaid;
  String? isPetApi;
  String? petUpdatedOn;
  String? petCreatedOn;
  dynamic userId;
  dynamic userAddedId;
  dynamic ownerType;
  dynamic organisationName;
  dynamic userFirstName;
  dynamic userLastName;
  dynamic userEmailId;
  dynamic userPassword;
  dynamic userProfileImage;
  dynamic userMobileNumber;
  dynamic userDateOfBirth;
  dynamic userGender;
  dynamic userBloodGroup;
  dynamic userCountry;
  dynamic userState;
  dynamic userDistrict;
  dynamic userCity;
  dynamic userAddress;
  dynamic userPinCode;
  dynamic deliveryDetails;
  dynamic userVerifyCode;
  dynamic affilateCode;
  dynamic isVerified;
  dynamic cardCode;
  dynamic cardExpiryDate;
  dynamic userStatus;
  dynamic isUserApi;
  dynamic isUserActive;
  dynamic userWebCode;
  dynamic userToken;
  dynamic userUpdateOn;
  dynamic userCreatedOn;
  String? lastDonateDate;
  String? menstrualDate;

  Petlistmodel({this.petId, this.petOwnerId, this.petName, this.petWeightInKg, this.petSlug, this.petCategoryId, this.petCatteryId, this.applyCatteryName, this.petImage, this.isAddressSame, this.petPinCode, this.petAddress, this.petCity, this.petState, this.petDistrict, this.petCountry, this.petBloodDonorDetails, this.healthinfo, this.vaccinationinfo, this.medicationinfo, this.veterinarian, this.uploadImage, this.uploadVideo, this.uploadPdf, this.petRegistrationNumber, this.petRegistrationNumberCreatedDate, this.otherPetClubId, this.otherClubRegistrationNumber, this.microchipNumber, this.microchipImplementedBy, this.microchipImplementorName, this.microchipImplementorMobileNumber, this.microchipImplementedDate, this.microchipDocument, this.isSireRegisterWithAff, this.isSireRegisterWithOther, this.sireOtherClubId, this.petSireRegistrationNumber, this.petSireRegistrationNumberOther, this.sireFrontSideCertificate, this.sireBackSideCertificate, this.sireOwnerTransferForm, this.sireStudAgreementForm, this.petSireAdminStatus, this.isDamRegisterWithAff, this.isDamRegisterWithOther, this.damOtherClubId, this.petDamRegistrationNumber, this.petDamRegistrationNumberOther, this.damFrontSideCertificate, this.damBackSideCertificate, this.damOwnerTransferForm, this.damStudAgreementForm, this.petDamAdminStatus, this.petBirthDate, this.petExpireDate, this.petBreedId, this.petCcpId, this.countryBredIn, this.petGender, this.withMicrochip, this.microchipOrderWith, this.isIndivisualCertificate, this.isTreeCertificate, this.frontSideCertificate, this.backSideCertificate, this.ownerTransferForm, this.studAgreementForm, this.petMicrochipStatus, this.petMicrochipComment, this.petStatusComment, this.petLastBloodDonorAddress, this.sterilizationStatus, this.isSecondaryGardianAvailable, this.secondOwnerId, this.petStatus, this.isAffixCatteryPaid, this.isPetPaid, this.isPetApi, this.petUpdatedOn, this.petCreatedOn, this.userId, this.userAddedId, this.ownerType, this.organisationName, this.userFirstName, this.userLastName, this.userEmailId, this.userPassword, this.userProfileImage, this.userMobileNumber, this.userDateOfBirth, this.userGender, this.userBloodGroup, this.userCountry, this.userState, this.userDistrict, this.userCity, this.userAddress, this.userPinCode, this.deliveryDetails, this.userVerifyCode, this.affilateCode, this.isVerified, this.cardCode, this.cardExpiryDate, this.userStatus, this.isUserApi, this.isUserActive, this.userWebCode, this.userToken, this.userUpdateOn, this.userCreatedOn, this.lastDonateDate, this.menstrualDate});

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
    petWeightInKg = json["pet_weight_in_kg"];
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
    if(json["is_address_same"] is String) {
      isAddressSame = json["is_address_same"];
    }
    petPinCode = json["pet_pin_code"];
    petAddress = json["pet_address"];
    petCity = json["pet_city"];
    petState = json["pet_state"];
    petDistrict = json["pet_district"];
    petCountry = json["pet_country"];
    petBloodDonorDetails = json["pet_blood_donor_details"];
    healthinfo = json["healthinfo"];
    vaccinationinfo = json["vaccinationinfo"];
    medicationinfo = json["medicationinfo"];
    veterinarian = json["veterinarian"];
    uploadImage = json["upload_image"];
    uploadVideo = json["upload_video"];
    uploadPdf = json["upload_pdf"];
    petRegistrationNumber = json["pet_registration_number"];
    petRegistrationNumberCreatedDate = json["pet_registration_number_created_date"];
    otherPetClubId = json["other_pet_club_id"];
    otherClubRegistrationNumber = json["other_club_registration_number"];
    microchipNumber = json["microchip_number"];
    microchipImplementedBy = json["microchip_implemented_by"];
    microchipImplementorName = json["microchip_implementor_name"];
    microchipImplementorMobileNumber = json["microchip_implementor_mobile_number"];
    microchipImplementedDate = json["microchip_implemented_date"];
    microchipDocument = json["microchip_document"];
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
    if(json["pet_expire_date"] is String) {
      petExpireDate = json["pet_expire_date"];
    }
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
    petLastBloodDonorAddress = json["pet_last_blood_donor_address"];
    if(json["sterilization_status"] is String) {
      sterilizationStatus = json["sterilization_status"];
    }
    if(json["is_secondary_gardian_available"] is String) {
      isSecondaryGardianAvailable = json["is_secondary_gardian_available"];
    }
    secondOwnerId = json["second_owner_id"];
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
    userId = json["user_id"];
    userAddedId = json["user_added_id"];
    ownerType = json["owner_type"];
    organisationName = json["organisation_name"];
    userFirstName = json["user_first_name"];
    userLastName = json["user_last_name"];
    userEmailId = json["user_email_id"];
    userPassword = json["user_password"];
    userProfileImage = json["user_profile_image"];
    userMobileNumber = json["user_mobile_number"];
    userDateOfBirth = json["user_date_of_birth"];
    userGender = json["user_gender"];
    userBloodGroup = json["user_blood_group"];
    userCountry = json["user_country"];
    userState = json["user_state"];
    userDistrict = json["user_district"];
    userCity = json["user_city"];
    userAddress = json["user_address"];
    userPinCode = json["user_pin_code"];
    deliveryDetails = json["delivery_details"];
    userVerifyCode = json["user_verify_code"];
    affilateCode = json["affilate_code"];
    isVerified = json["is_verified"];
    cardCode = json["card_code"];
    cardExpiryDate = json["card_expiry_date"];
    userStatus = json["user_status"];
    isUserApi = json["is_user_api"];
    isUserActive = json["is_user_active"];
    userWebCode = json["user_web_code"];
    userToken = json["user_token"];
    userUpdateOn = json["user_update_on"];
    userCreatedOn = json["user_created_on"];
    if(json["last_donate_date"] is String) {
      lastDonateDate = json["last_donate_date"];
    }
    if(json["menstrual_date"] is String) {
      menstrualDate = json["menstrual_date"];
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
    _data["is_address_same"] = isAddressSame;
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
    _data["menstrual_date"] = menstrualDate;
    return _data;
  }
}