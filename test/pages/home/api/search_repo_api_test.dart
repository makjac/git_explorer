import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:git_explorer/pages/home/api/search_repo_api.dart';
import 'package:git_explorer/pages/home/models/repo_search_response.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/fixture_reader.dart';
import 'search_repo_api_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late MockDio mockDio;
  late SearchRepoApiImpl searchRepoApi;

  setUp(() {
    mockDio = MockDio();
    searchRepoApi = SearchRepoApiImpl(dio: mockDio);
  });

  group('SearchRepoApiImpl', () {
    test('returns RepoSearchResponse when the call is successful', () async {
      const query = 'flutter';
      const page = 1;
      final responseData = fixtureMap('search_repositores_respone.json');

      when(
        mockDio.get<Map<String, dynamic>>(
          any,
          cancelToken: anyNamed('cancelToken'),
        ),
      ).thenAnswer(
        (_) async => Response(
          data: responseData,
          statusCode: 200,
          requestOptions: RequestOptions(),
        ),
      );

      final result = await searchRepoApi.call(query: query, page: page);

      expect(result, isA<RepoSearchResponse>());
      expect(result?.totalCount, 810875);
      expect(result?.items?.length, 30);
      expect(result?.items?.first.name, 'flutter');
      expect(
        result?.items?.first.description,
        'Flutter makes it easy and fast to build'
        ' beautiful apps for mobile and beyond',
      );
      expect(result?.items?.first.fullName, 'flutter/flutter');
      expect(
        result?.items?.first.owner?.avatarUrl,
        'https://avatars.githubusercontent.com/u/14101776?v=4',
      );
      expect(result?.items?.last.name, 'FlutterWhatsAppClone');
    });

    test('returns null when the call is unsuccessful', () async {
      const query = 'flutter';
      const page = 1;

      when(
        mockDio.get<Map<String, dynamic>>(
          any,
          cancelToken: anyNamed('cancelToken'),
        ),
      ).thenAnswer(
        (_) async =>
            Response(statusCode: 404, requestOptions: RequestOptions()),
      );

      final result = await searchRepoApi.call(query: query, page: page);

      expect(result, isNull);
    });
  });
}
