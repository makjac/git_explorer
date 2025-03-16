import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:git_explorer/pages/repo_issues/api/fetch_repo_issues_api.dart';
import 'package:git_explorer/pages/repo_issues/models/repo_issue/repo_issue.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/fixture_reader.dart';
import 'fetch_repo_issues_api_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late MockDio mockDio;
  late FetchRepoIssuesApiImpl fetchRepoIssuesApi;

  setUp(() {
    mockDio = MockDio();
    fetchRepoIssuesApi = FetchRepoIssuesApiImpl(dio: mockDio);
  });

  group('FetchRepoIssuesApi', () {
    const fullName = 'owner/repo';
    const page = 1;

    test('returns list of RepoIssue on successful response', () async {
      final responsePayload = fixtureList('repo_issues.json');

      when(
        mockDio.get<List<dynamic>>(any, cancelToken: anyNamed('cancelToken')),
      ).thenAnswer(
        (_) async => Response(
          data: responsePayload,
          statusCode: 200,
          requestOptions: RequestOptions(),
        ),
      );

      final result = await fetchRepoIssuesApi.call(
        fullName: fullName,
        page: page,
      );

      expect(result, isA<List<RepoIssue>>());
      expect(result?.first.state, 'open');
      expect(result?.first.comments, 1);
      expect(
        result?.first.title,
        '[flutter_releases] Flutter beta 3.31.0-0.1.pre',
      );
      expect(result?.length, responsePayload.length);
    });

    test('returns null on non-200 response', () async {
      when(
        mockDio.get<List<dynamic>>(any, cancelToken: anyNamed('cancelToken')),
      ).thenAnswer(
        (_) async =>
            Response(statusCode: 404, requestOptions: RequestOptions()),
      );

      final result = await fetchRepoIssuesApi.call(
        fullName: fullName,
        page: page,
      );

      expect(result, isNull);
    });

    test('returns empty list on empty response data', () async {
      when(
        mockDio.get<List<dynamic>>(any, cancelToken: anyNamed('cancelToken')),
      ).thenAnswer(
        (_) async => Response(
          data: [],
          statusCode: 200,
          requestOptions: RequestOptions(),
        ),
      );

      final result = await fetchRepoIssuesApi.call(
        fullName: fullName,
        page: page,
      );

      expect(result, isA<List<RepoIssue>>());
      expect(result, isEmpty);
    });
  });
}
