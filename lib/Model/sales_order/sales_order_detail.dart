import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

@immutable
class SalesOrderDetail {
  final int? orgId;
  final String? tranNo;
  int? slNo;
  final String? productCode;
  final String? productName;
  final int? boxQty;
  final int? pcsQty;
  final int? qty;
  final int? boxCount;
  final double? boxPrice;
  final int? price;
  final int? foc;
  final int? exchange;
  final double? total;
  final double? itemDiscount;
  final double? itemDiscountPerc;
  final double? subTotal;
  final double? tax;
  final double? netTotal;
  final double? fBoxPrice;
  final double? fPrice;
  final double? fTotal;
  final double? fItemDiscount;
  final double? fSubTotal;
  final double? fTax;
  final double? fNetTotal;
  final String? remarks;
  final String? createdBy;
  final String? createdOn;
  final String? changedBy;
  final String? changedOn;
  final int? stockQty;
  final int? stockBoxQty;
  final int? stockPcsQty;
  final double? weight;
  final bool? isWeight;

  SalesOrderDetail({
    this.orgId,
    this.tranNo,
    this.slNo,
    this.productCode,
    this.productName,
    this.boxQty,
    this.pcsQty,
    this.qty,
    this.boxCount,
    this.boxPrice,
    this.price,
    this.foc,
    this.exchange,
    this.total,
    this.itemDiscount,
    this.itemDiscountPerc,
    this.subTotal,
    this.tax,
    this.netTotal,
    this.fBoxPrice,
    this.fPrice,
    this.fTotal,
    this.fItemDiscount,
    this.fSubTotal,
    this.fTax,
    this.fNetTotal,
    this.remarks,
    this.createdBy,
    this.createdOn,
    this.changedBy,
    this.changedOn,
    this.stockQty,
    this.stockBoxQty,
    this.stockPcsQty,
    this.weight,
    this.isWeight,
  });

  @override
  String toString() {
    return 'SalesOrderDetail(orgId: $orgId, tranNo: $tranNo, slNo: $slNo, productCode: $productCode, productName: $productName, boxQty: $boxQty, pcsQty: $pcsQty, qty: $qty, boxCount: $boxCount, boxPrice: $boxPrice, price: $price, foc: $foc, exchange: $exchange, total: $total, itemDiscount: $itemDiscount, itemDiscountPerc: $itemDiscountPerc, subTotal: $subTotal, tax: $tax, netTotal: $netTotal, fBoxPrice: $fBoxPrice, fPrice: $fPrice, fTotal: $fTotal, fItemDiscount: $fItemDiscount, fSubTotal: $fSubTotal, fTax: $fTax, fNetTotal: $fNetTotal, remarks: $remarks, createdBy: $createdBy, createdOn: $createdOn, changedBy: $changedBy, changedOn: $changedOn, stockQty: $stockQty, stockBoxQty: $stockBoxQty, stockPcsQty: $stockPcsQty, weight: $weight, isWeight: $isWeight)';
  }

  factory SalesOrderDetail.fromMap(Map<String, dynamic> data) {
    return SalesOrderDetail(
      orgId: data['OrgId'] as int?,
      tranNo: data['TranNo'] as String?,
      slNo: data['SlNo'] as int?,
      productCode: data['ProductCode'] as String?,
      productName: data['ProductName'] as String?,
      boxQty: data['BoxQty'] as int?,
      pcsQty: data['PcsQty'] as int?,
      qty: data['Qty'] as int?,
      boxCount: data['BoxCount'] as int?,
      boxPrice: data['BoxPrice'] as double?,
      price: data['Price'] as int?,
      foc: data['Foc'] as int?,
      exchange: data['Exchange'] as int?,
      total: data['Total'] as double?,
      itemDiscount: data['ItemDiscount'] as double?,
      itemDiscountPerc: data['ItemDiscountPerc'] as double?,
      subTotal: data['SubTotal'] as double?,
      tax: data['Tax'] as double?,
      netTotal: data['NetTotal'] as double?,
      fBoxPrice: data['FBoxPrice'] as double?,
      fPrice: data['FPrice'] as double?,
      fTotal: data['FTotal'] as double?,
      fItemDiscount: data['FItemDiscount'] as double?,
      fSubTotal: data['FSubTotal'] as double?,
      fTax: data['FTax'] as double?,
      fNetTotal: data['FNetTotal'] as double?,
      remarks: data['Remarks'] as String?,
      createdBy: data['CreatedBy'] as String?,
      createdOn: data['CreatedOn'] as String,
      changedBy: data['ChangedBy'] as String?,
      changedOn: data['ChangedOn'] as String?,
      stockQty: data['StockQty'] as int?,
      stockBoxQty: data['StockBoxQty'] as int?,
      stockPcsQty: data['StockPcsQty'] as int?,
      weight: data['Weight'] as double?,
      isWeight: data['IsWeight'] as bool?,
    );
  }

  Map<String, dynamic> toMap() => {
        'OrgId': orgId,
        'TranNo': tranNo,
        'SlNo': slNo,
        'ProductCode': productCode,
        'ProductName': productName,
        'BoxQty': boxQty,
        'PcsQty': pcsQty,
        'Qty': qty,
        'BoxCount': boxCount,
        'BoxPrice': boxPrice,
        'Price': price,
        'Foc': foc,
        'Exchange': exchange,
        'Total': total,
        'ItemDiscount': itemDiscount,
        'ItemDiscountPerc': itemDiscountPerc,
        'SubTotal': subTotal,
        'Tax': tax,
        'NetTotal': netTotal,
        'FBoxPrice': fBoxPrice,
        'FPrice': fPrice,
        'FTotal': fTotal,
        'FItemDiscount': fItemDiscount,
        'FSubTotal': fSubTotal,
        'FTax': fTax,
        'FNetTotal': fNetTotal,
        'Remarks': remarks,
        'CreatedBy': createdBy,
        'CreatedOn': createdOn,
        'ChangedBy': changedBy,
        'ChangedOn': changedOn,
        'StockQty': stockQty,
        'StockBoxQty': stockBoxQty,
        'StockPcsQty': stockPcsQty,
        'Weight': weight,
        'IsWeight': isWeight,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [SalesOrderDetail].
  factory SalesOrderDetail.fromJson(String data) {
    return SalesOrderDetail.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [SalesOrderDetail] to a JSON string.
  String toJson() => json.encode(toMap());

  SalesOrderDetail copyWith({
    int? orgId,
    String? tranNo,
    int? slNo,
    String? productCode,
    String? productName,
    int? boxQty,
    int? pcsQty,
    int? qty,
    int? boxCount,
    double? boxPrice,
    int? price,
    int? foc,
    int? exchange,
    double? total,
    double? itemDiscount,
    double? itemDiscountPerc,
    double? subTotal,
    double? tax,
    double? netTotal,
    double? fBoxPrice,
    double? fPrice,
    double? fTotal,
    double? fItemDiscount,
    double? fSubTotal,
    double? fTax,
    double? fNetTotal,
    String? remarks,
    String? createdBy,
    String? createdOn,
    String? changedBy,
    String? changedOn,
    int? stockQty,
    int? stockBoxQty,
    int? stockPcsQty,
    double? weight,
    bool? isWeight,
  }) {
    return SalesOrderDetail(
      orgId: orgId ?? this.orgId,
      tranNo: tranNo ?? this.tranNo,
      slNo: slNo ?? this.slNo,
      productCode: productCode ?? this.productCode,
      productName: productName ?? this.productName,
      boxQty: boxQty ?? this.boxQty,
      pcsQty: pcsQty ?? this.pcsQty,
      qty: qty ?? this.qty,
      boxCount: boxCount ?? this.boxCount,
      boxPrice: boxPrice ?? this.boxPrice,
      price: price ?? this.price,
      foc: foc ?? this.foc,
      exchange: exchange ?? this.exchange,
      total: total ?? this.total,
      itemDiscount: itemDiscount ?? this.itemDiscount,
      itemDiscountPerc: itemDiscountPerc ?? this.itemDiscountPerc,
      subTotal: subTotal ?? this.subTotal,
      tax: tax ?? this.tax,
      netTotal: netTotal ?? this.netTotal,
      fBoxPrice: fBoxPrice ?? this.fBoxPrice,
      fPrice: fPrice ?? this.fPrice,
      fTotal: fTotal ?? this.fTotal,
      fItemDiscount: fItemDiscount ?? this.fItemDiscount,
      fSubTotal: fSubTotal ?? this.fSubTotal,
      fTax: fTax ?? this.fTax,
      fNetTotal: fNetTotal ?? this.fNetTotal,
      remarks: remarks ?? this.remarks,
      createdBy: createdBy ?? this.createdBy,
      createdOn: createdOn ?? this.createdOn,
      changedBy: changedBy ?? this.changedBy,
      changedOn: changedOn ?? this.changedOn,
      stockQty: stockQty ?? this.stockQty,
      stockBoxQty: stockBoxQty ?? this.stockBoxQty,
      stockPcsQty: stockPcsQty ?? this.stockPcsQty,
      weight: weight ?? this.weight,
      isWeight: isWeight ?? this.isWeight,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! SalesOrderDetail) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      orgId.hashCode ^
      tranNo.hashCode ^
      slNo.hashCode ^
      productCode.hashCode ^
      productName.hashCode ^
      boxQty.hashCode ^
      pcsQty.hashCode ^
      qty.hashCode ^
      boxCount.hashCode ^
      boxPrice.hashCode ^
      price.hashCode ^
      foc.hashCode ^
      exchange.hashCode ^
      total.hashCode ^
      itemDiscount.hashCode ^
      itemDiscountPerc.hashCode ^
      subTotal.hashCode ^
      tax.hashCode ^
      netTotal.hashCode ^
      fBoxPrice.hashCode ^
      fPrice.hashCode ^
      fTotal.hashCode ^
      fItemDiscount.hashCode ^
      fSubTotal.hashCode ^
      fTax.hashCode ^
      fNetTotal.hashCode ^
      remarks.hashCode ^
      createdBy.hashCode ^
      createdOn.hashCode ^
      changedBy.hashCode ^
      changedOn.hashCode ^
      stockQty.hashCode ^
      stockBoxQty.hashCode ^
      stockPcsQty.hashCode ^
      weight.hashCode ^
      isWeight.hashCode;
}
