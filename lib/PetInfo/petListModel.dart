
class Petlistmodel {
  String? petId;
  String? petOwnerId;
  String? petName;
  String? petSlug;
  String? petCategoryId;
  dynamic petCatteryId;
  dynamic applyCatteryName;
  String? petImage;
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
  dynamic petBreedId;
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
  String? petMicrochipComment;
  String? petStatusComment;
  String? sterilizationStatus;
  String? petStatus;
  String? isAffixCatteryPaid;
  String? isPetPaid;
  String? isPetApi;
  String? petUpdatedOn;
  String? petCreatedOn;

  Petlistmodel({this.petId, this.petOwnerId, this.petName, this.petSlug, this.petCategoryId, this.petCatteryId, this.applyCatteryName, this.petImage, this.uploadImage, this.uploadVideo, this.uploadPdf, this.petRegistrationNumber, this.petRegistrationNumberCreatedDate, this.otherPetClubId, this.otherClubRegistrationNumber, this.microchipNumber, this.microchipImplementedBy, this.microchipImplementorName, this.microchipImplementorMobileNumber, this.microchipImplementedDate, this.microchipDocument, this.isSireRegisterWithAff, this.isSireRegisterWithOther, this.sireOtherClubId, this.petSireRegistrationNumber, this.petSireRegistrationNumberOther, this.sireFrontSideCertificate, this.sireBackSideCertificate, this.sireOwnerTransferForm, this.sireStudAgreementForm, this.petSireAdminStatus, this.isDamRegisterWithAff, this.isDamRegisterWithOther, this.damOtherClubId, this.petDamRegistrationNumber, this.petDamRegistrationNumberOther, this.damFrontSideCertificate, this.damBackSideCertificate, this.damOwnerTransferForm, this.damStudAgreementForm, this.petDamAdminStatus, this.petBirthDate, this.petBreedId, this.petCcpId, this.countryBredIn, this.petGender, this.withMicrochip, this.microchipOrderWith, this.isIndivisualCertificate, this.isTreeCertificate, this.frontSideCertificate, this.backSideCertificate, this.ownerTransferForm, this.studAgreementForm, this.petMicrochipStatus, this.petMicrochipComment, this.petStatusComment, this.sterilizationStatus, this.petStatus, this.isAffixCatteryPaid, this.isPetPaid, this.isPetApi, this.petUpdatedOn, this.petCreatedOn});

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
    petBreedId = json["pet_breed_id"];
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
    if(json["pet_microchip_comment"] is String) {
      petMicrochipComment = json["pet_microchip_comment"];
    }
    if(json["pet_status_comment"] is String) {
      petStatusComment = json["pet_status_comment"];
    }
    if(json["sterilization_status"] is String) {
      sterilizationStatus = json["sterilization_status"];
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
  }

  static List<Petlistmodel> fromList(List<Map<String, dynamic>> list) {
    return list.map(Petlistmodel.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["pet_id"] = petId;
    _data["pet_owner_id"] = petOwnerId;
    _data["pet_name"] = petName;
    _data["pet_slug"] = petSlug;
    _data["pet_category_id"] = petCategoryId;
    _data["pet_cattery_id"] = petCatteryId;
    _data["apply_cattery_name"] = applyCatteryName;
    _data["pet_image"] = petImage;
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
    _data["sterilization_status"] = sterilizationStatus;
    _data["pet_status"] = petStatus;
    _data["is_affix_cattery_paid"] = isAffixCatteryPaid;
    _data["is_pet_paid"] = isPetPaid;
    _data["is_pet_api"] = isPetApi;
    _data["pet_updated_on"] = petUpdatedOn;
    _data["pet_created_on"] = petCreatedOn;
    return _data;
  }
}