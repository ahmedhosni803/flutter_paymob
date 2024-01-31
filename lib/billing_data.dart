class BillingData {
  String? email;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? apartment;
  String? building;
  String? postalCode;
  String? city;
  String? state;
  String? country;
  String? floor;
  String? street;
  String? shippingMethod;

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

  Map<String, dynamic> toJson() {
    return {
      "email": email ?? "Unidentified",
      "first_name": firstName ?? "Unidentified",
      "last_name": lastName ?? "Unidentified",
      "phone_number": phoneNumber ?? "Unidentified",
      "apartment": apartment ?? "NA",
      "building": building ?? "NA",
      "street": street ?? "NA",
      "postal_code": postalCode ?? "NA",
      "city": city ?? "NA",
      "state": state ?? "NA",
      "country": country ?? "NA",
      "floor": floor ?? "NA",
      "shipping_method": shippingMethod ?? "NA",
    };
  }
}
