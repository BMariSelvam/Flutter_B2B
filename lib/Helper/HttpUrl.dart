class HttpUrl {
  static const String base = "http://154.26.130.251:302/";

   //static const String base = "http://154.26.130.251:85/";

   //static const String base = "http://154.26.130.251:626/";

  // static const String base = "http://154.26.130.251:522/";

  static String get baseUrl => "${base}api/";

  static String get getAllCategory => "${base}Category/GetAll?";

  static String get getAllSubCategory => "$base/SubCategory/GetbyCategoryCode?";

  static String get getAllProduct =>
      "${base}/Product/GetAllWithImage?OrganizationId=1";

  static String get getAllFiltterProduct => "${base}Product/GetAllWithImage?";

  static String get salesOrderCreate => "${base}SalesOrder/Create";

  static String get login => "${base}CustomerLogin";

  static String get taxGetApi => "${base}/Tax/Getbycode?";

  static String get salesOrderGetAll => "${base}SalesOrder/GetHeaderSearch?";

  static String get salesOrderGetHeaderSearch =>
      "${base}/SalesOrder/GetHeaderSearch?";

  static String get salesOrderGetbycode => "${base}/SalesOrder/Getbycode?";

  static String get invoiceGetbycode => "${base}/Invoice/Getbycode?";

  static String get invoiceGetHeaderSearch => "${base}Invoice/GetHeaderSearch?";

  static String get receiptGetHeaderSearch => "${base}Receipt/GetHeaderSearch?";

  static String get pagination =>
      "${base}Product/GetAll?OrganizationId=1&pageNo=1&pageSize=12";

  static String get bannerImage =>
      "${base}B2CBannerImage/GetAll?OrganizationId=1";

  static String get customerRegisterLogin =>
      "${base}B2CCustomerRegister/CustomerLogin";

  static String get getCustomerDashBoard => "${base}GetCustomerDashBoard?";

  static String get getCustomerDeliveryAddress =>
      "${base}Deliveryaddress/GetAllbyCustomer?";

  static String get getCustomerChangepassword => "${base}Changepassword";

  static String get getforgotPassword => "${base}Changepassword";

  static String get getCreateAddress => "${base}CustomerDelivery/Create";
}
