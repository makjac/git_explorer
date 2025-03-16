import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:git_explorer/pages/repo_details/api/fetch_repo_tree_api.dart';
import 'package:git_explorer/pages/repo_details/models/repo_tree/repo_tree.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/fixture_reader.dart';
import 'fetch_repo_tree_api_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late FetchRepoTreeApiImpl fetchRepoTreeApi;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    fetchRepoTreeApi = FetchRepoTreeApiImpl(dio: mockDio);
  });

  group('FetchRepoTreeApi', () {
    const fullName = 'owner/repo';
    const sha = 'abc123';

    test('returns RepoTreeResponse when the call is successful', () async {
      final responsePayload = fixtureMap('repo_tree.json');

      when(mockDio.get<Map<String, dynamic>>(any)).thenAnswer(
        (_) async => Response(
          data: responsePayload,
          statusCode: 200,
          requestOptions: RequestOptions(),
        ),
      );

      final result = await fetchRepoTreeApi.call(fullName: fullName, sha: sha);

      expect(result, isA<RepoTreeResponse>());
      expect(result?.tree, isNotEmpty);
      expect(result?.tree?.first.path, '.ci.yaml');
      expect(result?.tree?.first.type, Type.blob);
      expect(result?.truncated, isFalse);
    });

    test('returns null when the call is unsuccessful', () async {
      when(mockDio.get<Map<String, dynamic>>(any)).thenAnswer(
        (_) async =>
            Response(statusCode: 404, requestOptions: RequestOptions()),
      );

      final result = await fetchRepoTreeApi.call(fullName: fullName, sha: sha);

      expect(result, isNull);
    });
  });
}
