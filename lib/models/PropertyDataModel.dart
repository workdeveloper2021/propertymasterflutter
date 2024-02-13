class PropertyDataModel {
  bool? status;
  List<Listing>? listing;
  String? message;

  PropertyDataModel({this.status, this.listing, this.message});

  PropertyDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['listing'] != null) {
      listing = <Listing>[];
      json['listing'].forEach((v) {
        listing!.add(new Listing.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.listing != null) {
      data['listing'] = this.listing!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Listing {
  String? id;
  String? propertyTitle;
  String? about;
  String? detail;
  String? location;
  String? images;
  String? image;
  String? insertTime;
  String? status;

  Listing(
      {this.id,
        this.propertyTitle,
        this.about,
        this.detail,
        this.location,
        this.images,
        this.image,
        this.insertTime,
        this.status});

  Listing.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    propertyTitle = json['property_title'];
    about = json['about'];
    detail = json['detail'];
    location = json['location'];
    images = json['images'];
    image = json['image'];
    insertTime = json['insert_time'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['property_title'] = this.propertyTitle;
    data['about'] = this.about;
    data['detail'] = this.detail;
    data['location'] = this.location;
    data['images'] = this.images;
    data['image'] = this.image;
    data['insert_time'] = this.insertTime;
    data['status'] = this.status;
    return data;
  }
}
