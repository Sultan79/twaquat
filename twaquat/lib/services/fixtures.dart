import 'package:dio/dio.dart';

Future<Response<dynamic>?> getTodayFixture() async {
  var dio = Dio();
  dio.options.headers['Content-Type'] = 'application/json';
  dio.options.headers['X-RapidAPI-Key'] =
      '81963c0fc3msh36436c771897f3bp129784jsn2ae053d4a1cf';
  return await dio.get(
    'https://api-football-v1.p.rapidapi.com/v3/fixtures',
    queryParameters: {
      'league': 1,
      'season': 2022,
      'timezone': 'Asia/Riyadh',
      'next': '3'
      // 'date': DateTime.now().toString().substring(0, 10)
      // 'date': '2022-11-21'
    },
  );
}

Future<Response<dynamic>?> getPastFixtures() async {
  var dio = Dio();
  dio.options.headers['Content-Type'] = 'application/json';
  dio.options.headers['X-RapidAPI-Key'] =
      '81963c0fc3msh36436c771897f3bp129784jsn2ae053d4a1cf';
  return await dio.get(
    'https://api-football-v1.p.rapidapi.com/v3/fixtures',
    queryParameters: {
      'league': 1,
      'season': 2022,
      'timezone': 'Asia/Riyadh',
      'status': "FT",
      // 'last': 2,
    },
  );
}

Future<Response<dynamic>?> getUpcomingFixtures() async {
  var dio = Dio();
  dio.options.headers['Content-Type'] = 'application/json';
  dio.options.headers['X-RapidAPI-Key'] =
      '81963c0fc3msh36436c771897f3bp129784jsn2ae053d4a1cf';
  return await dio.get(
    'https://api-football-v1.p.rapidapi.com/v3/fixtures',
    queryParameters: {
      'league': 1,
      'season': 2022,
      'timezone': 'Asia/Riyadh',
      // 'date': '2022-11-21' //DateTime.now().toString().substring(0, 10)
      'status': "NS",
    },
  );
}
