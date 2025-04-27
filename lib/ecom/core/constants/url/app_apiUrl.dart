class ApiUrl {
  static const baseUrl = 'https://real-time-amazon-data.p.rapidapi.com/';
  static const host = 'real-time-amazon-data.p.rapidapi.com';
  static const key = 'ec06247fd2mshe27f87049c5fef8p1ced56jsn2fe21f0a6890'; // only for demo not for production
  
  static const String category = 'electronics';
  static const String type = 'BEST_SELLERS';
  static const String country = 'IN';
  static const int page = 1;

  static String productsUrl = 'best-sellers?category=$category&type=$type&page=$page&country=$country';

}
