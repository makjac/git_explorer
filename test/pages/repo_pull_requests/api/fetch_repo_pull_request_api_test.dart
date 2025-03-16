import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:git_explorer/pages/repo_pull_requests/api/fetch_repo_pull_request_api.dart';
import 'package:git_explorer/pages/repo_pull_requests/models/repo_pull_request.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/fixture_reader.dart';
import 'fetch_repo_pull_request_api_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late MockDio mockDio;
  late FetchRepoPullRequestApiImpl api;

  setUp(() {
    mockDio = MockDio();
    api = FetchRepoPullRequestApiImpl(dio: mockDio);
  });

  group('FetchRepoPullRequestApiImpl', () {
    const fullName = 'owner/repo';
    const page = 1;

    test('returns list of RepoPullRequest on successful response', () async {
      final mockResponseData = fixtureList('repo_pull_request.json');

      when(mockDio.get<List<dynamic>>(any)).thenAnswer(
        (_) async => Response(
          data: mockResponseData,
          statusCode: 200,
          requestOptions: RequestOptions(),
        ),
      );

      final result = await api.call(fullName: fullName, page: page);

      expect(result, isA<List<RepoPullRequest>>());
      expect(result?.length, 2);
      expect(result?[0].number, 165259);
      expect(
        result?[0].title,
        '[Impeller] tear down swapchain when backgrounding.',
      );
      expect(result?[1].number, 165258);
      expect(result?[1].title, 'Delete `docs/infra/Infra-Ticket-Queue.md`');
    });

    test('returns null on non-200 response', () async {
      when(mockDio.get<List<dynamic>>(any)).thenAnswer(
        (_) async =>
            Response(statusCode: 404, requestOptions: RequestOptions()),
      );

      final result = await api.call(fullName: fullName, page: page);

      expect(result, isNull);
    });

    test('returns empty list on empty response data', () async {
      when(mockDio.get<List<dynamic>>(any)).thenAnswer(
        (_) async => Response(
          data: [],
          statusCode: 200,
          requestOptions: RequestOptions(),
        ),
      );

      final result = await api.call(fullName: fullName, page: page);

      expect(result, isA<List<RepoPullRequest>>());
      expect(result?.isEmpty, true);
    });
  });
}
