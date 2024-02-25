/// Represents billing data for a particular entity.
/// Billing Information

class BillingData {
  /// Email address
  String? email;

  /// First name
  String? firstName;

  /// Last name
  String? lastName;

  /// Phone number
  String? phoneNumber;

  /// Apartment number
  String? apartment;

  /// Building number
  String? building;

  /// Postal code
  String? postalCode;

  /// City
  String? city;

  /// State
  String? state;

  /// Country
  String? country;

  /// Floor
  String? floor;

  /// Street
  String? street;

  /// Shipping method
  String? shippingMethod;

  /// Constructs a [BillingData] object with the provided data.
  /// Optional data can be left blank.
  BillingData({
    this.email,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.apartment,
    this.building,
    this.postalCode,
    this.city,
    this.state,
    this.country,
    this.floor,
    this.street,
    this.shippingMethod,
  });

  /// Converts the [BillingData] object into a [Map<String, dynamic>] for JSON serialization.
  Map<String, dynamic> toJson() {
    return {
      "email": email ??
          "Unidentified", // Use "Unidentified" if email is not available.
      "first_name": firstName ??
          "Unidentified", // Use "Unidentified" if first name is not available.
      "last_name": lastName ??
          "Unidentified", // Use "Unidentified" if last name is not available.
      "phone_number": phoneNumber ??
          "Unidentified", // Use "Unidentified" if phone number is not available.
      "apartment":
          apartment ?? "NA", // Use "NA" if apartment number is not available.
      "building":
          building ?? "NA", // Use "NA" if building number is not available.
      "street": street ?? "NA", // Use "NA" if street is not available.
      "postal_code":
          postalCode ?? "NA", // Use "NA" if postal code is not available.
      "city": city ?? "NA", // Use "NA" if city is not available.
      "state": state ?? "NA", // Use "NA" if state is not available.
      "country": country ?? "NA", // Use "NA" if country is not available.
      "floor": floor ?? "NA", // Use "NA" if floor is not available.
      "shipping_method": shippingMethod ??
          "NA", // Use "NA" if shipping method is not available.
    };
  }
}
