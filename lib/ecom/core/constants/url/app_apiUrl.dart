class ApiUrl {
  static const baseUrl = 'https://real-time-amazon-data.p.rapidapi.com/';
  static const host = 'real-time-amazon-data.p.rapidapi.com';
  static const key = '440122edc3mshc3a26a18048a22ap1e6aadjsn0f9977e265c8'; // only for demo not for production
  
  // used like this only for demo
  static const String category = 'electronics';
  static const String type = 'BEST_SELLERS';
  static const String country = 'IN';
  static const int page = 1;

  ////////////-------------------

  static String productsUrl = 'best-sellers?category=$category&type=$type&page=$page&country=$country';

  static String productDetailsUrl(String asin,) {
    return 'product-details?asin=$asin&country=$country';
  }
}
