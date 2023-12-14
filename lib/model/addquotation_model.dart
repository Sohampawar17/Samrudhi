class AddQuotation {
  String? name;
  String? owner;
  String? modifiedBy;
  int? docstatus;
  int? idx;
  String? title;
  String? namingSeries;
  String? quotationTo;
  String? partyName;
  String? customerName;
  int? isReverseCharge;
  int? isExportWithGst;
  String? transactionDate;
  String? validTill;
  String? orderType;
  String? company;
  String? currency;
  double? conversionRate;
  String? sellingPriceList;
  String? priceListCurrency;
  double? plcConversionRate;
  int? ignorePricingRule;
  double? totalQty;
  double? totalNetWeight;
  double? baseTotal;
  double? baseNetTotal;
  double? total;
  double? netTotal;
  String? taxCategory;
  String? taxesAndCharges;
  double? baseTotalTaxesAndCharges;
  double? totalTaxesAndCharges;
  double? baseGrandTotal;
  double? baseRoundingAdjustment;
  double? baseRoundedTotal;
  String? baseInWords;
  double? grandTotal;
  double? roundingAdjustment;
  double? roundedTotal;
  String? inWords;
  String? applyDiscountOn;
  double? baseDiscountAmount;
  double? additionalDiscountPercentage;
  double? discountAmount;
  String? otherChargesCalculation;
  String? gstCategory;
  String? placeOfSupply;
  String? contactDisplay;
  String? contactMobile;
  String? contactEmail;
  String? companyAddress;
  String? companyGstin;
  String? companyAddressDisplay;
  int? groupSameItems;
  String? language;
  String? status;
  String? customerGroup;
  String? territory;
  String? doctype;
  List<PaymentSchedule>? paymentSchedule;
  List<Items>? items;
  List<Taxes>? taxes;

  AddQuotation(
      {this.name,
        this.owner,
        this.modifiedBy,
        this.docstatus,
        this.idx,
        this.title,
        this.namingSeries,
        this.quotationTo,
        this.partyName,
        this.customerName,
        this.isReverseCharge,
        this.isExportWithGst,
        this.transactionDate,
        this.validTill,
        this.orderType,
        this.company,
        this.currency,
        this.conversionRate,
        this.sellingPriceList,
        this.priceListCurrency,
        this.plcConversionRate,
        this.ignorePricingRule,
        this.totalQty,
        this.totalNetWeight,
        this.baseTotal,
        this.baseNetTotal,
        this.total,
        this.netTotal,
        this.taxCategory,
        this.taxesAndCharges,
        this.baseTotalTaxesAndCharges,
        this.totalTaxesAndCharges,
        this.baseGrandTotal,
        this.baseRoundingAdjustment,
        this.baseRoundedTotal,
        this.baseInWords,
        this.grandTotal,
        this.roundingAdjustment,
        this.roundedTotal,
        this.inWords,
        this.applyDiscountOn,
        this.baseDiscountAmount,
        this.additionalDiscountPercentage,
        this.discountAmount,
        this.otherChargesCalculation,
        this.gstCategory,
        this.placeOfSupply,
        this.contactDisplay,
        this.contactMobile,
        this.contactEmail,
        this.companyAddress,
        this.companyGstin,
        this.companyAddressDisplay,
        this.groupSameItems,
        this.language,
        this.status,
        this.customerGroup,
        this.territory,
        this.doctype,
        this.paymentSchedule,
        this.items,
        this.taxes});

  AddQuotation.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    modifiedBy = json['modified_by'];
    docstatus = json['docstatus'];
    idx = json['idx'];
    title = json['title'];
    namingSeries = json['naming_series'];
    quotationTo = json['quotation_to'];
    partyName = json['party_name'];
    customerName = json['customer_name'];
    isReverseCharge = json['is_reverse_charge'];
    isExportWithGst = json['is_export_with_gst'];
    transactionDate = json['transaction_date'];
    validTill = json['valid_till'];
    orderType = json['order_type'];
    company = json['company'];
    currency = json['currency'];
    conversionRate = json['conversion_rate'];
    sellingPriceList = json['selling_price_list'];
    priceListCurrency = json['price_list_currency'];
    plcConversionRate = json['plc_conversion_rate'];
    ignorePricingRule = json['ignore_pricing_rule'];
    totalQty = json['total_qty'];
    totalNetWeight = json['total_net_weight'];
    baseTotal = json['base_total'];
    baseNetTotal = json['base_net_total'];
    total = json['total'];
    netTotal = json['net_total'];
    taxCategory = json['tax_category'];
    taxesAndCharges = json['taxes_and_charges'];
    baseTotalTaxesAndCharges = json['base_total_taxes_and_charges'];
    totalTaxesAndCharges = json['total_taxes_and_charges'];
    baseGrandTotal = json['base_grand_total'];
    baseRoundingAdjustment = json['base_rounding_adjustment'];
    baseRoundedTotal = json['base_rounded_total'];
    baseInWords = json['base_in_words'];
    grandTotal = json['grand_total'];
    roundingAdjustment = json['rounding_adjustment'];
    roundedTotal = json['rounded_total'];
    inWords = json['in_words'];
    applyDiscountOn = json['apply_discount_on'];
    baseDiscountAmount = json['base_discount_amount'];
    additionalDiscountPercentage = json['additional_discount_percentage'];
    discountAmount = json['discount_amount'];
    otherChargesCalculation = json['other_charges_calculation'];
    gstCategory = json['gst_category'];
    placeOfSupply = json['place_of_supply'];
    contactDisplay = json['contact_display'];
    contactMobile = json['contact_mobile'];
    contactEmail = json['contact_email'];
    companyAddress = json['company_address'];
    companyGstin = json['company_gstin'];
    companyAddressDisplay = json['company_address_display'];
    groupSameItems = json['group_same_items'];
    language = json['language'];
    status = json['status'];
    customerGroup = json['customer_group'];
    territory = json['territory'];
    doctype = json['doctype'];
    if (json['payment_schedule'] != null) {
      paymentSchedule = <PaymentSchedule>[];
      json['payment_schedule'].forEach((v) {
        paymentSchedule!.add(new PaymentSchedule.fromJson(v));
      });
    }
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    if (json['taxes'] != null) {
      taxes = <Taxes>[];
      json['taxes'].forEach((v) {
        taxes!.add(new Taxes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['owner'] = this.owner;
    data['modified_by'] = this.modifiedBy;
    data['docstatus'] = this.docstatus;
    data['idx'] = this.idx;
    data['title'] = this.title;
    data['naming_series'] = this.namingSeries;
    data['quotation_to'] = this.quotationTo;
    data['party_name'] = this.partyName;
    data['customer_name'] = this.customerName;
    data['is_reverse_charge'] = this.isReverseCharge;
    data['is_export_with_gst'] = this.isExportWithGst;
    data['transaction_date'] = this.transactionDate;
    data['valid_till'] = this.validTill;
    data['order_type'] = this.orderType;
    data['company'] = this.company;
    data['currency'] = this.currency;
    data['conversion_rate'] = this.conversionRate;
    data['selling_price_list'] = this.sellingPriceList;
    data['price_list_currency'] = this.priceListCurrency;
    data['plc_conversion_rate'] = this.plcConversionRate;
    data['ignore_pricing_rule'] = this.ignorePricingRule;
    data['total_qty'] = this.totalQty;
    data['total_net_weight'] = this.totalNetWeight;
    data['base_total'] = this.baseTotal;
    data['base_net_total'] = this.baseNetTotal;
    data['total'] = this.total;
    data['net_total'] = this.netTotal;
    data['tax_category'] = this.taxCategory;
    data['taxes_and_charges'] = this.taxesAndCharges;
    data['base_total_taxes_and_charges'] = this.baseTotalTaxesAndCharges;
    data['total_taxes_and_charges'] = this.totalTaxesAndCharges;
    data['base_grand_total'] = this.baseGrandTotal;
    data['base_rounding_adjustment'] = this.baseRoundingAdjustment;
    data['base_rounded_total'] = this.baseRoundedTotal;
    data['base_in_words'] = this.baseInWords;
    data['grand_total'] = this.grandTotal;
    data['rounding_adjustment'] = this.roundingAdjustment;
    data['rounded_total'] = this.roundedTotal;
    data['in_words'] = this.inWords;
    data['apply_discount_on'] = this.applyDiscountOn;
    data['base_discount_amount'] = this.baseDiscountAmount;
    data['additional_discount_percentage'] = this.additionalDiscountPercentage;
    data['discount_amount'] = this.discountAmount;
    data['other_charges_calculation'] = this.otherChargesCalculation;
    data['gst_category'] = this.gstCategory;
    data['place_of_supply'] = this.placeOfSupply;
    data['contact_display'] = this.contactDisplay;
    data['contact_mobile'] = this.contactMobile;
    data['contact_email'] = this.contactEmail;
    data['company_address'] = this.companyAddress;
    data['company_gstin'] = this.companyGstin;
    data['company_address_display'] = this.companyAddressDisplay;
    data['group_same_items'] = this.groupSameItems;
    data['language'] = this.language;
    data['status'] = this.status;
    data['customer_group'] = this.customerGroup;
    data['territory'] = this.territory;
    data['doctype'] = this.doctype;
    if (this.paymentSchedule != null) {
      data['payment_schedule'] =
          this.paymentSchedule!.map((v) => v.toJson()).toList();
    }
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    if (this.taxes != null) {
      data['taxes'] = this.taxes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PaymentSchedule {
  String? name;
  String? owner;
  String? creation;
  String? modified;
  String? modifiedBy;
  int? docstatus;
  int? idx;
  String? dueDate;
  double? invoicePortion;
  double? discount;
  double? paymentAmount;
  double? outstanding;
  double? paidAmount;
  double? discountedAmount;
  double? basePaymentAmount;
  String? parent;
  String? parentfield;
  String? parenttype;
  String? doctype;

  PaymentSchedule(
      {this.name,
        this.owner,
        this.creation,
        this.modified,
        this.modifiedBy,
        this.docstatus,
        this.idx,
        this.dueDate,
        this.invoicePortion,
        this.discount,
        this.paymentAmount,
        this.outstanding,
        this.paidAmount,
        this.discountedAmount,
        this.basePaymentAmount,
        this.parent,
        this.parentfield,
        this.parenttype,
        this.doctype});

  PaymentSchedule.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    creation = json['creation'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    docstatus = json['docstatus'];
    idx = json['idx'];
    dueDate = json['due_date'];
    invoicePortion = json['invoice_portion'];
    discount = json['discount'];
    paymentAmount = json['payment_amount'];
    outstanding = json['outstanding'];
    paidAmount = json['paid_amount'];
    discountedAmount = json['discounted_amount'];
    basePaymentAmount = json['base_payment_amount'];
    parent = json['parent'];
    parentfield = json['parentfield'];
    parenttype = json['parenttype'];
    doctype = json['doctype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['owner'] = this.owner;
    data['creation'] = this.creation;
    data['modified'] = this.modified;
    data['modified_by'] = this.modifiedBy;
    data['docstatus'] = this.docstatus;
    data['idx'] = this.idx;
    data['due_date'] = this.dueDate;
    data['invoice_portion'] = this.invoicePortion;
    data['discount'] = this.discount;
    data['payment_amount'] = this.paymentAmount;
    data['outstanding'] = this.outstanding;
    data['paid_amount'] = this.paidAmount;
    data['discounted_amount'] = this.discountedAmount;
    data['base_payment_amount'] = this.basePaymentAmount;
    data['parent'] = this.parent;
    data['parentfield'] = this.parentfield;
    data['parenttype'] = this.parenttype;
    data['doctype'] = this.doctype;
    return data;
  }
}

class Items {
  // String? name;
  String? owner;
  String? creation;
  String? modified;
  String? modifiedBy;
  int? docstatus;
  int? idx;
  String? itemCode;
  String? itemName;
  String? description;
  String? gstHsnCode;
  int? isNilExempt;
  int? isNonGst;
  String? itemGroup;
  String? image;
  double? qty;
  String? stockUom;
  String? uom;
  double? conversionFactor;
  double? stockQty;
  double? priceListRate;
  double? basePriceListRate;
  String? marginType;
  double? marginRateOrAmount;
  double? rateWithMargin;
  double? discountPercentage;
  double? discountAmount;
  double? baseRateWithMargin;
  double? rate;
  double? netRate;
  double? amount;
  double? netAmount;
  String? itemTaxTemplate;
  double? baseRate;
  double? baseNetRate;
  double? baseAmount;
  double? baseNetAmount;
  String? pricingRules;
  double? stockUomRate;
  int? isFreeItem;
  int? isAlternative;
  int? hasAlternativeItem;
  double? valuationRate;
  double? grossProfit;
  double? weightPerUnit;
  double? totalWeight;
  int? againstBlanketOrder;
  double? blanketOrderRate;
  double? projectedQty;
  double? actualQty;
  String? itemTaxRate;
  int? pageBreak;
  String? parent;
  String? parentfield;
  String? parenttype;
  String? doctype;

  Items(
      {
        // this.name,
        this.owner,
        this.creation,
        this.modified,
        this.modifiedBy,
        this.docstatus,
        this.idx,
        this.itemCode,
        this.itemName,
        this.description,
        this.gstHsnCode,
        this.isNilExempt,
        this.isNonGst,
        this.itemGroup,
        this.image,
        this.qty,
        this.stockUom,
        this.uom,
        this.conversionFactor,
        this.stockQty,
        this.priceListRate,
        this.basePriceListRate,
        this.marginType,
        this.marginRateOrAmount,
        this.rateWithMargin,
        this.discountPercentage,
        this.discountAmount,
        this.baseRateWithMargin,
        this.rate,
        this.netRate,
        this.amount,
        this.netAmount,
        this.itemTaxTemplate,
        this.baseRate,
        this.baseNetRate,
        this.baseAmount,
        this.baseNetAmount,
        this.pricingRules,
        this.stockUomRate,
        this.isFreeItem,
        this.isAlternative,
        this.hasAlternativeItem,
        this.valuationRate,
        this.grossProfit,
        this.weightPerUnit,
        this.totalWeight,
        this.againstBlanketOrder,
        this.blanketOrderRate,
        this.projectedQty,
        this.actualQty,
        this.itemTaxRate,
        this.pageBreak,
        this.parent,
        this.parentfield,
        this.parenttype,
        this.doctype});

  Items.fromJson(Map<String, dynamic> json) {
    // name = json['name'];
    owner = json['owner'];
    creation = json['creation'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    docstatus = json['docstatus'];
    idx = json['idx'];
    itemCode = json['item_code'];
    itemName = json['item_name'];
    description = json['description'];
    gstHsnCode = json['gst_hsn_code'];
    isNilExempt = json['is_nil_exempt'];
    isNonGst = json['is_non_gst'];
    itemGroup = json['item_group'];
    image = json['image'];
    qty = json['qty'];
    stockUom = json['stock_uom'];
    uom = json['uom'];
    conversionFactor = json['conversion_factor'];
    stockQty = json['stock_qty'];
    priceListRate = json['price_list_rate'];
    basePriceListRate = json['base_price_list_rate'];
    marginType = json['margin_type'];
    marginRateOrAmount = json['margin_rate_or_amount'];
    rateWithMargin = json['rate_with_margin'];
    discountPercentage = json['discount_percentage'];
    discountAmount = json['discount_amount'];
    baseRateWithMargin = json['base_rate_with_margin'];
    rate = json['rate'];
    netRate = json['net_rate'];
    amount = json['amount'];
    netAmount = json['net_amount'];
    itemTaxTemplate = json['item_tax_template'];
    baseRate = json['base_rate'];
    baseNetRate = json['base_net_rate'];
    baseAmount = json['base_amount'];
    baseNetAmount = json['base_net_amount'];
    pricingRules = json['pricing_rules'];
    stockUomRate = json['stock_uom_rate'];
    isFreeItem = json['is_free_item'];
    isAlternative = json['is_alternative'];
    hasAlternativeItem = json['has_alternative_item'];
    valuationRate = json['valuation_rate'];
    grossProfit = json['gross_profit'];
    weightPerUnit = json['weight_per_unit'];
    totalWeight = json['total_weight'];
    againstBlanketOrder = json['against_blanket_order'];
    blanketOrderRate = json['blanket_order_rate'];
    projectedQty = json['projected_qty'];
    actualQty = json['actual_qty'];
    itemTaxRate = json['item_tax_rate'];
    pageBreak = json['page_break'];
    parent = json['parent'];
    parentfield = json['parentfield'];
    parenttype = json['parenttype'];
    doctype = json['doctype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['name'] = this.name;
    data['owner'] = this.owner;
    data['creation'] = this.creation;
    data['modified'] = this.modified;
    data['modified_by'] = this.modifiedBy;
    data['docstatus'] = this.docstatus;
    data['idx'] = this.idx;
    data['item_code'] = this.itemCode;
    data['item_name'] = this.itemName;
    data['description'] = this.description;
    data['gst_hsn_code'] = this.gstHsnCode;
    data['is_nil_exempt'] = this.isNilExempt;
    data['is_non_gst'] = this.isNonGst;
    data['item_group'] = this.itemGroup;
    data['image'] = this.image;
    data['qty'] = this.qty;
    data['stock_uom'] = this.stockUom;
    data['uom'] = this.uom;
    data['conversion_factor'] = this.conversionFactor;
    data['stock_qty'] = this.stockQty;
    data['price_list_rate'] = this.priceListRate;
    data['base_price_list_rate'] = this.basePriceListRate;
    data['margin_type'] = this.marginType;
    data['margin_rate_or_amount'] = this.marginRateOrAmount;
    data['rate_with_margin'] = this.rateWithMargin;
    data['discount_percentage'] = this.discountPercentage;
    data['discount_amount'] = this.discountAmount;
    data['base_rate_with_margin'] = this.baseRateWithMargin;
    data['rate'] = this.rate;
    data['net_rate'] = this.netRate;
    data['amount'] = this.amount;
    data['net_amount'] = this.netAmount;
    data['item_tax_template'] = this.itemTaxTemplate;
    data['base_rate'] = this.baseRate;
    data['base_net_rate'] = this.baseNetRate;
    data['base_amount'] = this.baseAmount;
    data['base_net_amount'] = this.baseNetAmount;
    data['pricing_rules'] = this.pricingRules;
    data['stock_uom_rate'] = this.stockUomRate;
    data['is_free_item'] = this.isFreeItem;
    data['is_alternative'] = this.isAlternative;
    data['has_alternative_item'] = this.hasAlternativeItem;
    data['valuation_rate'] = this.valuationRate;
    data['gross_profit'] = this.grossProfit;
    data['weight_per_unit'] = this.weightPerUnit;
    data['total_weight'] = this.totalWeight;
    data['against_blanket_order'] = this.againstBlanketOrder;
    data['blanket_order_rate'] = this.blanketOrderRate;
    data['projected_qty'] = this.projectedQty;
    data['actual_qty'] = this.actualQty;
    data['item_tax_rate'] = this.itemTaxRate;
    data['page_break'] = this.pageBreak;
    data['parent'] = this.parent;
    data['parentfield'] = this.parentfield;
    data['parenttype'] = this.parenttype;
    data['doctype'] = this.doctype;
    return data;
  }
}

class Taxes {
  String? name;
  String? owner;
  String? creation;
  String? modified;
  String? modifiedBy;
  int? docstatus;
  int? idx;
  String? chargeType;
  String? accountHead;
  String? description;
  int? includedInPrintRate;
  int? includedInPaidAmount;
  String? costCenter;
  double? rate;
  double? taxAmount;
  double? total;
  double? taxAmountAfterDiscountAmount;
  double? baseTaxAmount;
  double? baseTotal;
  double? baseTaxAmountAfterDiscountAmount;
  String? itemWiseTaxDetail;
  int? dontRecomputeTax;
  String? parent;
  String? parentfield;
  String? parenttype;
  String? doctype;

  Taxes(
      {this.name,
        this.owner,
        this.creation,
        this.modified,
        this.modifiedBy,
        this.docstatus,
        this.idx,
        this.chargeType,
        this.accountHead,
        this.description,
        this.includedInPrintRate,
        this.includedInPaidAmount,
        this.costCenter,
        this.rate,
        this.taxAmount,
        this.total,
        this.taxAmountAfterDiscountAmount,
        this.baseTaxAmount,
        this.baseTotal,
        this.baseTaxAmountAfterDiscountAmount,
        this.itemWiseTaxDetail,
        this.dontRecomputeTax,
        this.parent,
        this.parentfield,
        this.parenttype,
        this.doctype});

  Taxes.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    creation = json['creation'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    docstatus = json['docstatus'];
    idx = json['idx'];
    chargeType = json['charge_type'];
    accountHead = json['account_head'];
    description = json['description'];
    includedInPrintRate = json['included_in_print_rate'];
    includedInPaidAmount = json['included_in_paid_amount'];
    costCenter = json['cost_center'];
    rate = json['rate'];
    taxAmount = json['tax_amount'];
    total = json['total'];
    taxAmountAfterDiscountAmount = json['tax_amount_after_discount_amount'];
    baseTaxAmount = json['base_tax_amount'];
    baseTotal = json['base_total'];
    baseTaxAmountAfterDiscountAmount =
    json['base_tax_amount_after_discount_amount'];
    itemWiseTaxDetail = json['item_wise_tax_detail'];
    dontRecomputeTax = json['dont_recompute_tax'];
    parent = json['parent'];
    parentfield = json['parentfield'];
    parenttype = json['parenttype'];
    doctype = json['doctype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['owner'] = this.owner;
    data['creation'] = this.creation;
    data['modified'] = this.modified;
    data['modified_by'] = this.modifiedBy;
    data['docstatus'] = this.docstatus;
    data['idx'] = this.idx;
    data['charge_type'] = this.chargeType;
    data['account_head'] = this.accountHead;
    data['description'] = this.description;
    data['included_in_print_rate'] = this.includedInPrintRate;
    data['included_in_paid_amount'] = this.includedInPaidAmount;
    data['cost_center'] = this.costCenter;
    data['rate'] = this.rate;
    data['tax_amount'] = this.taxAmount;
    data['total'] = this.total;
    data['tax_amount_after_discount_amount'] =
        this.taxAmountAfterDiscountAmount;
    data['base_tax_amount'] = this.baseTaxAmount;
    data['base_total'] = this.baseTotal;
    data['base_tax_amount_after_discount_amount'] =
        this.baseTaxAmountAfterDiscountAmount;
    data['item_wise_tax_detail'] = this.itemWiseTaxDetail;
    data['dont_recompute_tax'] = this.dontRecomputeTax;
    data['parent'] = this.parent;
    data['parentfield'] = this.parentfield;
    data['parenttype'] = this.parenttype;
    data['doctype'] = this.doctype;
    return data;
  }
}
