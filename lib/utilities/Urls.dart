// ignore_for_file: constant_identifier_names

class Urls {
  //Base
  static const baseUrl = "https://propertymaster.co.in/propertymaster-admin/api/";
  static const imageUrl = "https://propertymaster.co.in/app_backend_test/ISKTCS/images/";

  //Other Apis
  static const loginUrl = "${baseUrl}login";
  static const realEstateUrl = "${baseUrl}leads_as_user";
  static const leadsListUrl = "${baseUrl}leads_list";
  static const followupListUrl = "${baseUrl}followup";
  static const addFollowupUrl = "${baseUrl}create_followup";
  static const addLeadUrl = "${baseUrl}create_lead";
  static const locationListUrl = "${baseUrl}project_list";
  static const leadSourceListUrl = "${baseUrl}lead_source";
  static const addContact2Url = "${baseUrl}add_contact_to_lead";
  static const propertyDataUrl = "${baseUrl}property_data";
  static const sendOtp = "${baseUrl}sendOtp";
  static const otpVerfication = "${baseUrl}otpVerfication";
  static const updatePassword = "${baseUrl}updatePassword";
}