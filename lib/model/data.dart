class Data {
  String vchrCustomerMobile;
  int pkIntEnquiryId;
  String vchrCustomerName;
  String vchrPurpose;
  String vchrStatus;
  String createdAt;
  String createdDate;

  Data(
      {this.vchrCustomerMobile,
        this.pkIntEnquiryId,
        this.vchrCustomerName,
        this.vchrPurpose,
        this.vchrStatus,
        this.createdAt,
        this.createdDate});

  Data.fromJson(Map<String, dynamic> json) {
    vchrCustomerMobile = json['vchr_customer_mobile'];
    pkIntEnquiryId = json['pk_int_enquiry_id'];
    vchrCustomerName = json['vchr_customer_name'];
    vchrPurpose = json['vchr_purpose'];
    vchrStatus = json['vchr_status'];
    createdAt = json['created_at'];
    createdDate = json['created_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vchr_customer_mobile'] = this.vchrCustomerMobile;
    data['pk_int_enquiry_id'] = this.pkIntEnquiryId;
    data['vchr_customer_name'] = this.vchrCustomerName;
    data['vchr_purpose'] = this.vchrPurpose;
    data['vchr_status'] = this.vchrStatus;
    data['created_at'] = this.createdAt;
    data['created_date'] = this.createdDate;
    return data;
  }
}