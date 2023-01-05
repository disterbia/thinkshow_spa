class ProductImageModel {
  String message;
  int statusCode;
  String url;
  String path;


  ProductImageModel({
    required this.message,
    required this.statusCode,
    required this.url,
    required this.path,
  });

}

class ProductImageModel2 {
  String message;
  int statusCode;
  List<dynamic> url;
  List<dynamic> path;


  ProductImageModel2({
    required this.message,
    required this.statusCode,
    required this.url,
    required this.path,
  });

}