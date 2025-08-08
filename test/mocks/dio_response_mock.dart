import 'package:dio/dio.dart';

Response<Map<String, dynamic>> mockCharacterResponse(
  RequestOptions requestOptions,
) {
  return Response(
    requestOptions: requestOptions,
    statusCode: 200,
    data: {
      'results': [
        {
          'id': 1,
          'name': 'Rick Sanchez',
          'status': 'Alive',
          'species': 'Human',
          'gender': 'Male',
          'image': 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
          'created': '2017-11-04T18:48:46.250Z',
        },
      ],
    },
  );
}
