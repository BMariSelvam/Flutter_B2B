import 'dart:convert';
import 'package:b2b/Model/sales_order/sales_order_detail.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

@immutable
class SalesOrder {
  final int? orgId;
  final String? tranNo;
  final String? tranDate;
  final String? customerId;
  final String? customerName;
  final String? customerAddress;
  final String? locationCode;
  final String? taxCode;
  final String? taxType;
  final num? taxPerc;
  final String? currencyCode;
  final num? currencyRate;
  final num? total;
  final num? discount;
  final num? discountPerc;
  final num? subTotal;
  final num? tax;
  final num? netTotal;
  final num? fTotal;
  final num? fDiscount;
  final num? fSubTotal;
  final num? fTax;
  final num? fNetTotal;
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
  final int? status;
  final List<SalesOrderDetail>? salesOrderDetail;
  final bool? isUpdate;
  final num? customerShipToId;
  final String? customerShipToAddress;
  final String? priceSettingCode;
  final String? termCode;
  final bool? invoiceType;
  final num? billDiscount;
  final num? latitude;
  final num? longitude;
  final String? signatureimage;
  final String? cameraimage;
  final String? summaryRemarks;
  final String? addressLine1;

  SalesOrder({
    this.orgId,
    this.tranNo,
    this.tranDate,
    this.customerId,
    this.customerName,
    this.customerAddress,
    this.locationCode,
    this.taxCode,
    this.taxType,
    this.taxPerc,
    this.currencyCode,
    this.currencyRate,
    this.total,
    this.discount,
    this.discountPerc,
    this.subTotal,
    this.tax,
    this.netTotal,
    this.fTotal,
    this.fDiscount,
    this.fSubTotal,
    this.fTax,
    this.fNetTotal,
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
    this.status,
    this.salesOrderDetail,
    this.isUpdate,
    this.customerShipToId,
    this.customerShipToAddress,
    this.priceSettingCode,
    this.termCode,
    this.invoiceType,
    this.billDiscount,
    this.latitude,
    this.longitude,
    this.signatureimage,
    this.cameraimage,
    this.summaryRemarks,
    this.addressLine1,
  });

  @override
  String toString() {
    return 'SalesOrder(orgId: $orgId, tranNo: $tranNo, tranDate: $tranDate, customerId: $customerId, customerName: $customerName, customerAddress: $customerAddress, locationCode: $locationCode, taxCode: $taxCode, taxType: $taxType, taxPerc: $taxPerc, currencyCode: $currencyCode, currencyRate: $currencyRate, total: $total, discount: $discount, discountPerc: $discountPerc, subTotal: $subTotal, tax: $tax, netTotal: $netTotal, fTotal: $fTotal, fDiscount: $fDiscount, fSubTotal: $fSubTotal, fTax: $fTax, fNetTotal: $fNetTotal, remarks: $remarks, referenceNo: $referenceNo, createdFrom: $createdFrom, isActive: $isActive, createdBy: $createdBy, createdOn: $createdOn, changedBy: $changedBy, changedOn: $changedOn, assignTo: $assignTo, tranDateString: $tranDateString, status: $status, salesOrderDetail: $salesOrderDetail, isUpdate: $isUpdate, customerShipToId: $customerShipToId, customerShipToAddress: $customerShipToAddress, priceSettingCode: $priceSettingCode, termCode: $termCode, invoiceType: $invoiceType, billDiscount: $billDiscount, latitude: $latitude, longitude: $longitude, signatureimage: $signatureimage, cameraimage: $cameraimage, summaryRemarks: $summaryRemarks, addressLine1: $addressLine1)';
  }

  factory SalesOrder.fromMap(Map<String, dynamic> data) => SalesOrder(
        orgId: data['OrgId'] as int?,
        tranNo: data['TranNo'] as String?,
        tranDate: data['TranDate'] as String?,
        customerId: data['CustomerId'] as String?,
        customerName: data['CustomerName'] as String?,
        customerAddress: data['CustomerAddress'] as String?,
        locationCode: data['LocationCode'] as String?,
        taxCode: data['TaxCode'] as String?,
        taxType: data['TaxType'] as String?,
        taxPerc: data['TaxPerc'] as num?,
        currencyCode: data['CurrencyCode'] as String?,
        currencyRate: data['CurrencyRate'] as num?,
        total: data['Total'] as num?,
        discount: data['Discount'] as num?,
        discountPerc: data['DiscountPerc'] as num?,
        subTotal: data['SubTotal'] as num?,
        tax: data['Tax'] as num?,
        netTotal: data['NetTotal'] as num?,
        fTotal: data['FTotal'] as num?,
        fDiscount: data['FDiscount'] as num?,
        fSubTotal: data['FSubTotal'] as num?,
        fTax: data['FTax'] as num?,
        fNetTotal: data['FNetTotal'] as num?,
        remarks: data['Remarks'] as String?,
        referenceNo: data['ReferenceNo'] as String?,
        createdFrom: data['CreatedFrom'] as String?,
        isActive: data['IsActive'] as bool?,
        createdBy: data['CreatedBy'] as String?,
        createdOn: data['CreatedOn'] as String?,
        changedBy: data['ChangedBy'] as String?,
        changedOn: data['ChangedOn'] as String,
        assignTo: data['AssignTo'] as String?,
        tranDateString: data['TranDateString'] as String?,
        status: data['Status'] as int?,
        salesOrderDetail: (data['SalesOrderDetail'] as List<dynamic>?)
            ?.map((e) => SalesOrderDetail.fromMap(e as Map<String, dynamic>))
            .toList(),
        isUpdate: data['IsUpdate'] as bool?,
        customerShipToId: data['CustomerShipToId'] as num?,
        customerShipToAddress: data['CustomerShipToAddress'] as String?,
        priceSettingCode: data['PriceSettingCode'] as String?,
        termCode: data['TermCode'] as String?,
        invoiceType: data['InvoiceType'] as bool?,
        billDiscount: data['BillDiscount'] as int?,
        latitude: data['Latitude'] as int?,
        longitude: data['Longitude'] as int?,
        signatureimage: data['Signatureimage'] as String?,
        cameraimage: data['Cameraimage'] as String?,
        summaryRemarks: data['SummaryRemarks'] as String?,
        addressLine1: data['AddressLine1'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'OrgId': orgId,
        'TranNo': tranNo,
        'TranDate': tranDate,
        'CustomerId': customerId,
        'CustomerName': customerName,
        'CustomerAddress': customerAddress,
        'LocationCode': locationCode,
        'TaxCode': taxCode,
        'TaxType': taxType,
        'TaxPerc': taxPerc,
        'CurrencyCode': currencyCode,
        'CurrencyRate': currencyRate,
        'Total': total,
        'Discount': discount,
        'DiscountPerc': discountPerc,
        'SubTotal': subTotal,
        'Tax': tax,
        'NetTotal': netTotal,
        'FTotal': fTotal,
        'FDiscount': fDiscount,
        'FSubTotal': fSubTotal,
        'FTax': fTax,
        'FNetTotal': fNetTotal,
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
        'Status': status,
        'IsUpdate': isUpdate,
        'CustomerShipToId': customerShipToId,
        'CustomerShipToAddress': customerShipToAddress,
        'PriceSettingCode': priceSettingCode,
        'TermCode': termCode,
        'InvoiceType': invoiceType,
        'Latitude': latitude,
        'Longitude': longitude,
        'Signatureimage': signatureimage,
        'Cameraimage': cameraimage,
        'SummaryRemarks': summaryRemarks,
        'AddressLine1': addressLine1,
        'SalesOrderDetail': salesOrderDetail?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [SalesOrder].
  factory SalesOrder.fromJson(String data) {
    return SalesOrder.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [SalesOrder] to a JSON string.
  String toJson() => json.encode(toMap());
  SalesOrder copyWith({
    int? orgId,
    String? tranNo,
    String? tranDate,
    String? customerId,
    String? customerName,
    String? customerAddress,
    String? locationCode,
    String? taxCode,
    String? taxType,
    num? taxPerc,
    String? currencyCode,
    num? currencyRate,
    num? total,
    num? discount,
    num? discountPerc,
    num? subTotal,
    num? tax,
    num? netTotal,
    num? fTotal,
    num? fDiscount,
    num? fSubTotal,
    num? fTax,
    num? fNetTotal,
    String? remarks,
    String? referenceNo,
    String? createdFrom,
    bool? isActive,
    String? createdBy,
    String? createdOn,
    String? changedBy,
    String? changedOn,
    String? assignTo,
    String? tranDateString,
    int? status,
    List<SalesOrderDetail>? salesOrderDetail,
    bool? isUpdate,
    num? customerShipToId,
    String? customerShipToAddress,
    String? priceSettingCode,
    String? termCode,
    bool? invoiceType,
    num? billDiscount,
    num? latitude,
    num? longitude,
    String? signatureimage,
    String? cameraimage,
    String? summaryRemarks,
    String? addressLine1,
  }) {
    return SalesOrder(
      orgId: orgId ?? this.orgId,
      tranNo: tranNo ?? this.tranNo,
      tranDate: tranDate ?? this.tranDate,
      customerId: customerId ?? this.customerId,
      customerName: customerName ?? this.customerName,
      customerAddress: customerAddress ?? this.customerAddress,
      locationCode: locationCode ?? this.locationCode,
      taxCode: taxCode ?? this.taxCode,
      taxType: taxType ?? this.taxType,
      taxPerc: taxPerc ?? this.taxPerc,
      currencyCode: currencyCode ?? this.currencyCode,
      currencyRate: currencyRate ?? this.currencyRate,
      total: total ?? this.total,
      discount: discount ?? this.discount,
      discountPerc: discountPerc ?? this.discountPerc,
      subTotal: subTotal ?? this.subTotal,
      tax: tax ?? this.tax,
      netTotal: netTotal ?? this.netTotal,
      fTotal: fTotal ?? this.fTotal,
      fDiscount: fDiscount ?? this.fDiscount,
      fSubTotal: fSubTotal ?? this.fSubTotal,
      fTax: fTax ?? this.fTax,
      fNetTotal: fNetTotal ?? this.fNetTotal,
      remarks: remarks ?? this.remarks,
      referenceNo: referenceNo ?? this.referenceNo,
      createdFrom: createdFrom ?? this.createdFrom,
      isActive: isActive ?? this.isActive,
      createdBy: createdBy ?? this.createdBy,
      createdOn: createdOn ?? this.createdOn,
      changedBy: changedBy ?? this.changedBy,
      changedOn: changedOn ?? this.changedOn,
      assignTo: assignTo ?? this.assignTo,
      tranDateString: tranDateString ?? this.tranDateString,
      status: status ?? this.status,
      salesOrderDetail: salesOrderDetail ?? this.salesOrderDetail,
      isUpdate: isUpdate ?? this.isUpdate,
      customerShipToId: customerShipToId ?? this.customerShipToId,
      customerShipToAddress:
          customerShipToAddress ?? this.customerShipToAddress,
      priceSettingCode: priceSettingCode ?? this.priceSettingCode,
      termCode: termCode ?? this.termCode,
      invoiceType: invoiceType ?? this.invoiceType,
      billDiscount: billDiscount ?? this.billDiscount,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      signatureimage: signatureimage ?? this.signatureimage,
      cameraimage: cameraimage ?? this.cameraimage,
      summaryRemarks: summaryRemarks ?? this.summaryRemarks,
      addressLine1: addressLine1 ?? this.addressLine1,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! SalesOrder) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      orgId.hashCode ^
      tranNo.hashCode ^
      tranDate.hashCode ^
      customerId.hashCode ^
      customerName.hashCode ^
      customerAddress.hashCode ^
      locationCode.hashCode ^
      taxCode.hashCode ^
      taxType.hashCode ^
      taxPerc.hashCode ^
      currencyCode.hashCode ^
      currencyRate.hashCode ^
      total.hashCode ^
      discount.hashCode ^
      discountPerc.hashCode ^
      subTotal.hashCode ^
      tax.hashCode ^
      netTotal.hashCode ^
      fTotal.hashCode ^
      fDiscount.hashCode ^
      fSubTotal.hashCode ^
      fTax.hashCode ^
      fNetTotal.hashCode ^
      remarks.hashCode ^
      referenceNo.hashCode ^
      createdFrom.hashCode ^
      isActive.hashCode ^
      createdBy.hashCode ^
      createdOn.hashCode ^
      changedBy.hashCode ^
      changedOn.hashCode ^
      assignTo.hashCode ^
      tranDateString.hashCode ^
      status.hashCode ^
      salesOrderDetail.hashCode ^
      isUpdate.hashCode ^
      customerShipToId.hashCode ^
      customerShipToAddress.hashCode ^
      priceSettingCode.hashCode ^
      termCode.hashCode ^
      invoiceType.hashCode ^
      billDiscount.hashCode ^
      latitude.hashCode ^
      longitude.hashCode ^
      signatureimage.hashCode ^
      cameraimage.hashCode ^
      summaryRemarks.hashCode ^
      addressLine1.hashCode;
}
