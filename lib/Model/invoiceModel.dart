class InvoiceModel {
  final int? orgId;
  final String? tranNo;
  final String? tranDate;
  final String? orderNo;
  final String? orderDate;
  final String? customerId;
  final String? customerName;
  final String? customerAddress;
  final String? locationCode;
  final dynamic taxCode;
  final dynamic taxType;
  final dynamic paymentType;
  final double? taxPerc;
  final String? currencyCode;
  final double? currencyRate;
  final double? total;
  final double? discount;
  final double? discountPerc;
  final double? subTotal;
  final double? tax;
  final double? netTotal;
  final double? paidAmount;
  final double? balanceAmount;
  final double? fTotal;
  final double? fDiscount;
  final double? fSubTotal;
  final double? fTax;
  final double? fNetTotal;
  final double? fPaidAmount;
  final double? fBalanceAmount;
  final String? remarks;
  final String? referenceNo;
  final String? createdFrom;
  final bool? isActive;
  final String? createdBy;
  final String? createdOn;
  final String? changedBy;
  final String? changedOn;
  final String? assignTo;
  final String? tranDateString;
  final String? orderDateString;
  final dynamic invoiceDetail;
  final bool? isUpdate;
  final int? customerShipToId;
  final String? customerShipToAddress;
  final String? priceSettingCode;
  final String? termCode;
  final bool? invoiceType;
  final double? billDiscount;
  final double? creditLimit;
  final double? outStanding;
  final dynamic latitude;
  final dynamic longitude;
  final dynamic signatureimage;
  final String? sONo;
  final String? dONo;
  final dynamic cameraimage;
  final dynamic summaryRemarks;
  final dynamic pLNo;
  final String? customerEmail;
  final String? salesman;
  final double? fDiscountPerc;
  final double? fBillDiscount;

  InvoiceModel({
    this.orgId,
    this.tranNo,
    this.tranDate,
    this.orderNo,
    this.orderDate,
    this.customerId,
    this.customerName,
    this.customerAddress,
    this.locationCode,
    this.taxCode,
    this.taxType,
    this.paymentType,
    this.taxPerc,
    this.currencyCode,
    this.currencyRate,
    this.total,
    this.discount,
    this.discountPerc,
    this.subTotal,
    this.tax,
    this.netTotal,
    this.paidAmount,
    this.balanceAmount,
    this.fTotal,
    this.fDiscount,
    this.fSubTotal,
    this.fTax,
    this.fNetTotal,
    this.fPaidAmount,
    this.fBalanceAmount,
    this.remarks,
    this.referenceNo,
    this.createdFrom,
    this.isActive,
    this.createdBy,
    this.createdOn,
    this.changedBy,
    this.changedOn,
    this.assignTo,
    this.tranDateString,
    this.orderDateString,
    this.invoiceDetail,
    this.isUpdate,
    this.customerShipToId,
    this.customerShipToAddress,
    this.priceSettingCode,
    this.termCode,
    this.invoiceType,
    this.billDiscount,
    this.creditLimit,
    this.outStanding,
    this.latitude,
    this.longitude,
    this.signatureimage,
    this.sONo,
    this.dONo,
    this.cameraimage,
    this.summaryRemarks,
    this.pLNo,
    this.customerEmail,
    this.salesman,
    this.fDiscountPerc,
    this.fBillDiscount,
  });

  InvoiceModel.fromJson(Map<String, dynamic> json)
      : orgId = json['OrgId'] as int?,
        tranNo = json['TranNo'] as String?,
        tranDate = json['TranDate'] as String?,
        orderNo = json['OrderNo'] as String?,
        orderDate = json['OrderDate'] as String?,
        customerId = json['CustomerId'] as String?,
        customerName = json['CustomerName'] as String?,
        customerAddress = json['CustomerAddress'] as String?,
        locationCode = json['LocationCode'] as String?,
        taxCode = json['TaxCode'],
        taxType = json['TaxType'],
        paymentType = json['PaymentType'],
        taxPerc = json['TaxPerc'] as double?,
        currencyCode = json['CurrencyCode'] as String?,
        currencyRate = json['CurrencyRate'] as double?,
        total = json['Total'] as double?,
        discount = json['Discount'] as double?,
        discountPerc = json['DiscountPerc'] as double?,
        subTotal = json['SubTotal'] as double?,
        tax = json['Tax'] as double?,
        netTotal = json['NetTotal'] as double?,
        paidAmount = json['PaidAmount'] as double?,
        balanceAmount = json['BalanceAmount'] as double?,
        fTotal = json['FTotal'] as double?,
        fDiscount = json['FDiscount'] as double?,
        fSubTotal = json['FSubTotal'] as double?,
        fTax = json['FTax'] as double?,
        fNetTotal = json['FNetTotal'] as double?,
        fPaidAmount = json['FPaidAmount'] as double?,
        fBalanceAmount = json['FBalanceAmount'] as double?,
        remarks = json['Remarks'] as String?,
        referenceNo = json['ReferenceNo'] as String?,
        createdFrom = json['CreatedFrom'] as String?,
        isActive = json['IsActive'] as bool?,
        createdBy = json['CreatedBy'] as String?,
        createdOn = json['CreatedOn'] as String?,
        changedBy = json['ChangedBy'] as String?,
        changedOn = json['ChangedOn'] as String?,
        assignTo = json['AssignTo'] as String?,
        tranDateString = json['TranDateString'] as String?,
        orderDateString = json['OrderDateString'] as String?,
        invoiceDetail = json['InvoiceDetail'],
        isUpdate = json['IsUpdate'] as bool?,
        customerShipToId = json['CustomerShipToId'] as int?,
        customerShipToAddress = json['CustomerShipToAddress'] as String?,
        priceSettingCode = json['PriceSettingCode'] as String?,
        termCode = json['TermCode'] as String?,
        invoiceType = json['InvoiceType'] as bool?,
        billDiscount = json['BillDiscount'] as double?,
        creditLimit = json['CreditLimit'] as double?,
        outStanding = json['OutStanding'] as double?,
        latitude = json['Latitude'],
        longitude = json['Longitude'],
        signatureimage = json['Signatureimage'],
        sONo = json['SONo'] as String?,
        dONo = json['DONo'] as String?,
        cameraimage = json['Cameraimage'],
        summaryRemarks = json['SummaryRemarks'],
        pLNo = json['PLNo'],
        customerEmail = json['CustomerEmail'] as String?,
        salesman = json['Salesman'] as String?,
        fDiscountPerc = json['FDiscountPerc'] as double?,
        fBillDiscount = json['FBillDiscount'] as double?;

  Map<String, dynamic> toJson() => {
        'OrgId': orgId,
        'TranNo': tranNo,
        'TranDate': tranDate,
        'OrderNo': orderNo,
        'OrderDate': orderDate,
        'CustomerId': customerId,
        'CustomerName': customerName,
        'CustomerAddress': customerAddress,
        'LocationCode': locationCode,
        'TaxCode': taxCode,
        'TaxType': taxType,
        'PaymentType': paymentType,
        'TaxPerc': taxPerc,
        'CurrencyCode': currencyCode,
        'CurrencyRate': currencyRate,
        'Total': total,
        'Discount': discount,
        'DiscountPerc': discountPerc,
        'SubTotal': subTotal,
        'Tax': tax,
        'NetTotal': netTotal,
        'PaidAmount': paidAmount,
        'BalanceAmount': balanceAmount,
        'FTotal': fTotal,
        'FDiscount': fDiscount,
        'FSubTotal': fSubTotal,
        'FTax': fTax,
        'FNetTotal': fNetTotal,
        'FPaidAmount': fPaidAmount,
        'FBalanceAmount': fBalanceAmount,
        'Remarks': remarks,
        'ReferenceNo': referenceNo,
        'CreatedFrom': createdFrom,
        'IsActive': isActive,
        'CreatedBy': createdBy,
        'CreatedOn': createdOn,
        'ChangedBy': changedBy,
        'ChangedOn': changedOn,
        'AssignTo': assignTo,
        'TranDateString': tranDateString,
        'OrderDateString': orderDateString,
        'InvoiceDetail': invoiceDetail,
        'IsUpdate': isUpdate,
        'CustomerShipToId': customerShipToId,
        'CustomerShipToAddress': customerShipToAddress,
        'PriceSettingCode': priceSettingCode,
        'TermCode': termCode,
        'InvoiceType': invoiceType,
        'BillDiscount': billDiscount,
        'CreditLimit': creditLimit,
        'OutStanding': outStanding,
        'Latitude': latitude,
        'Longitude': longitude,
        'Signatureimage': signatureimage,
        'SONo': sONo,
        'DONo': dONo,
        'Cameraimage': cameraimage,
        'SummaryRemarks': summaryRemarks,
        'PLNo': pLNo,
        'CustomerEmail': customerEmail,
        'Salesman': salesman,
        'FDiscountPerc': fDiscountPerc,
        'FBillDiscount': fBillDiscount
      };
}
