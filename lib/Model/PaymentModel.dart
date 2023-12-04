class PaymentModel {
  final int? orgId;
  final String? tranNo;
  final dynamic invoiceNo;
  final String? tranDate;
  final String? branchCode;
  final String? customerCode;
  final String? customerName;
  final String? address;
  final double? paidAmount;
  final String? payMode;
  final String? bank;
  final String? chequeNo;
  final String? chequeDate;
  final String? remarks;
  final String? accountNo;
  final String? createdBy;
  final String? createdOn;
  final String? changedBy;
  final String? changedOn;
  final dynamic isActive;
  final String? tranDatestring;
  final String? chequeDatestring;
  final dynamic moduleName;
  final String? paymodeName;
  final bool? isUpdate;
  final int? deliveryId;
  final dynamic tranDetail;
  final String? bankInDate;
  final String? bankInDateString;
  final dynamic netTotal;
  final dynamic creditAmount;
  final dynamic debitAmount;
  final dynamic advancePayment;
  final dynamic diff;
  final dynamic writeOff;
  final dynamic tranType;
  final dynamic receiptDetails;
  final int? chequeStatus;
  int count = 0;

  PaymentModel({
    this.orgId,
    this.tranNo,
    this.invoiceNo,
    this.tranDate,
    this.branchCode,
    this.customerCode,
    this.customerName,
    this.address,
    this.paidAmount,
    this.payMode,
    this.bank,
    this.chequeNo,
    this.chequeDate,
    this.remarks,
    this.accountNo,
    this.createdBy,
    this.createdOn,
    this.changedBy,
    this.changedOn,
    this.isActive,
    this.tranDatestring,
    this.chequeDatestring,
    this.moduleName,
    this.paymodeName,
    this.isUpdate,
    this.deliveryId,
    this.tranDetail,
    this.bankInDate,
    this.bankInDateString,
    this.netTotal,
    this.creditAmount,
    this.debitAmount,
    this.advancePayment,
    this.diff,
    this.writeOff,
    this.tranType,
    this.receiptDetails,
    this.chequeStatus,
  });

  PaymentModel.fromJson(Map<String, dynamic> json)
      : orgId = json['OrgId'] as int?,
        tranNo = json['TranNo'] as String?,
        invoiceNo = json['InvoiceNo'],
        tranDate = json['TranDate'] as String?,
        branchCode = json['BranchCode'] as String?,
        customerCode = json['CustomerCode'] as String?,
        customerName = json['CustomerName'] as String?,
        address = json['Address'] as String?,
        paidAmount = json['PaidAmount'] as double?,
        payMode = json['PayMode'] as String?,
        bank = json['Bank'] as String?,
        chequeNo = json['ChequeNo'] as String?,
        chequeDate = json['ChequeDate'] as String?,
        remarks = json['Remarks'] as String?,
        accountNo = json['AccountNo'] as String?,
        createdBy = json['CreatedBy'] as String?,
        createdOn = json['CreatedOn'] as String?,
        changedBy = json['ChangedBy'] as String?,
        changedOn = json['ChangedOn'] as String?,
        isActive = json['IsActive'],
        tranDatestring = json['TranDatestring'] as String?,
        chequeDatestring = json['ChequeDatestring'] as String?,
        moduleName = json['ModuleName'],
        paymodeName = json['PaymodeName'] as String?,
        isUpdate = json['IsUpdate'] as bool?,
        deliveryId = json['DeliveryId'] as int?,
        tranDetail = json['TranDetail'],
        bankInDate = json['BankInDate'] as String?,
        bankInDateString = json['BankInDateString'] as String?,
        netTotal = json['NetTotal'],
        creditAmount = json['CreditAmount'],
        debitAmount = json['DebitAmount'],
        advancePayment = json['AdvancePayment'],
        diff = json['Diff'],
        writeOff = json['WriteOff'],
        tranType = json['TranType'],
        receiptDetails = json['ReceiptDetails'],
        chequeStatus = json['ChequeStatus'] as int?;

  Map<String, dynamic> toJson() => {
        'OrgId': orgId,
        'TranNo': tranNo,
        'InvoiceNo': invoiceNo,
        'TranDate': tranDate,
        'BranchCode': branchCode,
        'CustomerCode': customerCode,
        'CustomerName': customerName,
        'Address': address,
        'PaidAmount': paidAmount,
        'PayMode': payMode,
        'Bank': bank,
        'ChequeNo': chequeNo,
        'ChequeDate': chequeDate,
        'Remarks': remarks,
        'AccountNo': accountNo,
        'CreatedBy': createdBy,
        'CreatedOn': createdOn,
        'ChangedBy': changedBy,
        'ChangedOn': changedOn,
        'IsActive': isActive,
        'TranDatestring': tranDatestring,
        'ChequeDatestring': chequeDatestring,
        'ModuleName': moduleName,
        'PaymodeName': paymodeName,
        'IsUpdate': isUpdate,
        'DeliveryId': deliveryId,
        'TranDetail': tranDetail,
        'BankInDate': bankInDate,
        'BankInDateString': bankInDateString,
        'NetTotal': netTotal,
        'CreditAmount': creditAmount,
        'DebitAmount': debitAmount,
        'AdvancePayment': advancePayment,
        'Diff': diff,
        'WriteOff': writeOff,
        'TranType': tranType,
        'ReceiptDetails': receiptDetails,
        'ChequeStatus': chequeStatus
      };
}
