class LoginUser {
  String? id;
  int? orgId;
  String? code;
  String? name;
  String? customerGroup;
  String? remarks;
  String? customerType;
  String? uniqueNo;
  String? mail;
  dynamic addressLine1;
  String? addressLine2;
  String? addressLine3;
  String? countryId;
  dynamic postalCode;
  String? mobile;
  String? phone;
  String? fax;
  String? currencyId;
  String? taxTypeId;
  String? directorName;
  String? directorPhone;
  String? directorMobile;
  String? directorMail;
  String? salesPerson;
  String? paymentTerms;
  String? source;
  bool? isActive;
  bool? isOutStanding;
  dynamic createdBy;
  String? createdOn;
  dynamic changedBy;
  dynamic changedOn;
  String? activity1;
  String? activity2;
  String? contactPerson;
  dynamic countryName;
  String? priceSettings;
  double? creditLimit;
  dynamic outstandingAmount;
  dynamic account;
  int? isVisited;
  int? visitedNo;
  dynamic visitedDate;
  String? password;
  dynamic contactType;

  LoginUser({
    this.id,
    this.orgId,
    this.code,
    this.name,
    this.customerGroup,
    this.remarks,
    this.customerType,
    this.uniqueNo,
    this.mail,
    this.addressLine1,
    this.addressLine2,
    this.addressLine3,
    this.countryId,
    this.postalCode,
    this.mobile,
    this.phone,
    this.fax,
    this.currencyId,
    this.taxTypeId,
    this.directorName,
    this.directorPhone,
    this.directorMobile,
    this.directorMail,
    this.salesPerson,
    this.paymentTerms,
    this.source,
    this.isActive,
    this.isOutStanding,
    this.createdBy,
    this.createdOn,
    this.changedBy,
    this.changedOn,
    this.activity1,
    this.activity2,
    this.contactPerson,
    this.countryName,
    this.priceSettings,
    this.creditLimit,
    this.outstandingAmount,
    this.account,
    this.isVisited,
    this.visitedNo,
    this.visitedDate,
    this.password,
    this.contactType,
  });

  factory LoginUser.fromJson(Map<String, dynamic> json) => LoginUser(
        id: json['id'] as String?,
        orgId: json['OrgId'] as int?,
        code: json['Code'] as String?,
        name: json['Name'] as String?,
        customerGroup: json['CustomerGroup'] as String?,
        remarks: json['Remarks'] as String?,
        customerType: json['CustomerType'] as String?,
        uniqueNo: json['UniqueNo'] as String?,
        mail: json['Mail'] as String?,
        addressLine1: json['AddressLine1'] as dynamic,
        addressLine2: json['AddressLine2'] as String?,
        addressLine3: json['AddressLine3'] as String?,
        countryId: json['CountryId'] as String?,
        postalCode: json['PostalCode'] as dynamic,
        mobile: json['Mobile'] as String?,
        phone: json['Phone'] as String?,
        fax: json['Fax'] as String?,
        currencyId: json['CurrencyId'] as String?,
        taxTypeId: json['TaxTypeId'] as String?,
        directorName: json['DirectorName'] as String?,
        directorPhone: json['DirectorPhone'] as String?,
        directorMobile: json['DirectorMobile'] as String?,
        directorMail: json['DirectorMail'] as String?,
        salesPerson: json['SalesPerson'] as String?,
        paymentTerms: json['PaymentTerms'] as String?,
        source: json['Source'] as String?,
        isActive: json['IsActive'] as bool?,
        isOutStanding: json['IsOutStanding'] as bool?,
        createdBy: json['CreatedBy'] as dynamic,
        createdOn: json['CreatedOn'] as String?,
        changedBy: json['ChangedBy'] as dynamic,
        changedOn: json['ChangedOn'] as dynamic,
        activity1: json['Activity1'] as String?,
        activity2: json['Activity2'] as String?,
        contactPerson: json['ContactPerson'] as String?,
        countryName: json['CountryName'] as dynamic,
        priceSettings: json['PriceSettings'] as String?,
        creditLimit: json['CreditLimit'] as double?,
        outstandingAmount: json['OutstandingAmount'] as dynamic,
        account: json['Account'] as dynamic,
        isVisited: json['IsVisited'] as int?,
        visitedNo: json['VisitedNo'] as int?,
        visitedDate: json['VisitedDate'] as dynamic,
        password: json['Password'] as String?,
        contactType: json['ContactType'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'OrgId': orgId,
        'Code': code,
        'Name': name,
        'CustomerGroup': customerGroup,
        'Remarks': remarks,
        'CustomerType': customerType,
        'UniqueNo': uniqueNo,
        'Mail': mail,
        'AddressLine1': addressLine1,
        'AddressLine2': addressLine2,
        'AddressLine3': addressLine3,
        'CountryId': countryId,
        'PostalCode': postalCode,
        'Mobile': mobile,
        'Phone': phone,
        'Fax': fax,
        'CurrencyId': currencyId,
        'TaxTypeId': taxTypeId,
        'DirectorName': directorName,
        'DirectorPhone': directorPhone,
        'DirectorMobile': directorMobile,
        'DirectorMail': directorMail,
        'SalesPerson': salesPerson,
        'PaymentTerms': paymentTerms,
        'Source': source,
        'IsActive': isActive,
        'IsOutStanding': isOutStanding,
        'CreatedBy': createdBy,
        'CreatedOn': createdOn,
        'ChangedBy': changedBy,
        'ChangedOn': changedOn,
        'Activity1': activity1,
        'Activity2': activity2,
        'ContactPerson': contactPerson,
        'CountryName': countryName,
        'PriceSettings': priceSettings,
        'CreditLimit': creditLimit,
        'OutstandingAmount': outstandingAmount,
        'Account': account,
        'IsVisited': isVisited,
        'VisitedNo': visitedNo,
        'VisitedDate': visitedDate,
        'Password': password,
        'ContactType': contactType,
      };
}
