import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:git_explorer/core/Localization/localization_cubit.dart';
import 'package:git_explorer/core/api/interceptors/interceptors.dart';
import 'package:git_explorer/core/theme/theme_cubit.dart';
import 'package:git_explorer/pages/home/api/search_repo_api.dart';
import 'package:git_explorer/pages/home/cubit/search_repo_cubit.dart';
import 'package:git_explorer/pages/home/repository/repo_search_repository.dart';
import 'package:git_explorer/pages/repo_details/api/fetch_repo_details_api.dart';
import 'package:git_explorer/pages/repo_details/api/fetch_repo_reference_api.dart';
import 'package:git_explorer/pages/repo_details/api/fetch_repo_tree_api.dart';
import 'package:git_explorer/pages/repo_details/cubit/repo_details_cubit.dart';
import 'package:git_explorer/pages/repo_details/repository/repo_details_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'injection_container.main.dart';
