class CustomerDashBoardModel {
  int? orgId;
  String? customerCode;
  double? salesorderTotal;
  double? invoiceTotal;
  double? receiptTotal;
  double? outStandingTotal;

  CustomerDashBoardModel(
      {this.orgId,
      this.customerCode,
      this.salesorderTotal,
      this.invoiceTotal,
      this.receiptTotal,
      this.outStandingTotal});

  CustomerDashBoardModel.fromJson(Map<String, dynamic> json) {
    orgId = json['OrgId'];
    customerCode = json['CustomerCode'];
    salesorderTotal = json['SalesorderTotal'];
    invoiceTotal = json['InvoiceTotal'];
    receiptTotal = json['ReceiptTotal'];
    outStandingTotal = json['OutStandingTotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OrgId'] = this.orgId;
    data['CustomerCode'] = this.customerCode;
    data['SalesorderTotal'] = this.salesorderTotal;
    data['InvoiceTotal'] = this.invoiceTotal;
    data['ReceiptTotal'] = this.receiptTotal;
    data['OutStandingTotal'] = this.outStandingTotal;
    return data;
  }
}
