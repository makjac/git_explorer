import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:git_explorer/pages/repo_details/api/fetch_repo_details_api.dart';
import 'package:git_explorer/pages/repo_details/models/repo_details/repo_details.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/fixture_reader.dart';
import 'fetch_repo_details_api_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late MockDio mockDio;
  late FetchRepoDetailsApiImpl fetchRepoDetailsApi;

  setUp(() {
    mockDio = MockDio();
    fetchRepoDetailsApi = FetchRepoDetailsApiImpl(dio: mockDio);
  });

  group('FetchRepoDetailsApiImpl', () {
    const fullName = 'owner/repo';
    final repoDetailsJson = fixtureMap('repo_details.json');
    final repoDetails = RepoDetails.fromJson(repoDetailsJson);

    test('returns RepoDetails when the response status is 200', () async {
      when(mockDio.get<Map<String, dynamic>>(any)).thenAnswer(
        (_) async => Response(
          data: repoDetailsJson,
          statusCode: 200,
          requestOptions: RequestOptions(),
        ),
      );

      final result = await fetchRepoDetailsApi.call(fullName: fullName);

      expect(result, equals(repoDetails));
      expect(result?.fullName, 'flutter/flutter');
    });

    test('returns RepoDetails when the response status is 304', () async {
      when(mockDio.get<Map<String, dynamic>>(any)).thenAnswer(
        (_) async => Response(
          data: repoDetailsJson,
          statusCode: 304,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      final result = await fetchRepoDetailsApi.call(fullName: fullName);

      expect(result, equals(repoDetails));
    });

    test('returns null when the response status is not 200 or 304', () async {
      when(mockDio.get<Map<String, dynamic>>(any)).thenAnswer(
        (_) async => Response(
          data: null,
          statusCode: 404,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      final result = await fetchRepoDetailsApi.call(fullName: fullName);

      expect(result, isNull);
    });
  });
}
