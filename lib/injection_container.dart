import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:git_explorer/core/api/interceptors/interceptors.dart';
import 'package:git_explorer/core/localization/localization_cubit.dart';
import 'package:git_explorer/core/theme/theme_cubit.dart';
import 'package:git_explorer/pages/home/api/search_repo_api.dart';
import 'package:git_explorer/pages/home/cubit/search_repo_cubit.dart';
import 'package:git_explorer/pages/home/repository/repo_search_repository.dart';
import 'package:git_explorer/pages/repo_details/api/fetch_repo_details_api.dart';
import 'package:git_explorer/pages/repo_details/api/fetch_repo_reference_api.dart';
import 'package:git_explorer/pages/repo_details/api/fetch_repo_tree_api.dart';
import 'package:git_explorer/pages/repo_details/cubit/repo_details_cubit.dart';
import 'package:git_explorer/pages/repo_details/repository/repo_details_repository.dart';
import 'package:git_explorer/pages/repo_issues/api/fetch_repo_issues_api.dart';
import 'package:git_explorer/pages/repo_issues/cubit/repo_issues_cubit.dart';
import 'package:git_explorer/pages/repo_issues/repository/repo_issues_reposiotry.dart';
import 'package:git_explorer/pages/repo_pull_requests/api/fetch_repo_pull_request_api.dart';
import 'package:git_explorer/pages/repo_pull_requests/cubit/repo_pull_request_cubit.dart';
import 'package:git_explorer/pages/repo_pull_requests/repository/repo_pull_request_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'injection_container.main.dart';
