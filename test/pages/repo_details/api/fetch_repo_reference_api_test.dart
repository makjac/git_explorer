import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:git_explorer/pages/repo_details/api/fetch_repo_reference_api.dart';
import 'package:git_explorer/pages/repo_details/models/repo_reference/repo_reference.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/fixture_reader.dart';
import 'fetch_repo_reference_api_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late MockDio mockDio;
  late FetchRepoReferenceApiImpl fetchRepoReferenceApi;

  setUp(() {
    mockDio = MockDio();
    fetchRepoReferenceApi = FetchRepoReferenceApiImpl(dio: mockDio);
  });

  group('FetchRepoReferenceApi', () {
    const fullName = 'owner/repo';
    const defaultBranch = 'main';

    test('returns RepoReference when the response status is 200', () async {
      final responseData = fixtureMap('repo_reference.json');

      when(mockDio.get<Map<String, dynamic>>(any)).thenAnswer(
        (_) async => Response(
          data: responseData,
          statusCode: 200,
          requestOptions: RequestOptions(),
        ),
      );

      final result = await fetchRepoReferenceApi.call(
        fullName: fullName,
        defaultBranch: defaultBranch,
      );

      expect(result, isA<RepoReference>());
      expect(result?.object?.sha, '208883fe1256fc3a29950350119de54b18074c28');
    });

    test('returns null when the response status is not 200 or 304', () async {
      when(mockDio.get<Map<String, dynamic>>(any)).thenAnswer(
        (_) async =>
            Response(statusCode: 404, requestOptions: RequestOptions()),
      );

      final result = await fetchRepoReferenceApi.call(
        fullName: fullName,
        defaultBranch: defaultBranch,
      );

      expect(result, isNull);
    });
  });
}
